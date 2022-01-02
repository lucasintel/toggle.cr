require "./toggle/*"

module Toggle
  extend self
  class_property instance : Toggle::Instance?

  def init(backend : Toggle::Backend::Base)
    self.instance = Toggle::Instance.new(backend: backend)
  end

  def enabled?(feature : String, instance = Toggle.instance)
    with_instance(instance, &.enabled?(feature))
  end

  def disabled?(feature : String, instance = Toggle.instance)
    with_instance(instance, &.disabled?(feature))
  end

  def features(instance = Toggle.instance)
    with_instance(instance, &.features)
  end

  def enable(feature : String, instance = Toggle.instance)
    with_instance(instance, &.enable(feature))
  end

  def disable(feature : String, instance = Toggle.instance)
    with_instance(instance, &.disable(feature))
  end

  def clear(instance = Toggle.instance)
    with_instance(instance, &.clear)
  end

  private def with_instance(instance)
    raise Toggle::NotInitializedError.new if instance.nil?
    yield instance
  end
end
