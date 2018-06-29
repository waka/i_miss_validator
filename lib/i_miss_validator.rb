require 'i_miss_validator/inspector'
require 'i_miss_validator/inspector/acceptance_inspector'
require 'i_miss_validator/inspector/length_inspector'
require 'i_miss_validator/inspector/numericality_inspector'
require 'i_miss_validator/inspector/presence_inspector'
require 'i_miss_validator/reporter'
require 'i_miss_validator/version'

module IMissValidator
  def self.run(inspectors = [])
    inspector = IMissValidator::Inspector.new(
      default_models_path,
      default_inspectors + inspectors
    )
    inspector.inspect

    IMissValidator::Reporter.report(inspector.results)

    true
  rescue => ex
    puts ex.message
    false
  end

  def self.default_models_path
    File.join(Dir.pwd, 'app', 'models')
  end

  def self.default_inspectors
    [
      IMissValidator::Inspector::AcceptanceInspector,
      IMissValidator::Inspector::LengthInspector,
      IMissValidator::Inspector::NumericalityInspector,
      IMissValidator::Inspector::PresenceInspector
    ]
  end
end
