require "./toggle/ext/*"
require "./toggle/*"

module Toggle
  class_property instance : Toggle::Instance?

  # Copy repository methods to a global, simple-to-use
  # default instance.
  delegate_to_instance :enabled?, :disabled?, :features, :enable, :disable, :clear

  def self.init(backend)
    self.instance = Toggle::Instance.new(backend: backend)
  end
end
