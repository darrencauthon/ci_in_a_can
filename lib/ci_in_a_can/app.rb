require 'sinatra/base'

module CiInACan

  class App < Sinatra::Base

    class << self
      attr_accessor :jobs_location
    end

    get '/test_result/:id' do
      test_result = CiInACan::TestResult.find(params[:id])

      CiInACan::WebContent.full_page_of(
<<EOF
    <table class="table table-bordered">
      <tbody>
      <tr>
        <td>
          Id
        </td>
        <td>
          #{test_result.id}
        </td>
      </tr>
      <tr>
        <td>
          Created At
        </td>
        <td>
          #{test_result.created_at.to_s}
        </td>
      </tr>
      <tr>
        <td>
          Passed
        </td>
        <td>
          #{test_result.passed ? 'Yes' : 'No'}
        </td>
      </tr>
      <tr>
        <td>
          Output
        </td>
        <td>
          #{test_result.output.to_s.gsub("\n", '<br />')}
        </td>
      </tr>
      </tbody>
    </table>
EOF
)
    end

    get '/' do
      CiInACan::WebContent.full_page_of(
<<EOF
    <table class="table table-bordered">
      <tbody>
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
