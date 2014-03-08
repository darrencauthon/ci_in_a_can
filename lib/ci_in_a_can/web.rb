module CiInACan

  class Web

    params_constructor

    attr_accessor :params, :session

    def login_page
      CiInACan::ViewModels::LoginForm.new.to_html
    end

    def submit_a_passphrase
      session[:passphrase] = params[:passphrase]
    end

    def show_a_test_result
      CiInACan::TestResult.find(params[:id]).to_json
    end

    def logged_in?
      session[:authenticated]
    end

    def show_the_repo_edit_form
      id = params[:captures].first
      repo = CiInACan::Repo.find(id) || CiInACan::Repo.new(id: id)
      CiInACan::ViewModels::RepoForm.new(repo).to_html
    end

    def start_a_new_build
      capture = params[:captures].first.split('/')
      api_key = capture.pop
      id      = capture.join('/')

      repo = CiInACan::Repo.find id
      raise 'Could not find this repo' unless repo
      raise 'Invalid API Key' unless repo.api_key == api_key

      write_a_file_with params
    end

    def show_a_list_of_the_runs
      runs = CiInACan::Run.all.to_a
      ::CiInACan::ViewModels::AListOfRuns.new(runs).to_html
    end

    def show_the_test_result
      test_result = CiInACan::TestResult.find(params[:id])
      CiInACan::WebContent.full_page_of test_result.to_html
    end

    def update_repo_details
      params[:id] = params[:captures].first
      commands = params[:commands].gsub("\r\n", "\n").split("\n")
      commands = commands.map { |x| x.strip }.select { |x| x != '' }
      repo = CiInACan::Repo.find params[:id]
      repo = CiInACan::Repo.create(id: params[:id]) unless repo
      repo.build_commands = commands
      repo.save
      repo
    end

    def write_a_file_with params
      data = params.to_json
      File.open("#{self.class.jobs_location}/#{UUID.new.generate}.json", 'w') { |f| f.write data }
      data
    end

  end

end
