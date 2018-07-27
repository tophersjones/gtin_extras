lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gtin_extras/version'

Gem::Specification.new do |spec|
  spec.name          = 'gtin_extras'
  spec.version       = GTINExtras::VERSION
  spec.authors       = ['Josh Beckman']
  spec.email         = ['josh@officeluv.com']

  spec.summary       = 'Ruby string extensions for validating GTIN/UPC/EAN/ASIN/GS1 numbers and formatting'
  spec.description   = 'Ruby string extensions for validating GTIN/UPC/EAN/ASIN/GS1 numbers and formatting'
  spec.homepage      = 'https://github.com/officeluv/gtin_extras'
  spec.license       = 'Apache'

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org/'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
