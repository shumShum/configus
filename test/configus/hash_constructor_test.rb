require 'test_helper'

class TestHashConstructor < MiniTest::Test

  def setup
    proc = Proc.new do
      foo 'bar'
    end
    @hc = Configus::HashConstructor.new(proc)
  end

  def test_hc
    assert_equal @hc.hash, {foo: 'bar'}
  end
end