module Toggle
  class Error < Exception
  end

  # Exception raised when Toggle default instance is not
  # initialized.
  class NotInitializedError < Error
    def initialize
      @message = "default instance is not initialized, see Toggle.init"
    end
  end
end
