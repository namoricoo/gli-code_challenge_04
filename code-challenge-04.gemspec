# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','code-challenge-04','version.rb'])
spec = Gem::Specification.new do |s| 
  s.name = 'code-challenge-04'
  s.version = CodeChallenge04::VERSION
  s.author = 'Your Name Here'
  s.email = 'your@email.address.com'
  s.homepage = 'http://your.website.com'
  s.platform = Gem::Platform::RUBY
  s.summary = 'A description of your project'
# Add your other files here if you make them
  s.files = %w(
bin/code-challenge-04
lib/code-challenge-04/version.rb
lib/code-challenge-04.rb
  )
  s.require_paths << 'lib'
  s.has_rdoc = true
  s.extra_rdoc_files = ['README.rdoc','code-challenge-04.rdoc']
  s.rdoc_options << '--title' << 'code-challenge-04' << '--main' << 'README.rdoc' << '-ri'
  s.bindir = 'bin'
  s.executables << 'code-challenge-04'
  s.add_development_dependency('rake')
  s.add_development_dependency('rdoc')
  s.add_development_dependency('aruba')
  s.add_runtime_dependency('gli','2.8.1')
end
