require "lite_config/version"

require 'lite_config/hash'
require 'lite_config/hash_with_indifferent_access'

require 'yaml'
require 'erb'

module LiteConfig
  class ImmutableError < StandardError; end
  class NotFoundError < StandardError; end

  extend self

  def fetch(name)
    name = name.to_sym
    @configs ||= {}
    @configs.key?(name) ? @configs[name] : (@configs[name] = IndifferentHash.new(load(name)))
  end

  def config_path=(path)
    raise ImmutableError, "config_path is frozen after the first file load" unless @configs.nil?

    @config_path = path
  end

  def app_env=(app_env)
    raise ImmutableError, "app_env is frozen after the first file load" unless @configs.nil?

    @app_env = app_env
  end

  def reset
    @configs = nil
  end

  private

  def load(name)
    if filename = get_filename(config_filename(name))
      config = load_single(filename)
    else
      raise NotFoundError, "No config found for #{name}"
    end

    if filename = get_filename(local_config_filename(name))
      local_config = load_single(filename)

      config.deep_merge!(local_config) if local_config
    end

    config
  end

  def load_single(filename)
    hash = if File.extname(filename) == '.erb'
      YAML.load ERB.new(IO.read(filename)).result
    else
      YAML.load_file filename
    end

    has_environmenty_key?(hash) ? hash[app_env] : hash
  end

  def config_path
    @config_path ||= File.join(app_root, 'config')
  end

  def get_filename(filename)
    filename_with_erb = filename + '.erb'

    if File.exist?(filename)
      filename
    elsif File.exist?(filename_with_erb)
      filename_with_erb
    end
  end

  def config_filename(name)
    File.join(config_path, name.to_s + '.yml')
  end

  def local_config_filename(name)
    config_filename(name).gsub(/.yml$/, '_local.yml')
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

  def has_environmenty_key?(hash)
    %w(development test production).any?{ |envy| hash.key?(envy) } if hash
  end
end

def LiteConfig(name)
  LiteConfig.fetch(name)
end
