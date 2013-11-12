# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'blast_commander/version'

Gem::Specification.new do |gem|
  gem.name          = 'blast_commander'
  gem.version       = BlastCommander::VERSION
  gem.authors       = ['Gareth Rees']
  gem.email         = ['gareth@garethrees.co.uk']
  gem.description   = %q{Simple wrapper around NCBI blastn CLI tool}
  gem.summary       = %q{Simple wrapper around NCBI blastn CLI tool}
  gem.homepage      = ''

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_dependency 'entrez'
  gem.add_dependency 'nori', '2.0.3'
  gem.add_dependency 'nokogiri'
  gem.add_dependency 'httparty'

end
