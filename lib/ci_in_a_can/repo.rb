module CiInACan

  class Repo

    params_constructor do
      @api_key        = UUID.new.generate unless @api_key
      @build_commands = [] unless @build_commands
    end

    attr_accessor :id
    attr_accessor :name
    attr_accessor :api_key
    attr_accessor :build_commands

    def self.create data
      data[:api_key] ||= UUID.new.generate
      repo_data = { id:      data[:id],
                    name:    data[:name],
                    api_key: data[:api_key],
                    build_commands: data[:build_commands] }
      CiInACan::Persistence.save('repos', data[:id], repo_data)
      find data[:id]
    end

    def self.find id
      data = CiInACan::Persistence.find('repos', id)
      return nil unless data
      CiInACan::Repo.new(data)
    end

    def save
      data = { id: id, name: name, api_key: api_key, build_commands: build_commands }
      CiInACan::Persistence.save('repos', id, data)
    end

    def self.all
      blah = CiInACan::Persistence.hash_for("repos")
      blah.sort_by { |x| x[0] }.reverse.map { |x| new x[1] }
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
