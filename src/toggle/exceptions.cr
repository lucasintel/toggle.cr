module Toggle
  # Exception raised when Toggle default instance is not
  # initialized.
  class NotInitializedError < Exception
    def initialize
      @message = "default instance is not initialized, see Toggle.init"
    end
  end
end
