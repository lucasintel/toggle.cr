require "./base"

module Toggle
  module Backend
    class Memory < Backend::Base
      def initialize(@storage = Backend::Base::ToggleSet.new)
      end

      def enabled?(feature : String) : Bool
        !!@storage[feature]?
      end

      def disabled?(feature : String) : Bool
        !enabled?(feature)
      end

      def features : Backend::Base::ToggleSet
        @storage
      end

      def enable(feature : String) : Nil
        @storage[feature] = true
      end

      def disable(feature : String) : Nil
        @storage[feature] = false
      end

      def clear : Nil
        @storage.clear
      end
    end
  end
end
