module CiInACan

  module ViewModels

    class RunViewModel < ViewModel

      def to_html
<<EOF
                    <tr>
                      <td>
                        #{created_at}
                      </td>
                      <td>
                        <a href="/repo/#{repo}">
                        #{repo}
                        </a>
                      </td>
                      <td>
                        #{branch}
                      </td>
                      <td>
                        #{passed ? 'Yes' : 'No'}
                      </td>
                      <td>
                        <a href="/test_result/#{test_result_id}">#{sha}</a>
                      </td>
                    </tr>
EOF
      end

    end

  end

end
