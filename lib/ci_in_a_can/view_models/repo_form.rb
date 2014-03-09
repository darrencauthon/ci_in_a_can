module CiInACan

  module ViewModels

    class RepoForm < ViewModel

      def to_html
<<EOF
<form action="/repo/#{id}" method="post">
<div>#{url}</div>
<textarea name="commands">
#{build_commands.join("\n")}
</textarea>
<input type="submit">Submit</input>
</form>
EOF
      end

    end

  end

end
