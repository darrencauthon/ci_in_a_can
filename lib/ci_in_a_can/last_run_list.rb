module CiInACan

  module LastRunList

    def self.add build, test_result
      CiInACan::Persistence.save("test_run_list", test_result.created_at, { created_at: test_result.created_at })
    end

    def self.all
      blah = CiInACan::Persistence.hash_for("test_run_list")
      [blah.first[1]]
    end

  end

end
