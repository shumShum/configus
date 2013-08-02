module Configus

  class Builder

    attr_accessor :conf_enviroment, :conf_structure 

    def initialize(default_enviroment, block)
      self.conf_enviroment = default_enviroment
      instance_eval &block
    end

    def env(enviroment, &block)
      if block_given?
        self.conf_structure = HashConstructor.block_to_hash(block)
      end
    end

    def result
      self.conf_structure
    end

  end
end