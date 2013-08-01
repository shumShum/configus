module Configus

  class HashConstructor

    attr_accessor :hash

    def initialize(block)
      @hash = Hash.new
      instance_eval &block
    end

    class << self
      def block_to_hash(block)
        hc = new(block)
        hc.hash
      end
    end

    def method_missing(meth, *args, &block)
      @hash[meth] = block_given? ? self.class.block_to_hash(block) : args.first
    end

  end
end