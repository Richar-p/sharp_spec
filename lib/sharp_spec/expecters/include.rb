require "byebug"
module SharpSpec::Expecters
  class Include < SharpSpec::Expects

    def self.regex_matchers
      [
        /expect:\s*(\[[^\]]*\])/
      ]
    end

    def default_description(expected_value) = "included in #{expected_value}"
    def expected_value = eval(matched_data[1])

    def build
      expected_values = expected_value

      rspec_wrapper do |method_sym, options|
        expect(expected_values).to include(Object.send(method_sym, *options[:args]))
      end
    end
  end
end
