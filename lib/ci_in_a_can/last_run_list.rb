module CiInACan

  module LastRunList

    class TestRunResult
      def initialize value
        @value = value
      end
      def method_missing(meth, *args, &blk)
        @value[meth]
      end
    end

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
      blah.sort_by { |x| x[0] }.reverse.map { |x| TestRunResult.new x[1] }
    end

  end

end
