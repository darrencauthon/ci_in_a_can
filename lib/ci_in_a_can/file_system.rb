module CiInACan

  module FileSystem

    def self.create_file file, content
      File.open(file, 'w') { |f| f.write content }
    end

    def self.create_directory directory
      Dir.mkdir(directory) unless File.exists?(directory)
    end

  end

end
