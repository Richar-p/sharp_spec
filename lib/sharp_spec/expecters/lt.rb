require "byebug"
module SharpSpec::Expecters
  class Lt < SharpSpec::Expects
    def self.regex_matchers
      [
        /expect:\s*lower\s*than\s*(\d+)/,
        /expect:\s*less\s*than\s*(\d+)/,
        /expect:\s*<\s*(\d+)/
      ]
    end

    def default_description(expected_value) = "lower than #{expected_value}"
    def expected_value = matched_data[1].to_i

    def build
      expected_value = self.expected_value

      rspec_wrapper do |method_sym, options|
        expect(Object.send(method_sym, *options[:args])).to be < expected_value
      end
    end
  end
end
