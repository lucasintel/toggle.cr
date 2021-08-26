module Toggle
  class Instance
    delegate :enabled?, :disabled?, :features, :enable, :disable, :clear, to: @backend

    def initialize(@backend : Toggle::Backend::Base)
    end
  end
end
