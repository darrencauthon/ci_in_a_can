require 'sinatra/base'

module CiInACan

  class App < Sinatra::Base

    enable :sessions

    before do
      session[:authenticated] = session[:passphrase] == ENV['PASSPHRASE'].to_s
    end

    before do
      @web = CiInACan::Web.new(params: params, session: session)
    end

    class << self
      attr_accessor :jobs_location
    end

    get '/login' do
      @web.login_page
    end

    post '/login' do
      @web.submit_a_passphrase
      redirect '/'
    end

    get '/test_result/:id.json' do
      @web.show_a_test_result
    end

    post %r{/repo/(.+)} do
      unless @web.logged_in?
        redirect '/login'
        return
      end
      repo = @web.update_repo_details
      redirect "/repo/#{repo.id}"
    end

    get %r{/repo/(.+)} do

      unless session[:authenticated]
        redirect '/login'
        return
      end

      id = params[:captures].first
      repo = CiInACan::Repo.find(id) || CiInACan::Repo.new(id: id)
      CiInACan::ViewModels::RepoForm.new(repo).to_html
    end

    get '/test_result/:id' do
      test_result = CiInACan::TestResult.find(params[:id])
      CiInACan::WebContent.full_page_of test_result.to_html
    end

    get '/' do
      runs = CiInACan::Run.all.to_a
      ::CiInACan::ViewModels::AListOfRuns.new(runs).to_html
    end

    post %r{/push/(.+)} do
      capture = params[:captures].first.split('/')
      api_key = capture.pop
      id      = capture.join('/')

      repo = CiInACan::Repo.find id
      raise 'Could not find this repo' unless repo
      raise 'Invalid API Key' unless repo.api_key == api_key

      write_a_file_with params
    end

    def write_a_file_with params
      data = params.to_json
      File.open("#{self.class.jobs_location}/#{UUID.new.generate}.json", 'w') { |f| f.write data }
      data
    end

  end

end
