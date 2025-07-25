require "byebug"
module SharpSpec::Expecters
  class Include < SharpSpec::Expects

    def self.regex_matchers
      [
        /expect:\s*(\[[^\]]*\])/
      ]
    end

    def build
      expected_values = eval(matched_data[1])
      method_sym = method_name.to_sym  # capture in local variable

      RSpec.describe method_name do
        it "returns a value included in #{expected_values}" do
          10.times do
            result = Object.send(method_sym)
            expect(expected_values).to include(result)
          end
        end
      end
    end
  end
end
