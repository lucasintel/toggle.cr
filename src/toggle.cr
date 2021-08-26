require "./toggle/*"

module Toggle
  class_property instance : Toggle::Instance?
  extend self

  def init(backend)
    self.instance = Toggle::Instance.new(backend: backend)
  end

  @[RequireInstance]
  def enabled?(feature, instance = Toggle.instance)
    instance.enabled?(feature)
  end

  @[RequireInstance]
  def disabled?(feature, instance = Toggle.instance)
    instance.disabled?(feature)
  end

  @[RequireInstance]
  def features(instance = Toggle.instance)
    instance.features
  end

  @[RequireInstance]
  def enable(feature, instance = Toggle.instance)
    instance.enable(feature)
  end

  @[RequireInstance]
  def disable(feature, instance = Toggle.instance)
    instance.disable(feature)
  end

  @[RequireInstance]
  def clear(instance = Toggle.instance)
    instance.clear
  end
end
