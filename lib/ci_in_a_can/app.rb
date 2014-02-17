require 'sinatra/base'

module CiInACan

  class App < Sinatra::Base

    class << self
      attr_accessor :jobs_location
    end

    get '/test_result/:id.json' do
      CiInACan::TestResult.find(params[:id]).to_json
    end

    post %r{/repo/(.+)} do
      params[:id] = params[:captures].first
      commands = params[:commands].gsub("\r\n", "\n").split("\n")
      commands = commands.map { |x| x.strip }.select { |x| x != '' }
      data = CiInACan::Persistence.find('build_commands', params[:id]) || {}
      data[:commands] = commands
      CiInACan::Persistence.save('build_commands', params[:id], data)
      redirect "/repo/#{params[:id]}"
    end

    get %r{/repo/(.+)} do
      params[:id] = params[:captures].first
      data = CiInACan::Persistence.find('build_commands', params[:id]) || {}
      commands = data[:commands] || []
      commands = commands.join("\n")
      CiInACan::WebContent.full_page_of(
<<EOF
<form action="/repo/#{params[:id]}" method="post">
<textarea name="commands">
#{commands}
</textarea>
<input type="submit">Submit</inputk
</form>
EOF
)
    end

    get '/test_result/:id' do
      test_result = CiInACan::TestResult.find(params[:id])
      CiInACan::WebContent.full_page_of test_result.to_html
    end

    get '/' do
      run_html = CiInACan::Run.all.map { |r| r.to_html }.join("\n")

      CiInACan::WebContent.full_page_of(
<<EOF
    <table class="table table-bordered">
      <tbody>
      #{run_html}
      </tbody>
    </table>
EOF
)
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
