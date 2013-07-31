require 'test_helper'

class TestConfig < MiniTest::Unit::TestCase
  
  def setup
    @option = {}
    @config = Config.new(@option)
  end

  def test_config
    assert_equal @config.foo, @option[:foo]
  end
end