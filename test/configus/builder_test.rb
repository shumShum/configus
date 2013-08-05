require 'test_helper'

class TestBuilder < MiniTest::Test

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

      env :development, :parent => :production do
        website_url 'http://text.example.com'
        email do
          smtp do
            address 'smpt.text.example.com'
          end
        end
      end  
    end

    @builder_product = Configus::Builder.new(:production, proc)
    @options_product = @builder_product.result

    @builder_dev = Configus::Builder.new(:development, proc)
    @options_dev = @builder_dev.result
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
    assert_equal @options_product, result_hash
  end

  def test_another_env
    result_hash = {
      :website_url=>"http://text.example.com", 
      :email=>{
        :pop=>{
          :address=>"pop.example.com",
          :port=>110
        }, 
        :smtp=>{
          :address=>"smpt.text.example.com",
          :port=>25
        }
      }
    }
    assert_equal @options_dev, result_hash
  end

  def test_error_if_double_definition
    proc = Proc.new do
      env :production do
        website_url 'http://example.com'
      end

      env :production do
        key 'value'
      end
    end
    assert_raises(ArgumentError) { Configus::Builder.new(:production, proc) }
  end
end