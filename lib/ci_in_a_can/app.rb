require 'sinatra/base'
require 'json'

module CiInACan

  class App < Sinatra::Base

    get '/start' do
      { just_messing: 'around' }.to_json
    end

  end

end

