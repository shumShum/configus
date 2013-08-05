module Configus

  class Builder

    attr_accessor :conf_environment, :conf_structure 

    def initialize(default_environment, block)
      self.conf_structure ||= {}
      self.conf_environment = default_environment
      instance_eval &block
      puts self.conf_structure
    end

    def self.build(def_env, &block)
      builder = new(def_env, &block)
      Config.new(builder.result)
    end

    def env(environment, options = {}, &block)
      if block_given?
        # if options.any?
        #   self.conf_structure[environment.to_sym] = deep_merge(
        #                                         self.conf_structure[options[:parent]],
        #                                         HashConstructor.block_to_hash(block)
        #                                       )
        # else
          self.conf_structure[environment.to_sym] = HashConstructor.block_to_hash(block)
        # end
      else
        raise ArgumentError
      end
    end

    def result
      self.conf_structure[conf_environment]
    end

    private
    def deep_merge(hash_one, hash_two)
      hash_two.each_pair do |key, val|
        one_val = hash_one[key]
        hash_one[key] = one_val.is_a?(Hash) && val.is_a?(Hash) ? deep_merge(one_val, val) : val
      end
      hash_one
    end
  end
end