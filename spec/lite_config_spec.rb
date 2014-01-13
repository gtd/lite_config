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

    it "should allow arrays" do
      @config[:top_level][:an_array][0].must_equal 'one'
      @config[:top_level][:an_array][1].must_equal 'two'
      @config[:top_level][:an_array][2].must_equal 'three'
    end

    it "should allow hashes in arrays" do
      @config['top_level']['array_of_hashish'][0]['fu'].must_equal 'schnickens'
      @config['top_level']['array_of_hashish'][0]['wu'].must_equal 'tang'
    end

    it "should allow hashes in arrays indifferently" do
      @config[:top_level][:array_of_hashish][0][:fu].must_equal 'schnickens'
      @config[:top_level][:array_of_hashish][0][:wu].must_equal 'tang'
    end
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
