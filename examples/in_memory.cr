require "../src/toggle"
require "../src/toggle/backend/memory"

in_memory_backend = Toggle::Backend::Memory.new
Toggle.init(backend: in_memory_backend)

Toggle.enabled?("store::async_checkout") # => false
Toggle.enable("store::async_checkout")   # => nil
Toggle.enabled?("store::async_checkout") # => true
Toggle.disable("store::async_checkout")  # => nil
Toggle.enabled?("store::async_checkout") # => false
