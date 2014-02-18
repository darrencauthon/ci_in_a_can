module CiInACan

  class Repo

    params_constructor do
      @api_key = UUID.new.generate unless @api_key
    end

    attr_accessor :id
    attr_accessor :name
    attr_accessor :api_key

    def self.create data
      data[:api_key] ||= UUID.new.generate
      repo_data = { id:      data[:id],
                    name:    data[:name],
                    api_key: data[:api_key] }
      CiInACan::Persistence.save('repos', data[:id], repo_data)
      find data[:id]
    end

    def self.find id
      data = CiInACan::Persistence.find('repos', id)
      CiInACan::Repo.new(data)
    end

    def save
      data = { id: id, name: name, api_key: api_key }
      CiInACan::Persistence.save('repos', id, data)
    end

    def reset_api_key
      data = CiInACan::Persistence.find('repos', id)
      data[:api_key] = UUID.new.generate
      CiInACan::Persistence.save('repos', data[:id], data)
    end

    def url
      "/push/#{id}/#{api_key}"
    end

  end

end
