require 'i_miss_validator/inspector'
require 'i_miss_validator/inspector/acceptance_inspector'
require 'i_miss_validator/inspector/length_inspector'
require 'i_miss_validator/inspector/numericality_inspector'
require 'i_miss_validator/inspector/presence_inspector'
require 'i_miss_validator/reporter'
require 'i_miss_validator/version'

module IMissValidator
  def self.run
    inspector = IMissValidator::Inspector.new(models_path, inspectors)
    inspector.inspect

    IMissValidator::Reporter.report(inspector.result)

    true
  end

  def self.models_path
    File.join(Dir.pwd, 'app', 'models')
  end

  def self.inspectors
    [
      IMissValidator::Inspector::AcceptanceInspector,
      IMissValidator::Inspector::LengthInspector,
      IMissValidator::Inspector::NumericalityInspector,
      IMissValidator::Inspector::PresenceInspector
    ]
  end
end
