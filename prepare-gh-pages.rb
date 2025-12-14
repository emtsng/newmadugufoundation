#!/usr/bin/env ruby
# frozen_string_literal: true

# Script to prepare the site for GitHub Pages deployment
# This script copies pages to root and fixes asset paths

require 'fileutils'
require 'pathname'

class GitHubPagesPreparer
  def initialize(output_dir: '_site', assets_dir: 'assets')
    @output_dir = Pathname.new(output_dir)
    @assets_dir = Pathname.new(assets_dir)
    @root_dir = Pathname.new('.')
  end

  def prepare
    puts "Preparing site for GitHub Pages deployment..."
    
    # Clean output directory
    FileUtils.rm_rf(@output_dir) if @output_dir.exist?
    @output_dir.mkpath
    
    # Copy all HTML files and subdirectories from root to output directory
    puts "Copying HTML files and directories..."
    copied_count = 0
    
    # Copy HTML files from root
    @root_dir.glob('*.html').each do |html_file|
      next if html_file.basename.to_s.start_with?('_') # Skip files starting with _
      dest = @output_dir / html_file.basename
      FileUtils.cp(html_file, dest)
      copied_count += 1
    end
    
    # Copy subdirectories that contain HTML files (programs, get-involved, etc.)
    @root_dir.children.select(&:directory?).each do |dir|
      dir_name = dir.basename.to_s
      # Skip hidden directories and common build/output directories
      next if dir_name.start_with?('.') || dir_name == '_site' || dir_name == 'assets' || 
              dir_name == 'templates' || dir_name == 'pages-content' || dir_name == 'node_modules'
      
      # Check if directory contains HTML files
      if dir.glob('**/*.html').any?
        dest = @output_dir / dir_name
        FileUtils.cp_r(dir, dest)
        puts "  ✓ Copied directory: #{dir_name}/"
      end
    end
    
    puts "  ✓ Copied #{copied_count} HTML files from root to #{@output_dir}"
    
    # Copy assets directory
    puts "Copying assets..."
    if @assets_dir.exist?
      FileUtils.cp_r(@assets_dir, @output_dir)
      puts "  ✓ Copied assets from #{@assets_dir} to #{@output_dir}"
    else
      puts "  ✗ Warning: Assets directory #{@assets_dir} does not exist"
    end
    
    # Copy CNAME file if it exists
    cname_file = Pathname.new('CNAME')
    if cname_file.exist?
      FileUtils.cp(cname_file, @output_dir)
      puts "  ✓ Copied CNAME file"
    end
    
    # Fix asset paths in HTML files
    puts "Fixing asset paths in HTML files..."
    fix_asset_paths
    
    puts "\n✓ Site prepared successfully in #{@output_dir}"
    puts "  Ready for GitHub Pages deployment!"
    true
  end

  private

  def fix_asset_paths
    html_files = @output_dir.find.select { |f| f.file? && f.extname == '.html' }
    
    html_files.each do |html_file|
      content = File.read(html_file, encoding: 'UTF-8')
      original_content = content.dup
      
      # Calculate relative path from this file to assets
      relative_path = html_file.parent.relative_path_from(@output_dir)
      depth_str = relative_path.to_s
      # Handle both "." and empty string as root (depth 0)
      depth = if depth_str == '.' || depth_str.empty?
        0
      else
        depth_str.split(File::SEPARATOR).reject { |p| p.empty? || p == '.' }.length
      end
      
      # Determine correct asset path based on file location
      if depth == 0
        # Files in root: assets/ (no ../)
        # Replace all occurrences of ../assets/ with assets/
        content = content.gsub('../assets/', 'assets/')
      else
        # Files in subdirectories: ../assets/ (one level up)
        # Replace ../../assets/ with ../assets/
        content = content.gsub('../../assets/', '../assets/')
        # Also handle any deeper nesting (shouldn't happen, but just in case)
        content = content.gsub(/\.\.\/\.\.\/\.\.\/assets\//, '../../assets/')
      end
      
      # Fix page links to use relative paths from root
      if depth == 0
        # Root files: ./page.html or just page.html (both work)
        # Don't change links that already have ./ or ../
        content = content.gsub(/href=["'](?!\.\.?\/)(index|about|contact|blog|events|donations|impact|stories|team|projects|services|faq)\.html["']/i, 'href="./\1.html"')
      else
        # Subdirectory files: ../page.html
        content = content.gsub(/href=["'](?!\.\.?\/)(index|about|contact|blog|events|donations|impact|stories|team|projects|services|faq)\.html["']/i, 'href="../\1.html"')
      end
      
      # Write back if changed
      if content != original_content
        File.write(html_file, content, encoding: 'UTF-8')
        puts "  ✓ Fixed paths in #{html_file.relative_path_from(@output_dir)}"
      end
    end
  end
end

# Main execution
if __FILE__ == $PROGRAM_NAME
  preparer = GitHubPagesPreparer.new
  exit 1 unless preparer.prepare
end

