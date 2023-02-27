#!/bin/bash

set -e # Fail the whole script on first error

# Fetch Ruby gem dependencies
bundle install --path vendor/bundle --with='development'

# Fetch Javascript dependencies
yarn install

# Make Gemfile.lock pristine again
git checkout -- Gemfile.lock

# [re]create, migrate, and seed the developer database
RAILS_ENV=test ./bin/rails db:setup

# Precompile assets for development
RAILS_ENV=development ./bin/rails assets:precompile

