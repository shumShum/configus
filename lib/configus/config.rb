module Configus

  class Config
    def initialize(init_hash)
      init_hash.each do |key, value|
        self.define_singleton_method(key) do
           value.is_a?(Hash) ? Config.new(value) : value
        end
      end
    end

    def method_missing(method_name, *args, &block)
      raise NoMethodError, "Undefined method #{method_name} with #{args}"
    end
  end
end