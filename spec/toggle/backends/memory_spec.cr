require "../../spec_helper"
require "../../../src/toggle/backend/memory.cr"

describe Toggle::Backend::Memory do
  describe "Toggle Behaviour" do
    it "returns true when feature is enabled" do
      subject = Toggle::Backend::Memory.new

      subject.enable("store::new_checkout")

      subject.enabled?("store::new_checkout").should be_true
    end

    it "returns false when feature is enabled and then disabled" do
      subject = Toggle::Backend::Memory.new

      subject.enable("store::new_checkout")
      subject.disable("store::new_checkout")

      subject.enabled?("store::new_checkout").should be_false
    end

    it "returns false when feature is disabled" do
      subject = Toggle::Backend::Memory.new

      subject.disable("store::new_checkout")

      subject.enabled?("store::new_checkout").should be_false
    end

    it "returns false when feature is not present" do
      subject = Toggle::Backend::Memory.new

      subject.enabled?("store::new_checkout").should be_false
    end
  end

  describe "#features" do
    it "return all features" do
      subject = Toggle::Backend::Memory.new

      subject.enable("store::new_checkout")
      subject.disable("store::admin_dashboard")
      subject.enable("store::payment_methods::pix")

      subject.features.should eq(
        {
          "store::new_checkout"         => true,
          "store::admin_dashboard"      => false,
          "store::payment_methods::pix" => true,
        }
      )
    end
  end

  describe "#clear" do
    it "clears the storage" do
      subject = Toggle::Backend::Memory.new

      subject.enable("store::new_checkout")
      subject.enable("store::payment_methods::pix")

      subject.enabled?("store::new_checkout").should be_true
      subject.enabled?("store::payment_methods::pix").should be_true

      subject.clear

      subject.enabled?("store::new_checkout").should be_false
      subject.enabled?("store::payment_methods::pix").should be_false
    end
  end
end
