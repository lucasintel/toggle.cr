require "./base"

module Toggle
  module Backend
    class Redis < Backend::Base
      KEYSPACE = "_toggles"
      ENABLED  = "1"
      DISABLED = "0"

      @redis : ::Redis | ::Redis::PooledClient
      @keyspace : String

      def initialize(@redis, @keyspace = KEYSPACE)
      end

      def enabled?(feature : String) : Bool
        result = @redis.hget(@keyspace, feature)
        return false if result.nil?

        result == ENABLED
      end

      def disabled?(feature : String) : Bool
        !enabled?(feature)
      end

      def features : Backend::Base::ToggleSet
        @redis.hgetall(@keyspace).transform_values do |value|
          value == ENABLED
        end
      end

      def enable(feature : String) : Nil
        @redis.hset(@keyspace, feature, ENABLED)
      end

      def disable(feature : String) : Nil
        @redis.hset(@keyspace, feature, DISABLED)
      end

      def clear : Nil
        @redis.del(@keyspace)
      end
    end
  end
end
