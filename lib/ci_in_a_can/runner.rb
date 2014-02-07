module CiInACan

  module Runner

    def self.run build

      CiInACan::Cloner.clone build

    end

  end

end
