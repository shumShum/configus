require 'test_helper'

class TestSimpleBuilder < MiniTest::Test
  
  def setup
    proc = Proc.new do
      env :production do
        key 'value'  
      end    
    end
    @builder = Configus::Builder.new(:production, proc)
    @options = @builder.result
  end

  def test_return_simple_structure
    assert_equal @options, {key: "value"} 
  end

  # def test_call_key
  #   binding.pry
  #   assert_equal @builder.key, "value"
  # end

  # def test_raise_error_call_key=
  #   assert_raises(NoMethodError) { @builder.new_key = "value" }
  # end

end

class TestMultilevelBuilder < MiniTest::Test

  def setup
    proc = Proc.new do
      env :production do
        website_url 'http://example.com'
        email do
          pop do
            address 'pop.example.com'
            port    110
          end
          smtp do
            address 'smtp.example.com'
            port    25
          end
        end
      end    
    end
    @builder = Configus::Builder.new(:production, proc)
    @options = @builder.result
  end

  def test_return_multilevel_structure
    result_hash = {
      website_url: 'http://example.com',
      email: {
        pop: {
          address: 'pop.example.com',
          port: 110
        },
        smtp: {
          address: 'smtp.example.com',
          port: 25
        }
      }
    }
    assert_equal @options, result_hash
  end

end