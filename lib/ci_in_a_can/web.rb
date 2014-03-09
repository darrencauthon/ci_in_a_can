module CiInACan

  class Web

    params_constructor

    attr_accessor :params, :session

    class << self
      attr_accessor :jobs_location
    end

    def login_page
      CiInACan::ViewModels::LoginForm.new.to_html
    end

    def submit_a_passphrase
      session[:passphrase] = params[:passphrase]
    end

    def show_the_test_result_in_json
      CiInACan::TestResult.find(params[:id]).to_json
    end

    def logged_in?
      return false if session[:passphrase].to_s == ''
      session[:passphrase] == ENV['PASSPHRASE']
    end

    def show_the_repo_edit_form
      id = params[:captures].first
      repo = CiInACan::Repo.find(id) || CiInACan::Repo.new(id: id)
      CiInACan::ViewModels::RepoForm.new(repo).to_html
    end

    def start_a_new_build
      assert_that_the_new_build_is_valid

      write_a_file_with params
      params.to_json
    end

    def show_a_list_of_the_runs
      CiInACan::ViewModels::AListOfRuns.new(CiInACan::Run.all.to_a).to_html
    end

    def show_the_test_result
      test_result = CiInACan::TestResult.find(params[:id])
      CiInACan::WebContent.layout_page_around test_result.to_html
    end

    def update_repo_details
      CiInACan::Repo.create(id:             params[:captures].first, 
                            build_commands: params[:commands].gsub("\r\n", "\n")
                                                             .split("\n")
                                                             .map    { |x| x.strip }
                                                             .select { |x| x != '' } )
    end

    def write_a_file_with params
      data = params.to_json
      file = "#{self.class.jobs_location}/#{UUID.new.generate}.json"
      CiInACan::FileSystem.create_file file, data
    end

    def assert_that_the_new_build_is_valid
      capture = params[:captures].first.split('/')
      api_key = capture.pop
      id      = capture.join('/')

      repo = CiInACan::Repo.find id
      raise 'Could not find this repo' unless repo
      raise 'Invalid API Key' unless repo.api_key == api_key
    end

  end

end
