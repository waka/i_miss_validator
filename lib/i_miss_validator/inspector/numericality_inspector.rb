require 'active_record'

#
# Check columns if defined as integer, but no validator.
#
class IMissValidator::Inspector::NumericalityInspector
  IGNORE_COLUMN_NAMES = ['id', 'lock_version']

  def self.columns(model)
    model.columns.select do |column|
      column.type == :integer && IGNORE_COLUMN_NAMES.include?(column.name) == false
    end
  end

  def self.validators(model)
    model.validators.select do |validator|
      validator.class == ActiveModel::Validations::NumericalityValidator
    end
  end

  def self.missing_columns(model)
    validated_columns = validators(model).map(&:attributes).flatten.uniq
    columns(model).select do |column|
      !validated_columns.include?(column.name.to_sym)
    end
  end

  def self.inspect(model)
    missing_columns(model).map do |column|
      range = column.cast_type.send(:range)
      {
        column: column.name,
        missing_validator: :numericality_validator,
        options: { min: range.first, max: range.last }
      }
    end
  end
end
