require 'sinatra/base'

module CiInACan

  class App < Sinatra::Base

    enable :sessions

    before do
      session[:authenticated] = session[:passphrase] == ENV['PASSPHRASE'].to_s
    end

    class << self
      attr_accessor :jobs_location
    end

    get '/login' do
      CiInACan::Web.new.login_page
    end

    post '/login' do
      web = CiInACan::Web.new(params: params, session: session)
      web.submit_a_passphrase
      redirect '/'
    end

    get '/test_result/:id.json' do
      CiInACan::Web.new(params: params).show_the_test_result_in_json
    end

    post %r{/repo/(.+)} do

      web = CiInACan::Web.new(params: params, session: session)
      unless web.logged_in?
        redirect '/login'
        return
      end
      repo = web.update_repo_details
      redirect "/repo/#{repo.id}"
    end

    get %r{/repo/(.+)} do
      web = CiInACan::Web.new(params: params, session: session)

      unless web.logged_in?
        redirect '/login'
        return
      end

      web.show_the_repo_edit_form
    end

    get '/test_result/:id' do
      CiInACan::Web.new(params: params).show_the_test_result
    end

    get '/' do
      CiInACan::Web.new.show_a_list_of_the_runs
    end

    post %r{/push/(.+)} do
      CiInACan::Web.new(params: params).start_a_new_build
    end

  end

end
