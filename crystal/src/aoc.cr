require "./**"
require "option_parser"
require "benchmark"

module AoC
  def self.input(year, day)
    File.read("#{__DIR__}/../../input/#{year}/#{day}.txt")
  end
end

macro print_method(method)
  print {{ method[4..method.size].gsub(/_/, ".") }}, ": ", AoC.{{ method.id }}, "\n"
end

all = false
OptionParser.parse do |parser|
  parser.banner = "Usage: aoc [arguments]"

  parser.on("-a", "--all", "Runs all solutions.") do
    {% for method in AoC.methods.map(&.name.stringify).select { |name| name =~ /run_\d+_\d+[ab]/ } %}
      print_method({{ method }})
    {% end %}
  end

  parser.on("-r NAME", "--run=NAME", "Specifies the code to run. Supports regex.") do |parse|
    next if all
    {% for method in AoC.methods.map(&.name.stringify).select { |name| name =~ /run_\d+_\d+[ab]/ } %}
      if {{ method[4..method.size].gsub(/_/, ".") }} =~ Regex.new(parse)
        print_method({{ method }})
      end
    {% end %}
  end

  parser.on("-bm", "--benchmark", "Benchmarks the solutions.") do
    Benchmark.bm do |x|
      {% for method in AoC.methods.map(&.name.stringify).select { |name| name =~ /run_\d+_\d+[ab]/ } %}
        x.report({{method.stringify}}) do
          AoC.{{ method.id }}
        end
      {% end %}
    end
  end

  parser.on("-h", "--help", "Show this help.") { puts parser }

  parser.invalid_option do |invalid_option|
    STDERR.puts "ERROR: #{invalid_option} is not a valid option."
    STDERR.puts parser
    exit(1)
  end

  parser.missing_option do |missing_option|
    STDERR.puts "ERROR: #{missing_option} missing option."
    STDERR.puts parser
    exit(1)
  end
end
