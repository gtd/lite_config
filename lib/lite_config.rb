require "lite_config/version"

require 'active_support/core_ext/hash'

require 'yaml'

module LiteConfig
  class ImmutableError < StandardError; end

  extend self

  def fetch(name)
    name = name.to_sym
    @configs ||= {}
    @configs.key?(name) ? @configs[name] : (@configs[name] = HashWithIndifferentAccess.new(load(name)))
  end

  def set_config_path(path)
    raise ImmutableError, "config_path is frozen after the first file load" unless @configs.nil?

    @config_path = path
  end

  def reset
    @configs = nil
  end

  private

  def load(name)
    config = YAML.load_file(config_filename(name))[app_env]

    if File.exist?(local_config_filename(name))
      config.deep_merge!(YAML.load_file(local_config_filename(name))[app_env])
    end

    raise "Oops, no #{app_env} config found for #{name} in #{filename}" unless config

    config
  end

  def config_path
    @config_path ||= File.join(app_root, 'config')
  end

  def config_filename(name)
    File.join(config_path, name.to_s + '.yml')
  end

  def local_config_filename(name)
    config_filename(name).gsub(/.yml$/, '_local.yml')
  end

  def active_config_filename(name)
  end

  def app_root
    defined?(Rails) ? Rails.root : `pwd`.strip
  end

  def app_env
    @app_env ||=
    if defined?(Rails)
      Rails.env
    elsif ENV['RAILS_ENV']
      ENV['RAILS_ENV']
    elsif ENV['RACK_ENV']
      ENV['RACK_ENV']
    else
      'development'
    end
  end
end

def LiteConfig(name)
  LiteConfig.fetch(name)
end
