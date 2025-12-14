#!/usr/bin/env ruby
# frozen_string_literal: true

# Script to prepare the site for GitHub Pages deployment
# This script copies pages to root and fixes asset paths

require 'fileutils'
require 'pathname'

class GitHubPagesPreparer
  def initialize(source_dir: 'pages', output_dir: '_site', assets_dir: 'assets')
    @source_dir = Pathname.new(source_dir)
    @output_dir = Pathname.new(output_dir)
    @assets_dir = Pathname.new(assets_dir)
  end

  def prepare
    puts "Preparing site for GitHub Pages deployment..."
    
    # Clean output directory
    FileUtils.rm_rf(@output_dir) if @output_dir.exist?
    @output_dir.mkpath
    
    # Copy all pages to root of output directory (not as a subdirectory)
    puts "Copying pages..."
    if @source_dir.exist?
      # Copy each file/directory from pages/ directly to _site/ root
      @source_dir.children.each do |item|
        dest = @output_dir / item.basename
        if item.directory?
          FileUtils.cp_r(item, dest)
        else
          FileUtils.cp(item, dest)
        end
      end
      puts "  ✓ Copied pages from #{@source_dir} to #{@output_dir} root"
    else
      puts "  ✗ Error: Source directory #{@source_dir} does not exist"
      return false
    end
    
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

