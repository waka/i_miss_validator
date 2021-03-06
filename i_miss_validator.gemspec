lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "i_miss_validator/version"

Gem::Specification.new do |spec|
  spec.name          = "i_miss_validator"
  spec.version       = IMissValidator::VERSION
  spec.authors       = ["yo_waka"]
  spec.email         = ["y.wakahara@gmail.com"]

  spec.summary       = %q{Check missing validators by database schema.}
  spec.description   = %q{Check missing validators by database schema.}
  spec.homepage      = "https://github.com/waka/i_miss_validator"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "bin"
  spec.executables   = ["i_miss_validator".freeze]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "mysql2", ">= 0.3", "< 0.4"

  spec.add_dependency "activerecord", ">= 4.2"
end
