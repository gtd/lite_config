require_relative 'spec_helper'

describe LiteConfig do
  before do
    LiteConfig.set_config_path(File.expand_path(__FILE__ + '/../fixtures'))
  end

  describe "basic config" do
    before do
      @config = LiteConfig(:basic)
    end

    it "should default to development enviroment" do
      @config['option'].must_equal 'dev'
    end

    it "should allow indifferent access"
    it "should allow method access"
  end

  describe "nested config" do
    it "should allow indifferent access"
    it "should allow method access"
  end

  describe "nested with array config" do
    it "should allow indifferent access"
    it "should allow method access"
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
