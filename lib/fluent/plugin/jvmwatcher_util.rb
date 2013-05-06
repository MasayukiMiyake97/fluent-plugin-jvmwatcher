require 'json'

module JvmwatcherUtil

  ConfigFileName = "config.json"
  SetEnvFileName = "setEnv.sh"
  SetEnvTemplateFileName = "setEnv.sh.template"
  LibPathKey = "<LIBPATH>"

  def find_java_bin_path

    $LOAD_PATH.map {|lp|
      path = File.join(lp, "fluent/plugin")
      if File.directory?(path)
        Dir.glob("**/jvmwatcher/bin").each do |name|
          puts name
        end
      end
    }
    puts "unit test call"

  end


  def find_java_config_path

    $LOAD_PATH.map {|lp|
      path = File.join(lp, "fluent/plugin")
      if File.directory?(path)
        Dir.glob("**/jvmwatcher/config").each do |name|
          puts name
        end
      end
    }

  end


  def make_config_file (log_interval, log_buff_num, target_map)

  end

  def make_setenv_file

  end










  module_function :find_java_bin_path
  module_function :find_java_config_path





end

