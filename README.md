# LiteConfig

[![Build Status](https://travis-ci.org/gtd/lite_config.png?branch=master)](https://travis-ci.org/gtd/lite_config)

LiteConfig automates the loading of Rails-style YAML config files.  With a single line the config file is lazily loaded
and cached, automatically choosing the current environment's hash.  It also supports a naming convention for overriding
the official config file without source code changes.

## Installation

Add this line to your application's Gemfile:

    gem 'lite_config'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install lite_config

## Usage

Simple loading of environment-namespaced config files with local overrides.

    LiteConfig(:foobar)

loads and caches the current environment section from:

    config/foobar.yml

The file must contain a yaml hash with environments for top-level keys.

Config files can be overridden by adding '_local' to the filename:

    config/foobar_local.yml

Local overrides are intended for individual developer boxes and thus
should be left out of version control.


## TODO

* Convert hash to OpenStruct for method-based access
* Raise errors for undefined config keys
* Support TOML or other config formats
* Allow configuration of source directory
* Allow multiple source directories


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
