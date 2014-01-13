require_relative 'spec_helper'

describe LiteConfig do
  before do
    LiteConfig.reset
  end

  describe "set_config_path" do
    it "should fail after the first load" do
      LiteConfig(:basic)

      proc { LiteConfig.set_config_path('foo') }.must_raise LiteConfig::ImmutableError
    end
  end

  describe "basic config" do
    before do
      @config = LiteConfig(:basic)
    end

    it "should default to development enviroment" do
      @config['option'].must_equal 'dev'
    end

    it "should allow indifferent access" do
      @config[:option].must_equal 'dev'
    end
  end

  describe "nested config" do
    before do
      @config = LiteConfig(:nested)
    end

    it "should find nested keys" do
      @config['top_level']['deeper']['and_deeper'].must_equal 'qux'
    end

    it "should allow indifferent access" do
      @config[:top_level][:deeper][:and_deeper].must_equal 'qux'
    end
  end

  describe "nested with array config" do
    it "should allow indifferent access"
  end

  describe "local_override config" do
    it "should respect override"
    it "should merge override params"
    it "should merge deep override params"
  end

  describe "environmentless config" do
    it "should use root level as config if keys do not look environmenty"
  end
end
