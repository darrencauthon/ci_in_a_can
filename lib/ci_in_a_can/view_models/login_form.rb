module CiInACan

  module ViewModels

    class LoginForm < ViewModel

      def to_html
<<EOF
<form action="/login" method="post">
Passphrase
<input type="password" name="passphrase">
<button type="submit">Submit</button>
</form>
EOF
      end

    end

  end

end

