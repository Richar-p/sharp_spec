require "sharp_spec/version"
require "sharp_spec/parser"
require "sharp_spec/builder"
require "rspec"

module SharpSpec
  class Runner
    def self.run(file_path)
      test_blocks = SharpSpec::Parser.new(file_path).parse

      require_relative File.expand_path(file_path).sub(/\.rb$/, '')
      SharpSpec::Builder.new(test_blocks).build

      RSpec::Core::Runner.run([])
    end
  end
end
