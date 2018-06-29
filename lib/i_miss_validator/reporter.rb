class IMissValidator::Reporter
  module Colorize
    refine String do
      def red
        "\e[36m#{self}\e[0m"
      end

      def yellow
        "\e[33m#{self}\e[0m"
      end

      def pink
        "\e[35m#{self}\e[0m"
      end
    end
  end

  using Colorize

  def self.report(results = [])
    results.each do |result|
      next if result[:problems].keys.size == 0

      print_with_indent(1, "Model".red + ": #{result[:model]}")

      result[:problems].each do |column, problems|
        print_with_indent(2, "Column".pink + ": #{column}")

        problems.each do |problem|
          print_with_indent(3, "Missing".yellow + ": #{problem[:message]}")
        end
      end
    end
  end

  def self.print_with_indent(level, str = "")
    level = 1 if 1 > level
    puts "  " * (level - 1) + str
  end
end
