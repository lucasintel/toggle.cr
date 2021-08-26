require "redis"

require "../src/toggle"
require "../src/toggle/backend/redis"

redis = Redis::PooledClient.new

redis_backend = Toggle::Backend::Redis.new(redis)
Toggle.init(backend: redis_backend)

Toggle.enabled?("store::async_checkout") # => false
Toggle.enable("store::async_checkout")   # => nil
Toggle.enabled?("store::async_checkout") # => true
Toggle.disable("store::async_checkout")  # => nil
Toggle.enabled?("store::async_checkout") # => false
