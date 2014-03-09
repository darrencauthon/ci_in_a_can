module CiInACan

  module ViewModels

    class LoginForm < ViewModel

      def to_html
        CiInACan::WebContent.layout_page_around(
<<EOF
<form action="/login" method="post">
Passphrase
<input type="password" name="passphrase">
<button type="submit">Submit</button>
</form>
EOF
)
      end

    end

  end

end

