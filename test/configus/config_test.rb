require 'test_helper'

class TestConfig < MiniTest::Test
  
  def setup
    @options = {
      foo: 'bar',
      parent: {
        child1: 'value1',
        child2: 'value2',
        child_parent: {
          key: 'value'
        }
      },
    }  
    @config = Configus::Config.new(@options)
  end

  def test_config
    assert_equal @config.foo, 'bar'
    assert_equal @config.parent.child1, 'value1'
    assert_equal @config.parent.child_parent.key, 'value'

    assert_raises(NoMethodError) { @config.undefined_key }
    assert_raises(NoMethodError) do
      @config.new_key = "val"
    end
  end
end