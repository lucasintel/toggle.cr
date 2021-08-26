require "redis"

require "../src/toggle"
require "../src/toggle/backend/memory"
require "../src/toggle/backend/redis"

redis = Redis::PooledClient.new

tenant1_backend = Toggle::Backend::Redis.new(redis: redis, keyspace: "_tenant1_toggles")
tenant1 = Toggle::Instance.new(backend: tenant1_backend)

tenant2_backend = Toggle::Backend::Redis.new(redis: redis, keyspace: "_tenant2_toggles")
tenant2 = Toggle::Instance.new(backend: tenant2_backend)

tenant3_backend = Toggle::Backend::Memory.new
tenant3 = Toggle::Instance.new(backend: tenant3_backend)

# Enable "store::async_checkout" only for Tenant 1.
tenant1.enable("store::async_checkout")

tenant1.enabled?("store::async_checkout") # => true
tenant2.enabled?("store::async_checkout") # => false
tenant3.enabled?("store::async_checkout") # => false
