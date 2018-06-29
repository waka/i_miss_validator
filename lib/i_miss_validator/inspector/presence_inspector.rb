require 'active_record'

#
# Check columns if defined not null, but no validator.
#
class IMissValidator::Inspector::PresenceInspector
  IGNORE_COLUMN_NAMES = ['id', 'lock_version']

  def self.columns(model)
    model.columns.select do |column|
      column.null == false && IGNORE_COLUMN_NAMES.include?(column.name) == false
    end
  end

  def self.validators(model)
    model.validators.select do |validator|
      validator.class == ActiveRecord::Validations::PresenceValidator
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
        missing_validator: :presence_validator,
        message: 'presence: true'
      }
    end
  end
end
