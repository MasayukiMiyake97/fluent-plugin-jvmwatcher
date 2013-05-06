require 'helper'

class JvmWatcherUtilTest < Test::Unit::TestCase

  def setup
    Fluent::Test.setup
  end

  def test_find_java_bin_path
    path = JvmwatcherUtil.find_java_bin_path
  end

  def test_find_java_config_path
    path = JvmwatcherUtil.find_java_config_path
  end

end
