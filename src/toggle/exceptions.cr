module Toggle
  # Exception raised when Toggle default instance is not
  # initialized.
  class NotInitializedError < Exception
    DEFAULT_MESSAGE = "toggle default instance is not initialized"

    def initialize(@message : String = DEFAULT_MESSAGE)
    end
  end
end
