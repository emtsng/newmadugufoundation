# frozen_string_literal: true

require 'fileutils'
require 'pathname'

desc 'Build all pages from templates'
task :build do
  require_relative 'build.rb'
  engine = TemplateEngine.new
  
  # Example: Build pages from config
  # You can extend this to read from a pages.json file
  pages = {
    'index.html' => {
      'title' => 'Home',
      'page' => 'index',
      'header_class' => 'ul-header-2',
      'content' => '<h1>Welcome to our site</h1>'
    }
  }
  
  engine.build_all(pages)
end

desc 'Update headers in all HTML files'
task :update_headers do
  system('ruby update-headers.rb')
end

desc 'Install Ruby dependencies'
task :install do
  system('bundle install')
end

desc 'Clean build directory'
task :clean do
  FileUtils.rm_rf('build') if Dir.exist?('build')
  puts 'Build directory cleaned'
end

desc 'Run all build tasks'
task default: [:install, :update_headers, :build] do
  puts 'All tasks completed!'
end

