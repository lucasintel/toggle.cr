require "./spec_helper"
require "./../src/toggle/backend/redis.cr"

describe Toggle do
  describe ".enabled?" do
    it "returns true when feature is enabled" do
      backend = Toggle::Backend::Redis.new(redis: TestingRedis.current)
      Toggle.init(backend: backend)

      Toggle.enable("payment_methods::pix")

      Toggle.enabled?("payment_methods::pix").should be_true
    end

    it "returns false when feature is enabled and then disabled" do
      backend = Toggle::Backend::Redis.new(redis: TestingRedis.current)
      Toggle.init(backend: backend)

      Toggle.enable("payment_methods::pix")
      Toggle.disable("payment_methods::pix")

      Toggle.enabled?("payment_methods::pix").should be_false
    end

    it "returns false when feature is disabled" do
      backend = Toggle::Backend::Redis.new(redis: TestingRedis.current)
      Toggle.init(backend: backend)

      Toggle.disable("payment_methods::pix")

      Toggle.enabled?("payment_methods::pix").should be_false
    end

    it "returns false when feature is blank" do
      backend = Toggle::Backend::Redis.new(redis: TestingRedis.current)
      Toggle.init(backend: backend)

      Toggle.enabled?("payment_methods::pix").should be_false
    end

    it "raises NotInitializedError when default instance is not initialized" do
      expect_raises(Toggle::NotInitializedError, "default instance is not initialized, see Toggle.init") do
        Toggle.enabled?("payment_methods::pix")
      end
    end

    context "when an instance is given" do
      it "returns true when feature is enabled" do
        backend = Toggle::Backend::Redis.new(redis: TestingRedis.current)
        instance = Toggle::Instance.new(backend: backend)

        Toggle.enable("payment_methods::pix", instance)

        Toggle.enabled?("payment_methods::pix", instance).should be_true
      end
    end
  end

  describe ".disabled?" do
    it "returns false when feature is enabled" do
      backend = Toggle::Backend::Redis.new(redis: TestingRedis.current)
      Toggle.init(backend: backend)

      Toggle.enable("payment_methods::pix")

      Toggle.disabled?("payment_methods::pix").should be_false
    end

    it "returns true when feature is enabled and then disabled" do
      backend = Toggle::Backend::Redis.new(redis: TestingRedis.current)
      Toggle.init(backend: backend)

      Toggle.enable("payment_methods::pix")
      Toggle.disable("payment_methods::pix")

      Toggle.disabled?("payment_methods::pix").should be_true
    end

    it "returns true when feature is disabled" do
      backend = Toggle::Backend::Redis.new(redis: TestingRedis.current)
      Toggle.init(backend: backend)

      Toggle.disable("payment_methods::pix")

      Toggle.disabled?("payment_methods::pix").should be_true
    end

    it "returns true when feature is blank" do
      backend = Toggle::Backend::Redis.new(redis: TestingRedis.current)
      Toggle.init(backend: backend)

      Toggle.disabled?("payment_methods::pix").should be_true
    end

    it "raises NotInitializedError when default instance is not initialized" do
      expect_raises(Toggle::NotInitializedError, "default instance is not initialized, see Toggle.init") do
        Toggle.disabled?("payment_methods::pix")
      end
    end

    context "when an instance is given" do
      it "returns true when feature is enabled" do
        backend = Toggle::Backend::Redis.new(redis: TestingRedis.current)
        instance = Toggle::Instance.new(backend: backend)

        Toggle.enable("payment_methods::pix", instance)

        Toggle.disabled?("payment_methods::pix", instance).should be_false
      end
    end
  end

  describe ".features" do
    it "returns all features" do
      backend = Toggle::Backend::Redis.new(redis: TestingRedis.current)
      Toggle.init(backend: backend)

      Toggle.enable("store::new_checkout")
      Toggle.disable("store::admin_dashboard")
      Toggle.enable("payment_methods::pix")

      Toggle.features.should eq(
        {
          "store::new_checkout"    => true,
          "store::admin_dashboard" => false,
          "payment_methods::pix"   => true,
        }
      )
    end

    it "raises NotInitializedError when default instance is not initialized" do
      expect_raises(Toggle::NotInitializedError, "default instance is not initialized, see Toggle.init") do
        Toggle.features
      end
    end

    context "when an instance is given" do
      it "returns true when feature is enabled" do
        backend = Toggle::Backend::Redis.new(redis: TestingRedis.current)
        instance = Toggle::Instance.new(backend: backend)

        Toggle.enable("store::new_checkout", instance)
        Toggle.disable("store::admin_dashboard", instance)
        Toggle.enable("payment_methods::pix", instance)

        Toggle.features(instance).should eq(
          {
            "store::new_checkout"    => true,
            "store::admin_dashboard" => false,
            "payment_methods::pix"   => true,
          }
        )
      end
    end
  end

  describe ".clear" do
    it "clears the storage" do
      backend = Toggle::Backend::Redis.new(redis: TestingRedis.current)
      Toggle.init(backend: backend)

      Toggle.enable("store::new_checkout")
      Toggle.enable("payment_methods::pix")

      Toggle.enabled?("store::new_checkout").should be_true
      Toggle.enabled?("payment_methods::pix").should be_true

      Toggle.clear

      Toggle.enabled?("store::new_checkout").should be_false
      Toggle.enabled?("payment_methods::pix").should be_false
    end

    it "raises NotInitializedError when default instance is not initialized" do
      expect_raises(Toggle::NotInitializedError, "default instance is not initialized, see Toggle.init") do
        Toggle.clear
      end
    end

    context "when an instance is given" do
      it "returns true when feature is enabled" do
        backend = Toggle::Backend::Redis.new(redis: TestingRedis.current)
        instance = Toggle::Instance.new(backend: backend)

        Toggle.enable("store::new_checkout", instance)
        Toggle.enable("payment_methods::pix", instance)

        Toggle.enabled?("store::new_checkout", instance).should be_true
        Toggle.enabled?("payment_methods::pix", instance).should be_true

        Toggle.clear(instance)

        Toggle.enabled?("store::new_checkout", instance).should be_false
        Toggle.enabled?("payment_methods::pix", instance).should be_false
      end
    end
  end
end
