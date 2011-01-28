require "rubygems"
require "bundler"

Bundler.require(:default)


$:.unshift File.expand_path('../../lib', __FILE__)
require 'processor'