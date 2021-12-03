require_relative 'lib/destatis/version'

Gem::Specification.new do |spec|
  spec.name          = 'destatis_regions'
  spec.version       = Destatis::VERSION
  spec.authors       = ['Stefan Wienert']
  spec.email         = ['info@stefanwienert.de']

  spec.summary       = '...'
  spec.description   = '...'
  spec.homepage      = 'https://github.com/pludoni/destatis_regions'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.add_dependency 'simple_xlsx_reader'
  spec.add_dependency 'zeitwerk'
end
