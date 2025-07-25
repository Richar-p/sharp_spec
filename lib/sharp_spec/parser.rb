class SharpSpec::Parser

  attr_reader :file_path

  def initialize(file_path)
    @file_path = file_path
  end

  def parse
    source = File.read(file_path)
    lines = source.lines

    test_blocks = []
    i = 0

    while i < lines.size
      if lines[i].strip == "# spec:begin"
        test_comment = []
        i += 1
        while lines[i] && lines[i].strip != "# spec:end"
          test_comment << lines[i].strip.sub(/^#\s*/, '')
          i += 1
        end
        i += 1
        method_line = lines[i..].find { |line| line.strip.start_with?("def ") }
        method_name = method_line[/def\s+([a-zA-Z0-9_]+)/, 1]
        test_blocks << { method: method_name, comment: test_comment }
      else
        i += 1
      end
    end

    test_blocks
  end
end
