module CiInACan

  class Repo

    params_constructor do
      @api_key = UUID.new.generate unless @api_key
    end

    attr_accessor :id
    attr_accessor :name
    attr_accessor :api_key

    def self.create data
      repo_data = { id: data[:id], name: data[:name], api_key: data[:api_key] }
      CiInACan::Persistence.save('repos', data[:id], repo_data)
      find data[:id]
    end

    def self.find id
      data = CiInACan::Persistence.find('repos', id)
      CiInACan::Repo.new(data)
    end

  end

end
