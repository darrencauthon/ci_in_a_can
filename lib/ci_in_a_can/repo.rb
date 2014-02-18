module CiInACan

  class Repo

    params_constructor

    attr_accessor :id
    attr_accessor :name

    def self.create data
      repo_data = { id: data[:id], name: data[:name] }
      CiInACan::Persistence.save('repos', data[:id], repo_data)
    end

    def self.find id
      data = CiInACan::Persistence.find('repos', id)
      CiInACan::Repo.new(data)
    end

  end

end
