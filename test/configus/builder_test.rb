require 'test_helper'

class TestBuilder < MiniTest::Test
  
  def setup
    proc = Proc.new do
      env :production do
        key 'value'  
      end    
    end
    @builder = Configus::Builder.new(:production, proc)
  end

  def test_config
    assert_equal @builder, {key: 'value'}
  end
end