module CiInACan

  class Repo

    params_constructor

    attr_accessor :id

    def self.create repo
      CiInACan::Persistence.save('repos', repo[:id], { id: repo[:id] } )
    end

    def self.find id
      data = CiInACan::Persistence.find('repos', id)
      CiInACan::Repo.new(data)
    end

  end

end
