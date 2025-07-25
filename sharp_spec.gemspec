Gem::Specification.new do |spec|
  spec.name          = "sharp_spec"
  spec.version       = SharpSpec::VERSION
  spec.authors       = ["Peter Richard"]
  spec.email         = ["mr.richard.peter@gmail.com"]

  spec.summary       = "Run Ruby tests from comments"
  spec.description   = "A Ruby gem that dynamically parses specially-formatted comment blocks to create and run tests in memory."
  spec.homepage      = "https://github.com/Richar-p/sharp_spec"

  spec.files         = Dir["lib/**/*.rb"]
  spec.require_paths = ["lib"]

  spec.add_dependency "rspec"
  spec.executables = ["sharp_spec"]
end
