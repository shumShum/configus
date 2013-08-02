require "configus/version"

module Configus
  
  autoload :Builder, 'configus/builder'
  autoload :HashConstructor, 'configus/hash_constructor'
  autoload :Config, 'configus/config'

  def self.build(default_env, &block)
    @config = Builder.build(default_env, &block)
  end
end
