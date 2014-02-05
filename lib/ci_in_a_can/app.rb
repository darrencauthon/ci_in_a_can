require 'sinatra/base'
require 'json'

module CiInACan

  class App < Sinatra::Base

    get '/start' do
      params.to_json
    end

    post '/start' do
      params.to_json
    end

    put '/start' do
      params.to_json
    end

    delete '/start' do
      params.to_json
    end

  end

end

