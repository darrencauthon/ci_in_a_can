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

  end

end
