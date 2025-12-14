#!/usr/bin/env ruby
# frozen_string_literal: true

require 'erb'
require 'json'
require 'fileutils'
require 'pathname'

class TemplateEngine
  def initialize(template_dir: 'templates', output_dir: '.', config_file: 'templates/config.json')
    @template_dir = Pathname.new(template_dir)
    @output_dir = Pathname.new(output_dir)
    @config = load_config(config_file)
    @components_dir = @template_dir / 'components'
  end

  def load_config(config_file)
    return {} unless File.exist?(config_file)
    
    JSON.parse(File.read(config_file))
  rescue JSON::ParserError => e
    warn "Error parsing config file: #{e.message}"
    {}
  end

  def calculate_base_path(output_path)
    # Calculate depth from root directory
    # Files in root need no prefix (assets/)
    # Files in subdir/ need ../ to get to root (../assets/)
    # Files in subdir/nested/ need ../../ to get to root (../../assets/)
    depth = output_path.parent.to_s.split(File::SEPARATOR).reject(&:empty?).length
    # Files in root have depth 0
    return '' if depth <= 0
    
    '../' * depth
  end

  def render_template(template_content, _context)
    # Process includes first
    processed_content = process_includes(template_content, {})
    
    # Use current binding which has all instance variables
    template = ERB.new(processed_content, trim_mode: '-')
    template.result(binding)
  end

  def load_component(component_name)
    component_path = @components_dir / component_name
    return '' unless component_path.exist?
    
    File.read(component_path)
  end

  def build_page(page_file, page_config = {})
    # Load base template
    base_template_path = @template_dir / 'base.html'
    unless base_template_path.exist?
      warn "Error: Base template not found at #{base_template_path}"
      return
    end

    template_content = File.read(base_template_path)

    # Determine output path - pages go to root directory
    output_path = @output_dir / page_file
    output_path.parent.mkpath

    # Calculate base path for assets
    base_path = calculate_base_path(output_path)

    # Prepare context - use instance variables for ERB binding
    @site_name = @config['site_name'] || 'Site'
    @site_description = @config['site_description'] || ''
    @contact_info = @config['contact_info'] || {}
    @social_links = @config['social_links'] || {}
    @base_path = base_path
    @page_title = page_config['title'] || 'Page'
    @current_page = page_config['page'] || ''
    @header_class = page_config['header_class'] || 'ul-header-2'
    @content = page_config['content'] || ''
    @extra_css = page_config['extra_css'] || []
    @extra_js = page_config['extra_js'] || []
    @page_js = page_config['page_js'] || ''

    # Process includes and render template with ERB
    # ERB will handle the render calls during rendering
    rendered = render_template(template_content, {})

    # Write output
    File.write(output_path, rendered)
    puts "Built: #{output_path}"
  end

  def process_includes(content, _context)
    # Handle ERB includes: <%= render 'component.html' %>
    # Replace render calls with actual component content
    result = content.dup
    loop do
      original = result.dup
      result.gsub!(/<%=?\s*render\s+['"]([^'"]+)['"]\s*%>/) do |_match|
        component_name = Regexp.last_match(1)
        component_path = @components_dir / component_name
        if component_path.exist?
          component_content = File.read(component_path)
          # Recursively process includes in component
          process_includes(component_content, {})
        else
          "<!-- Component not found: #{component_name} -->"
        end
      end
      break if result == original # No more includes found
    end
    result
  end

  def build_all(pages_config)
    pages_config.each do |page_file, page_config|
      build_page(page_file, page_config)
    end
  end
end

# Main execution
if __FILE__ == $PROGRAM_NAME
  engine = TemplateEngine.new

  puts 'Ruby Template Builder'
  puts '=' * 50
  puts 'To build pages, use:'
  puts "  engine.build_page('output.html', {'title' => 'Page Title', 'page' => 'page-name', 'content' => '<h1>Content</h1>'})"
  puts "\nOr create a pages.json file with page configurations."
end

