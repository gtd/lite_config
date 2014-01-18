require 'bundler/setup'
require 'minitest/autorun'
require 'debugger'

require 'lite_config'

LiteConfig.config_path = File.expand_path(__FILE__ + '/../fixtures')
LiteConfig.app_env = 'development'
