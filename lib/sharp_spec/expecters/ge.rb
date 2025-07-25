module SharpSpec::Expecters
  class Ge < SharpSpec::Expects
    def self.regex_matchers
      [
        /expect:\s*greater\s*than\s*or\s*equal\s*to\s*(\d+)/,
        /expect:\s*>=\s*(\d+)/
      ]
    end

    def expected_value = matched_data[1].to_i

    def default_description = "greater than or equal to #{expected_value}"

    def build
      expected_value = self.expected_value

      rspec_wrapper do |method_sym, options|
        expect(Object.send(method_sym, *options[:args])).to be >= expected_value
      end
    end
  end
end
