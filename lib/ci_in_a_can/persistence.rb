require 'yaml/store'

module CiInACan

  module Persistence

    def self.save type, id, value
      store = store_for(type)
      store.transaction { store[id] = value }
    end

    def self.find type, id
      store = store_for(type)
      store.transaction(true) { store[id] }
    end

    private

    def self.store_for type
      YAML::Store.new("#{CiInACan.results_location}/#{type}.yml")
    end

  end

end
