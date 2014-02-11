require 'sinatra/base'

module CiInACan

  class App < Sinatra::Base

    class << self
      attr_accessor :jobs_location
    end

    get '/test_result/:id' do
      CiInACan.results_location = '/Users/darrencauthon/desktop/ci_in_a_can/spec/temp'
      CiInACan::TestResult.find(params[:id]).to_json
    end

    get '/' do
<<EOF
<html>
  <head>
    <link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.1.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.1.0/css/bootstrap-theme.min.css">
    <script src="//netdna.bootstrapcdn.com/bootstrap/3.1.0/js/bootstrap.min.js"></script>
  </head>
  <body>
    <table class="table table-bordered">
      <tbody>
      </tbody>
    </table>
  </body>
</html>
EOF
    end

    post '/' do
      write_a_file_with params
    end

    def write_a_file_with params
      data = params.to_json
      File.open("#{self.class.jobs_location}/#{UUID.new.generate}.json", 'w') { |f| f.write data }
      data
    end

  end

end
