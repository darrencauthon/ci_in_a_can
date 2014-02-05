require 'sinatra/base'
require 'json'
require 'uuid'

module CiInACan

  class App < Sinatra::Base

    get '/start' do
      write_a_file_with params
    end

    post '/start' do
      write_a_file_with params
    end

    put '/start' do
      write_a_file_with params
    end

    delete '/start' do
      write_a_file_with params
    end

    def write_a_file_with params
      data = params.to_json
      File.open("#{UUID.new.generate}.json", 'w') { |f| f.write data }
      data
    end

  end

end

