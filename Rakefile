require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'rake/packagetask'
require 'rake/gempackagetask'

$:.unshift(File.dirname(__FILE__) + "/lib")
require 'phidgets4r'

PKG_NAME      = 'phidgets4r'
PKG_VERSION   = Phidgets::VERSION
PKG_FILE_NAME = "#{PKG_NAME}-#{PKG_VERSION}"

desc 'Default: run unit tests.'
task :default => :test

desc "Clean generated files"
task :clean do
  #rm FileList['test/']
  rm_rf 'pkg'
  rm_rf 'rdoc'
end

desc 'Test the phidgets4r gem.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.pattern = 'test/test_phidgets.rb'
  t.verbose = true
end

desc 'Generate documentation for the phidgets4r gem.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'phidgets4r'
  rdoc.options << '--line-numbers'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end


# Create compressed packages
spec = Gem::Specification.new do |s|
  s.platform = Gem::Platform::RUBY
  s.name = PKG_NAME
  s.summary = "Interact with Phidgets via Ruby."
  s.description = %q{Just a simple Ruby library to provide Ruby-style abstraction around the Phidgets C library.  Fork of the RubyForge phidget project.}
  s.version = PKG_VERSION

  s.author = "Kit Plummer"
  s.email = "kitplummer@gmail.com"
  s.rubyforge_project = PKG_NAME
  s.homepage = "http://github.com/kitplummer/phidgets4r"

  s.has_rdoc = true
  s.requirements << 'none'
  s.require_path = 'lib'
  s.files = [ "Rakefile", "README.rdoc", "GNU_GPL.txt" ]
  s.files = s.files + Dir.glob( "lib/**/*" ).delete_if { |item| item.include?( "\.svn" ) }
  s.files = s.files + Dir.glob( "resources/**/*" ).delete_if { |item| item.include?( "\.svn" ) }
  s.files = s.files + Dir.glob( "test/**/*" ).delete_if { |item| item.include?( "\.svn" ) || item.include?("\.png") }
end
  
Rake::GemPackageTask.new(spec) do |p|
  p.gem_spec = spec
  p.need_tar = false
  p.need_zip = true
end