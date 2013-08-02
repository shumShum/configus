require 'rubygems'

require 'bundler/setup'
Bundler.require

# Minitest.load_plugins
# Minitest::PrideIO.pride!

require 'minitest/pride'

if ENV['TRAVIS']
  require 'coveralls'
  Coveralls.wear!
end
