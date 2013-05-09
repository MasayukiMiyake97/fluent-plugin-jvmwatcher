require 'helper'

class JvmWatcherUtilTest < Test::Unit::TestCase

  def setup
    Fluent::Test.setup
  end

  def test_find_watcher_java_path
    path = JvmwatcherUtil.find_watcher_java_path("bin")
    puts path
    path = JvmwatcherUtil.find_watcher_java_path("lib")
    puts path
    path = JvmwatcherUtil.find_watcher_java_path("config")
    puts path
    path = JvmwatcherUtil.find_watcher_java_path("log")
    puts path
    path = JvmwatcherUtil.find_watcher_java_path("logg")
    puts path
    path = JvmwatcherUtil.find_watcher_java_path("bin", JvmwatcherUtil::SetEnvFileName)
    puts path
    path = JvmwatcherUtil.find_watcher_java_path("config", JvmwatcherUtil::Log4JFileName)
    puts path
    path = JvmwatcherUtil.find_watcher_java_path("bin", JvmwatcherUtil::SetEnvTemplateFileName)
    puts path
    path = JvmwatcherUtil.find_watcher_java_path("config", JvmwatcherUtil::Log4JTemplateFileName)
    puts path
  end

  def test_make_setenv_file

    path = JvmwatcherUtil.make_setenv_file
    puts "setenv=" << path

  end

  def test_make_log4j_file

    path = JvmwatcherUtil.make_log4j_file
    puts "setenv=" << path

  end

  def test_find_filter_config_path

    path = JvmwatcherUtil.find_filter_config_path(nil)
    puts "nil  config=" + path
    path = JvmwatcherUtil.find_filter_config_path("config_sample.json")
    puts "config_sample.json  config=" + path
    path = JvmwatcherUtil.find_filter_config_path("/home/miyake/Develop/Project/fluent/fluent-plugin-jvmwatcher/lib/fluent/plugin/jvmwatcher/config/config_sample.json")
    puts "full path  config=" + path
    path = JvmwatcherUtil.find_filter_config_path("config.json")
    puts "nil  config=" + path

  end


end
