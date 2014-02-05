require 'sinatra/base'

module CiInACan

  class App < Sinatra::Base

    get '/fake_an_error' do
      raise 'testing error'
    end

  end

end
