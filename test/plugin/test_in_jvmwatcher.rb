require 'helper'

class JvmWatcherInputTest < Test::Unit::TestCase
  def setup
    Fluent::Test.setup
  end

  CONFIG = %[
    tag jvmwatcher.log
  ]

  def create_driver(conf = CONFIG)
    Fluent::Test::InputTestDriver.new(Fluent::ScribeInput).configure(conf)
  end

  def test_configure
    d = create_driver
    #### check configurations
    assert_equal 'jvmwatcher.log', d.instance.tag
  end


end
