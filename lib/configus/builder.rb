require "active_support/core_ext/hash/deep_merge"

module Configus

  class Builder

    attr_accessor :conf_environment, :conf_structure 

    def initialize(default_environment, block)
      self.conf_structure ||= {}
      self.conf_environment = default_environment
      instance_eval &block
    end

    def self.build(def_env, &block)
      builder = new(def_env, &block)
      Config.new(builder.result)
    end

    def env(environment, options = {}, &block)
      if block_given?
        raise ArgumentError if self.conf_structure.keys.include?(environment)
        if options.any?    
          self.conf_structure[environment.to_sym] = self.conf_structure[options[:parent]]
                          .deep_merge HashConstructor.block_to_hash(block)                            
        else
          self.conf_structure[environment.to_sym] = HashConstructor.block_to_hash(block)
        end
      else
        raise ArgumentError
      end
    end

    def result
      self.conf_structure[conf_environment]
    end

  end
end