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
    path = JvmwatcherUtil.find_watcher_java_path("log", JvmwatcherUtil::Log4JFileName)
    puts path
    path = JvmwatcherUtil.find_watcher_java_path("bin", JvmwatcherUtil::SetEnvTemplateFileName)
    puts path
    path = JvmwatcherUtil.find_watcher_java_path("log", JvmwatcherUtil::Log4JTemplateFileName)
    puts path
  end

end
