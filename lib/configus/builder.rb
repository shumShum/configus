module Configus

  class Builder

    attr_accessor :conf_enviroment, :conf_structure 

    def initialize(default_enviroment, block)
      self.conf_enviroment = default_enviroment

      instance_eval &block
    end

    def env(enviroment, &block)
      if block_given?
        hash_constr = HashConstructor.new(block)
        self.conf_structure = hash_constr.hash
      end
    end

    # def method_missing(meth_name, *args, &block)
      # if args.any?
      #   raise NoMethodError if meth_name[-1] == '='
      #   self.conf_structure[meth_name] = args.first
      # else
      #   if block.nil?
      #     self.conf_structure[meth_name]
      #   else
      #     self.conf_structure[meth_name] = 
      #   end
      # end
    # end

    def result
      self.conf_structure
    end

  end
end