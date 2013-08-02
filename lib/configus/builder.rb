module Configus

  class Builder

    attr_accessor :conf_enviroment, :conf_structure 

    def initialize(default_enviroment, block)
      self.conf_enviroment = default_enviroment
      instance_eval &block
    end

    def self.build(def_env, &block)
      builder = new(def_env, &block)
      Config.new(builder.result)
    end

    def env(enviroment, &block)
      if block_given?
        self.conf_structure = HashConstructor.block_to_hash(block)
      else
        raise ArgumentError
      end
    end

    def result
      self.conf_structure
    end

  end
end