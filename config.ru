require 'rubygems'
require 'bundler'
Bundler.require(:default)
require 'sass/plugin/rack'
require './myapp'

Sass::Plugin.option[:style] = :compressed
use Sass::Plugin::Rack

run app
