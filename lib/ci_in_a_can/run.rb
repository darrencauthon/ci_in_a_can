module CiInACan

  class Run

    params_constructor

    attr_accessor :created_at,
                  :test_result_id,
                  :passed,
                  :build_id,
                  :sha,
                  :repo,
                  :branch

    def self.add build, test_result
      data = { 
               created_at:     test_result.created_at,
               test_result_id: test_result.id,
               passed:         test_result.passed,
               build_id:       build.id,
               sha:            build.sha,
               repo:           build.repo,
               branch:         build.branch
             }
      CiInACan::Persistence.save("test_run_list", test_result.created_at, data)
    end

    def self.all
      blah = CiInACan::Persistence.hash_for("test_run_list")
      blah.sort_by { |x| x[0] }.reverse.map { |x| new x[1] }
    end

  end

end
