require 'active_record'

class IMissValidator::Inspector
  attr_reader :results

  def initialize(models_path, inspectors = [])
    @models_path = models_path
    @inspectors = inspectors
    @results = []
  end

  def models
    Dir.glob(File.join(@models_path, "**", "*.rb")).sort.each do |filename|
      begin
        Kernel.require_dependency filename
      rescue
        puts "Not a class #{filename}"
      end
    end

    ActiveRecord::Base.descendants.sort_by(&:name)
  end

  def inspect
    models.each do |model|
      begin
        model.columns
      rescue
        puts "No schema in model class #{model.to_s}"
        next
      end

      problems = @inspectors.map do |inspector|
        inspector.inspect(model)
      end

      @results << {
        model: model.to_s,
        problems: problems.flatten.compact.group_by {|pb| pb[:column] }
      }
    end
  end
end
