class SharpSpec::Expects
  def self.detect(expectation)
    regex_matchers.each do |regex|
      match = regex.match(expectation)
      return match if match
    end
    nil
  end


  def self.regex_matchers
    raise NotImplementedError, "#{self} must define .regex_matchers"
  end

  def initialize(expectation, method_name, matched_data, options = {})
    @expectation = expectation
    @method_name = method_name
    @matched_data = matched_data
    @options = options
  end

  attr_reader :expectation, :method_name, :matched_data, :options

  def build
    raise NotImplementedError, "You must implement the build method in a subclass"
  end

  def rspec_wrapper(&block)
    method_sym = method_name.to_sym
    times = retrieve_times
    description = retrieve_description
    options = self.options

    RSpec.describe method_name do
      it description do
        times.times do
          instance_exec(method_sym, options, &block)
        end
      end
    end
  end

  def self.registry
    @registry ||= [
      SharpSpec::Expecters::Gt,
      SharpSpec::Expecters::Ge,
      SharpSpec::Expecters::Lt,
      SharpSpec::Expecters::Include,
    ]
  end

  def self.resolve(expectation, method_name, options = {})
    matched_data = nil
    matcher_class = registry.find { |klass| matched_data = klass.detect(expectation) }
    if matcher_class
      matcher_class.new(expectation, method_name, matched_data, options)
    else
      raise "No matcher found for expectation: #{expectation.inspect}"
    end
  end

  def retrieve_times = options[:times] || 10

  def retrieve_description = options[:description] || default_description(expected_value)
end

require "sharp_spec/expecters/expecters"
