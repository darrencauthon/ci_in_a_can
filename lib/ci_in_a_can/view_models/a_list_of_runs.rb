module CiInACan

  module ViewModels

    class AListOfRuns < ViewModel

      def to_html
        run_html = the_original_value.map { |r| r.to_html }.join("\n")
<<EOF
    <table class="table table-bordered">
      <tbody>
      #{run_html}
      </tbody>
    </table>
EOF
      end

    end

  end

end
