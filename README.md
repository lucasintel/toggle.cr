# Toggle

[![Built with Crystal 1.1.1](https://img.shields.io/badge/Crystal-1.1.1-%23333333)](https://crystal-lang.org/)
[![GitHub release](https://img.shields.io/github/release/kandayo/toggle.cr.svg?label=Release)](https://github.com/kandayo/toggle.cr/releases)
[![CI](https://github.com/kandayo/toggle.cr/actions/workflows/ci.yml/badge.svg)](https://github.com/kandayo/toggle.cr/actions/workflows/ci.yml)

Toggle is a small feature toggle library for Crystal.

## References

- [Feature Toggles](https://martinfowler.com/articles/feature-toggles.html) (Martin Fowler)
- [Using Feature Flags to Ship Changes with Confidence](https://blog.travis-ci.com/2014-03-04-use-feature-flags-to-ship-changes-with-confidence) (Travis CI)
- [Feature flags in the development of GitLab](https://docs.gitlab.com/ee/development/feature_flags) (Gitlab)

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     toggle:
       github: kandayo/toggle.cr
   ```

2. Run `shards install`

## Usage

### Getting Started

Use `Toggle#init` to initialize a global, easy-to-use default instance.

```crystal
require "toggle"
require "toggle/backend/redis"

redis = Redis::PooledClient.new
backend = Toggle::Backend::Redis.new(redis: redis, keyspace: "_app_toggles")

Toggle.init(backend: backend)
Toggle.enable("payment_methods::pix")

Toggle.enabled?("payment_methods::pix") # => true
```

You can also instantiate multiple instances. Useful for managing features in
large applications.

```crystal
require "toggle"
require "toggle/backend/redis"

redis = Redis::PooledClient.new

tenant1_backend = Toggle::Backend::Redis.new(redis: redis, keyspace: "_tenant1_toggles")
tenant1 = Toggle::Instance.new(backend: tenant1_backend)

tenant2_backend = Toggle::Backend::Redis.new(redis: redis, keyspace: "_tenant2_toggles")
tenant2 = Toggle::Instance.new(backend: tenant2_backend)

# Enable "store::async_checkout" only for Tenant 1.
tenant1.enable("store::new_checkout")

tenant1.enabled?("store::new_checkout") # => true
tenant2.enabled?("store::new_checkout") # => false

# Or:

Toggle.enabled?(tenant1, "store::new_checkout") # => true
Toggle.enabled?(tenant2, "store::new_checkout") # => false
```

### Backend

#### Redis Backend

```crystal
require "redis"

require "toggle"
require "toggle/backend/redis"

backend = Toggle::Backend::Redis.new(redis: redis, keyspace: "_app_toggles")
```

Features are stored in a HASH on Redis.

#### In Memory Backend

```crystal
require "toggle"
require "toggle/backend/memory"

backend = Toggle::Backend::Memory.new
```

Features are stored in memory.

#### Custom Backend

You can create your own backend using the `Toggle::Backend::Base` interface.

## Contributing

1. Fork it (<https://github.com/kandayo/toggle.cr/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [kandayo](https://github.com/kandayo) - creator and maintainer

## License

The lib is available as open source under the terms of the MIT License.
