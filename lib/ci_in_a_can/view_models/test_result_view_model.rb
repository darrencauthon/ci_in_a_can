module CiInACan

  module ViewModels

    class TestResultViewModel < ViewModel

      def to_html
<<EOF
    <table class="table table-bordered">
      <tbody>
      <tr>
        <td>
          Id
        </td>
        <td>
          #{id}
        </td>
      </tr>
      <tr>
        <td>
          Repo
        </td>
        <td>
          <a href="/repo/#{repo}">
          #{repo}
          </a>
        </td>
      </tr>
      <tr>
        <td>
          Branch
        </td>
        <td>
          #{branch}
        </td>
      </tr>
      <tr>
        <td>
          Created At
        </td>
        <td>
          #{created_at.to_s}
        </td>
      </tr>
      <tr>
        <td>
          Passed
        </td>
        <td>
          #{passed ? 'Yes' : 'No'}
        </td>
      </tr>
      <tr>
        <td>
          Output
        </td>
        <td>
          #{output.to_s.gsub("\n", '<br />')}
        </td>
      </tr>
      </tbody>
    </table>
EOF
      end

    end

  end

end
