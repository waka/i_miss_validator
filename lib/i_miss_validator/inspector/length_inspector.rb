require 'active_record'

#
# Check columns if defined limit, but no validator.
#
class IMissValidator::Inspector::LengthInspector
  def self.columns(model)
    model.columns.select do |column|
      column.text?
    end
  end

  def self.validators(model)
    model.validators.select do |validator|
      validator.class == ActiveModel::Validations::LengthValidator
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
        missing_validator: :length_validator,
        message: "length: { maximum: #{column.limit} }"
      }
    end
  end
end
