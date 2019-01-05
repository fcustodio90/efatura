
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'efatura/version'

Gem::Specification.new do |spec|
  spec.name          = 'efatura'
  spec.version       = Efatura::VERSION
  spec.authors       = ['filipe custodio']
  spec.email         = ['filipe.l.custodio@gmail.com']

  spec.summary       = %q{Scraper for efatura PT website}
  spec.description   = %q{efatura gem uses mechanize in order to login from the backend to efatura website to retrieve invoice information}
  spec.homepage      = "https://github.com/fcustodio90/efatura"
  spec.license       = 'MIT'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'mechanize'
  spec.add_dependency 'rest-client'

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'pry-byebug'
end
