require "sharp_spec/expects"
require "rspec"

class SharpSpec::Builder

  OPTIONS = [:times, :description, :args]

  attr_reader :test_blocks

  def initialize(test_blocks)
    @test_blocks = test_blocks
  end

  def build
    test_blocks.each do |block|
      options = retrieve_options(block)
      expect_comment = block[:comment].find { |l| l.start_with?("expect:") }
      matcher = SharpSpec::Expects.resolve(expect_comment, block[:method], options)
      matcher.build
    end
  end


  def retrieve_options(block)
    options = {}

    block[:comment].each do |line|
      OPTIONS.each do |key|
        if line.strip =~ /^#?\s*#{key}:\s*(.+)$/
          value = $1.strip
          # Try to eval the value (to support arrays, numbers, etc.)
          options[key] = begin
                           eval(value)
                         rescue StandardError
                           value
                         end
        end
      end
    end

    options
  end
end
