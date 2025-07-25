require "sharp_spec/expects"
require "rspec"

class SharpSpec::Builder

  attr_reader :test_blocks

  def initialize(test_blocks)
    @test_blocks = test_blocks
  end

  def build
    test_blocks.each do |block|
      matcher = SharpSpec::Expects.resolve(block[:comment].find { |l| l.start_with?("expect:") }, block[:method])
      matcher.build
    end
  end
end
