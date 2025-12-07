#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'build.rb'
require 'pathname'

# Rebuild all pages from extracted content files
# This ensures NO hardcoded headers/footers - everything uses the template system

class ContentRebuilder
  def initialize
    @engine = TemplateEngine.new
    @content_dir = Pathname.new('pages-content')
    @pages_dir = Pathname.new('pages')
  end

  def get_page_config(page_name)
    configs = {
      'index' => { 'title' => 'Home', 'page' => 'index' },
      'about' => { 'title' => 'About Us', 'page' => 'about' },
      'contact' => { 'title' => 'Contact', 'page' => 'contact' },
      'team' => { 'title' => 'Our Team', 'page' => 'team' },
      'services' => { 'title' => 'Our Services', 'page' => 'services' },
      'stories' => { 'title' => 'Success Stories', 'page' => 'stories' },
      'impact' => { 'title' => 'Our Impact', 'page' => 'impact' },
      'projects' => { 'title' => 'Projects', 'page' => 'projects' },
      'project-details' => { 'title' => 'Project Details', 'page' => 'project-details' },
      'blog' => { 'title' => 'Blog', 'page' => 'blog' },
      'blog-details' => { 'title' => 'Blog Details', 'page' => 'blog-details' },
      'faq' => { 'title' => 'FAQ', 'page' => 'faq' },
      'team-details' => { 'title' => 'Team Member Details', 'page' => 'team-details' },
      'service-details' => { 'title' => 'Service Details', 'page' => 'service-details' },
      'event-details' => { 'title' => 'Event Details', 'page' => 'event-details' },
      'donation-details' => { 'title' => 'Donation Details', 'page' => 'donation-details' },
      'donations' => { 'title' => 'Donations', 'page' => 'donations' },
      'events' => { 'title' => 'Events', 'page' => 'events' },
      '404' => { 'title' => '404 Not Found', 'page' => '404' }
    }
    
    base_name = File.basename(page_name, '.html')
    configs[base_name] || { 'title' => base_name.split('-').map(&:capitalize).join(' '), 'page' => base_name }
  end

  def rebuild_all
    puts "=" * 70
    puts "Rebuilding ALL pages from content files"
    puts "Removing hardcoded headers/footers - using template system!"
    puts "=" * 70
    puts
    
    rebuilt_count = 0
    
    # Process all content files
    @content_dir.find do |content_file|
      next unless content_file.file? && content_file.extname == '.html'
      
      rel_path = content_file.relative_path_from(@content_dir)
      page_name = rel_path.to_s
      
      puts "Rebuilding: #{page_name}..."
      
      content = File.read(content_file)
      next if content.nil? || content.strip.empty?
      
      # Get page config
      base_name = File.basename(content_file, '.html')
      config = get_page_config(base_name)
      config['header_class'] = 'ul-header-2'
      config['content'] = content
      
      begin
        @engine.build_page(page_name, config)
        rebuilt_count += 1
        puts "  ✓ Rebuilt #{page_name} (NO hardcoded header/footer)"
      rescue => e
        puts "  ✗ Error: #{e.message}"
        puts "    #{e.backtrace.first}"
      end
    end
    
    puts
    puts "=" * 70
    puts "✅ Rebuilt #{rebuilt_count} page(s)!"
    puts
    puts "All pages now use the template system:"
    puts "  • Header: templates/components/header.html"
    puts "  • Footer: templates/components/footer.html"
    puts
    puts "NO MORE hardcoded headers/footers in individual pages!"
    puts "=" * 70
  end
end

# Run if executed directly
if __FILE__ == $PROGRAM_NAME
  rebuilder = ContentRebuilder.new
  rebuilder.rebuild_all
end

