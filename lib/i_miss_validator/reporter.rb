class IMissValidator::Reporter
  def self.report(result = [])
    result.each do |hash|
      puts "Model: #{hash[:model]}"
      hash[:problems].each do |column, problem|
        puts "  column: #{column}"
        problem.each do |pb|
          puts "    missing: #{print_missing(pb)}"
        end
      end
    end
  end

  def self.print_missing(problem)
    options = problem[:options]

    case problem[:missing_validator]
    when :acceptance_validator
      "acceptance: true or acceptance: { accept: 'true', 'false' }"
    when :length_validator
      "length: { maximum: #{options[:limit]} }"
    when :numericality_validator
      "numericality: { only_integer: true, less_than_or_equal_to: #{options[:min]}, greater_then_or_equal_to: #{options[:max]} }"
    when :presence_validator
      'presence: true'
    else
      'something wrong!!!'
    end
  end
end
