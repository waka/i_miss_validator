require 'active_record'

#
# Check columns if defined as integer, but no validator.
#
class IMissValidator::Inspector::AcceptanceInspector
  def self.columns(model)
    model.columns.select do |column|
      column.type == :boolean
    end
  end

  def self.validators(model)
    model.validators.select do |validator|
      validator.class == ActiveModel::Validations::AcceptanceValidator
    end
  end

  def self.missing_columns(model)
    validated_columns = validators(model).map(&:attributes).flatten.uniq
    columns(model).select do |column|
      validated_columns.include?(column.name.to_sym) == false
    end
  end

  def self.inspect(model)
    missing_columns(model).map do |column|
      {
        column: column.name,
        missing_validator: :acceptance_validator,
        message: "acceptance: true or acceptance: { accept: 'true', 'false' }"
      }
    end
  end
end
