### Prerequisites

    sudo apt-get install bundler

### Setup a Gemfile in Module Directory

    source 'https://rubygems.org'

    group :development, :test do
      gem 'rake',                    :require => false
      gem 'rspec-puppet',            :require => false
      gem 'puppetlabs_spec_helper',  :require => false
      gem 'serverspec',              :require => false
      gem 'rspec-system',            :require => false
      gem 'rspec-system-puppet',     :require => false
      gem 'rspec-system-serverspec', :require => false
      gem 'puppet-lint',             :require => false
    end

    if facterversion = ENV['FACTER_GEM_VERSION']
      gem 'facter', facterversion, :require => false
    else
      gem 'facter', :require => false
    end

    if puppetversion = ENV['PUPPET_GEM_VERSION']
      gem 'puppet', puppetversion, :require => false
    else
      gem 'puppet', :require => false
    end

    # vim:ft=ruby

Now you can bundle install to get the gems you need to test: bundle
install

### Setup a .gitignore

    pkg/
    metadata.json
    Gemfile.lock
    .rspec_system/
    .*.sw*

### Setup SPEC infrastructure

Put this in the 'spec/spec\_helper.rb' file: require
'puppetlabs\_spec\_helper/module\_spec\_helper'

Setup .fixtures.yml instead of symlinks:

    fixtures:
      symlinks:
        "iodine": "#{source_dir}"

#### Setup a Rakefile

`require 'puppetlabs_spec_helper/rake_tasks'`

### Writing Tests

See [Example Puppet Tests](Example Puppet Tests "wikilink")

### Run Your Tests

You need to run "bundle exec" to ensure the rake gets the correct gems
according to the Gemfile. bundle exec rake spec

### Travis CI

See [Using Travis CI With Puppet
Modules](Using Travis CI With Puppet Modules "wikilink")

<Category:Puppet> [Category:Puppet
Testing](Category:Puppet Testing "wikilink")
