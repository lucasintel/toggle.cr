module Toggle
  module Backend
    abstract class Base
      alias ToggleSet = Hash(String, Bool)

      abstract def enabled?(feature : String) : Bool

      abstract def disabled?(feature : String) : Bool

      abstract def features : ToggleSet

      abstract def enable(feature : String) : Nil

      abstract def disable(feature : String) : Nil

      abstract def clear : Nil
    end
  end
end
