# LiteConfig

[![Build Status](https://travis-ci.org/gtd/lite_config.png?branch=master)](https://travis-ci.org/gtd/lite_config)
[![Code Climate](https://codeclimate.com/github/gtd/lite_config.png)](https://codeclimate.com/github/gtd/lite_config)
[![Gem Version](https://badge.fury.io/rb/lite_config.png)](http://badge.fury.io/rb/lite_config)

LiteConfig automates the loading of Rails-style YAML config files.  With a single line the config file is lazily loaded
and cached, automatically choosing the current environment's hash.  It also supports local developer override via
a simple, easily git-ignoreable naming convention.


## Installation

It's just a regular gem, add with the usual Gemfile declaration:

    gem 'lite_config'

Alternatively if you aren't using Bundler then you probably don't need me telling you what to do.


## Usage

By default LiteConfig follows the Rails convention for config file directory.  For instance you might have a file
`config/options.yml`:

    development:
      stuff: Things
    test:
      stuff: Test Things

You can access the sub-hash of the current environment with a simple method call:

    LiteConfig(:options)
    => {"stuff"=>"Things"}

Note that it is a HashWithIndifferentAccess:

    LiteConfig(:options)[:stuff]
    => "Things"

It's worth mentioning that this applies to nested hashes as well, so given `config/options.yml`:

    development:
      outer:
        inner: Stuff

you can do:

    LiteConfig(:options)[:outer][:inner]
    => "Stuff"

Of course any valid YAML will work, but it works particularly nicely with simple hashes and arrays.

#### Flat Config Files

Do you ever cringe when your config file uses advanced YAML features do duplicate the exact same hash for every
environment?  With LiteConfig you can just skip the environment keys at the top-level entirely if you want to. So for
instance a config file `config/options.yml` containing only:

    root: This is tops

can be used as such:

    LiteConfig(:options)[:root]
    => "This is tops"

In case you're wondering, this is based on a simple heuristic by checking for the presence of a `test`, `development`
or `production` at the root level, so if those are the keys for your config values than I'm sorry but you'll need to go
back to your byzantine YAML ampersand syntax hacks.

#### Local Overrides

Sometimes on your team individual developers have local configuration that you don't want in version control.  Consider
`config/geoip.yml`:

    foo: bar
    data_file: /usr/share/geoip.dat

But developers may not all organize their systems exactly the same way, so you create a local config named
`config/geoip_local.yml`:

    data_file: /Users/apple-fanboy/Documents/geoip.dat

LiteConfig automatically picks this up based on the naming convention and merges the values into main config file hash:

    LiteConfig(:geoip)[:data_file]
    => "/Users/apple-fanboy/Documents/geoip.dat"

    LiteConfig(:geoip)[:foo]
    => "bar"

The naming convention also allows you to add the following to your `.gitignore`:

    config/*_local.yml

#### LiteConfig Settings

LiteConfig is meant to work out of the box with Rails, but it also is configurable.  Note that these settings can not be
changed after the first config file is loaded as that could lead to the wrong data being loaded and cached.

    LiteConfig.config_path = '/usr/local/global_app_config' # Full path to the directory files should be loaded from
    LiteConfig.app_env = 'production' # Explicitly override RAILS_ENV, RACK_ENV defaults


## Future Ideas

* Convert LiteConfig to an insantiable class instead of a singleton
* Ability to raise errors for undefined config keys
* Support TOML or other config formats
* Allow OpenStruct-like access to the config.  I'm not 100% sure on the ROI of this feature.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
