module SharpSpec::Expecters
  class Gt < SharpSpec::Expects
    def self.regex_matchers
      [
        /expect:\s*greater\s*than\s*(\d+)/,
        /expect:\s*>\s*(\d+)/
      ]
    end

    def build
      expected_value = matched_data[1].to_i
      method_sym = method_name.to_sym  # capture in local variable

      RSpec.describe method_name do
        it "returns a value greater than #{expected_value}" do
          10.times do
            result = Object.send(method_sym)
            expect(result).to be > expected_value
          end
        end
      end
    end
  end
end
