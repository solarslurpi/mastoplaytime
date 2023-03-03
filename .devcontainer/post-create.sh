#!/bin/bash

set -e # Fail the whole script on first error

# Fetch Ruby gem dependencies
bundle install --path vendor/bundle --with='development'

# Fetch Javascript dependencies
yarn install

# Make Gemfile.lock pristine again
git checkout -- Gemfile.lock

# [re]create, migrate, and seed the developer database
RAILS_ENV=development ./bin/rails db:setup

# Precompile assets for development
RAILS_ENV=development ./bin/rails assets:precompile

# Install foreman
sudo gem install foreman

# Start up the web server in the background.
foreman start -d web
# Start up the web pack service in the background.
foremand start -d webpack

