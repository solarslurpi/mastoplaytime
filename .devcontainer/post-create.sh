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

# Configure git
# git config --global --edit

git config --global user.email \"${localEnv:GIT_EMAIL}\"

git config --global user.name "Your Name" \"${localEnv:GIT_USER}\"
