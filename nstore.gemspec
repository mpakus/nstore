# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nstore/version'

Gem::Specification.new do |spec|
  spec.name                  = 'nstore'
  spec.version               = NStore::VERSION
  spec.authors               = ['Renat "MpaK" Ibragimov']
  spec.email                 = ['mrak69@gmail.com']
  spec.license               = 'GPL-3'
  spec.summary               = 'NStore - nested attributes accessors.'
  spec.description           = 'Generates nested attributes accessors.'
  spec.homepage              = 'https://github.com/mpakus/nstore'
  spec.required_ruby_version = '>= 2.3.1'

  spec.metadata = {
    'changelog_uri' => 'https://github.com/mpakus/nstore/blob/master/CHANGELOG.md',
    'documentation_uri' => 'https://github.com/mpakus/nstore',
    'homepage_uri' => 'https://github.com/mpakus/nstore',
    'source_code_uri' => 'https://github.com/mpakus/nstore'
  }

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  #
  #   spec.metadata['homepage_uri'] = spec.homepage
  #   spec.metadata['source_code_uri'] = 'https://github.com/mpakus/nstore'
  #   spec.metadata['changelog_uri'] = 'https://github.com/mpakus/nstore/README.md'
  # else
  #   raise 'RubyGems 2.0 or newer is required to protect against ' \
  #     'public gem pushes.'
  # end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'activerecord', '~> 4.1.14.1'
  spec.add_development_dependency 'awesome_print'
  spec.add_development_dependency 'bundler', '~> 1.17'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.49'
  spec.add_development_dependency 'sqlite3', '~> 1.3.6'
end
