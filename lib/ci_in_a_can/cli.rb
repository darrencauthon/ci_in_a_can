module CiInACan

  module Cli

    def self.run args

      case args[0].to_s.downcase
      when 'create'
        root = "#{Dir.pwd}/#{args[1]}"
        id   = root.split('/').pop

        CiInACan::Cli::StructureBuilder.new(root: root, id: id).create
      end

    end

  end

end

Dir[File.dirname(__FILE__) + '/cli/*.rb'].each { |file| require file }
