ENV['SINATRA_ENV'] = 'lambda'
require 'sinatra'
require_relative './app/controllers/application_controller'
require_relative './config/environment'

run ApplicationController