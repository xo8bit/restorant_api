ENV['RACK_ENV'] ||= 'development'

require 'bundler'
Bundler.require :default, ENV['RACK_ENV'].to_sym

require 'sinatra/base'
require 'sinatra/namespace'
require 'sinatra/activerecord'
require 'json'
require 'geocoder'
require 'geocoder/railtie'

Geocoder::Railtie.insert

require_relative '../models/restorant'
require_relative '../models/atmosfere'
require_relative '../models/order'

require_relative '../helpers/string_helper'

class ApiController < Sinatra::Base
  register Sinatra::Namespace

  namespace '/api' do
    get '/' do
      content_type :json
      'Hello, from API'
    end
  end

  private

  def return_response(data, name = 'restorants')
    { 'status': 'success', "#{name}": data }.to_json
  end

  def return_error(error)
    halt 404, { status: 'error', error: error }.to_json
  end
end