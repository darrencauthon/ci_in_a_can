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
      CiInACan::WebContent.full_page_of(
<<EOF
<form action="/login" method="post">
Passphrase
<input type="password" name="passphrase">
<button type="submit">Submit</button>
</form>
EOF
)
    end

    post '/login' do
      session[:passphrase] = params[:passphrase]
      redirect '/'
    end

    get '/test_result/:id.json' do
      CiInACan::TestResult.find(params[:id]).to_json
    end

    post %r{/repo/(.+)} do

      unless session[:authenticated]
        redirect '/login'
        return
      end

      params[:id] = params[:captures].first
      commands = params[:commands].gsub("\r\n", "\n").split("\n")
      commands = commands.map { |x| x.strip }.select { |x| x != '' }
      repo = CiInACan::Repo.find params[:id]
      repo = CiInACan::Repo.create(id: params[:id]) unless repo
      repo.build_commands = commands
      repo.save
      redirect "/repo/#{params[:id]}"
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
