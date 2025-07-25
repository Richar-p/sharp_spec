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

  def initialize(expectation, method_name, matched_data)
    @expectation = expectation
    @method_name = method_name
    @matched_data = matched_data
  end

  attr_reader :expectation, :method_name, :matched_data

  def build
    raise NotImplementedError, "You must implement the build method in a subclass"
  end

  def self.registry
    @registry ||= [
      SharpSpec::Expecters::Gt,
      SharpSpec::Expecters::Include,
    ]
  end

  def self.resolve(expectation, method_name)
    matched_data = nil
    matcher_class = registry.find { |klass| matched_data = klass.detect(expectation) }
    if matcher_class
      matcher_class.new(expectation, method_name, matched_data)
    else
      raise "No matcher found for expectation: #{expectation.inspect}"
    end
  end
end

require "sharp_spec/expecters/expecters"
