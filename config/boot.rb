# config/boot.rb

ENV["BUNDLE_GEMFILE"] ||= File.expand_path("../Gemfile", __dir__)

# RUBY 3.4 FIX: Prevent FrozenError during Rails initialization
 $LOAD_PATH.unshift(".") unless $LOAD_PATH.include?(".") rescue nil

require "bundler/setup" # Set up gems listed in the Gemfile.
require "bootsnap/setup" # Speed up boot time by caching expensive operations.