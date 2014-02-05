module CiInACan

  module Runner

    def self.run data
      `git clone git@github.com:darrencauthon/ci_in_a_can.git temp/#{data['unique_location']}`
      puts `cd temp/#{data['unique_location']}; ls`
    end

  end

end
