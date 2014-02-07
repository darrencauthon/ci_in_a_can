module CiInACan

  module Runner

    def self.run build

      CiInACan::Cloner.clone_a_local_copy_for build

    end

  end

end
