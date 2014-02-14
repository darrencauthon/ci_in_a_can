module CiInACan

  module LastRunList

    def self.add build, test_result
      data = { created_at: test_result.created_at, test_result_id: test_result.id }
      CiInACan::Persistence.save("test_run_list", test_result.created_at, data)
    end

    def self.all
      blah = CiInACan::Persistence.hash_for("test_run_list")
      blah.sort_by { |x| x[0] }.reverse.map { |x| x[1] }
    end

  end

end
