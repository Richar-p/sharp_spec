require "rspec"

class SharpSpec::Builder

  attr_reader :test_blocks

  def initialize(test_blocks)
    @test_blocks = test_blocks
  end

  def build
    test_blocks.each do |block|
      method = block[:method]
      expectations = block[:comment].find { |l| l.start_with?("expect:") }
      expected_values = eval(expectations.sub("expect:", "").strip)

      RSpec.describe method do
        it "returns one of #{expected_values.inspect}" do
          10.times do
            result = Object.send(method.to_sym)
            expect(expected_values).to include(result)
          end
        end
      end
    end
  end
end