require 'bundler/setup'
require 'minitest/autorun'
require 'debugger'

require 'lite_config'

LiteConfig.set_config_path(File.expand_path(__FILE__ + '/../fixtures'))
LiteConfig.set_app_env('development')
