require 'subtle'
require 'yaml/store'

module CiInACan
  class TestResult
    params_constructor
    attr_accessor :id
    attr_accessor :passed, :output

    def self.create values

      store = YAML::Store.new("data.yml")

      values[:id] = UUID.new.generate
      saved = self.new values

      store.transaction do
        store[saved.id] = saved
      end
    end

    def self.find id
      store = YAML::Store.new("data.yml")
      store.transaction(true) do
        store[id]
      end
    end
  end
end
