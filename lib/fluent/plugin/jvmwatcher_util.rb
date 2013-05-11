
module JvmwatcherUtil

  SetEnvFileName = "setEnvWatcher.sh"
  Log4JFileName  = "log4j.xml"
  SetEnvTemplateFileName = "setEnv.sh.template"
  Log4JTemplateFileName  = "log4j.xml.template"

  BinDirName     = "bin"
  LibDirName     = "lib"
  ConfigDirName  = "config"
  LogDirName     = "log"

  def find_watcher_java_path (dir_name, file_name = nil)

    java_path = nil

    $LOAD_PATH.map do |load_path|
      path = File.join(load_path, "fluent/plugin")  # make fluentd plugin path
      if File.directory?(path)

        # find target directory
        Dir.glob("#{path}/jvmwatcher/#{dir_name}").each do |path_name|

          next unless File.directory?(path_name)  # chech directory

          if file_name
            # check file
            java_path = File.join(path_name, file_name)
            java_path = nil unless File.file?(java_path)
          else
            java_path = path_name
          end

          break if java_path
        end
      end

      break if java_path
    end

    return java_path
  end


  def make_setenv_file

    template_path = find_watcher_java_path(BinDirName, SetEnvTemplateFileName)
    output_path = find_watcher_java_path(BinDirName)
    lib_path = find_watcher_java_path(LibDirName)
    config_path = find_watcher_java_path(ConfigDirName)

    # path nil check
    return nil unless template_path
    return nil unless output_path
    return nil unless lib_path
    return nil unless config_path

    output_path = File.join(output_path, SetEnvFileName)
    # make setEnvWatcher.sh
    temp_io = File.open(template_path, "r")
    env_io = File.open(output_path, "w")

    temp_io.each do |line|
      line.chomp!
      line = line.gsub(/\[LIB_PATH\]/, lib_path)
      line = line.gsub(/\[CONFIG_PATH\]/, config_path)

      env_io.puts(line)
    end

    temp_io.close
    env_io.close 

    return output_path

  end


  def make_log4j_file

    template_path = find_watcher_java_path(ConfigDirName, Log4JTemplateFileName)
    output_path = find_watcher_java_path(ConfigDirName)
    log_path = find_watcher_java_path(LogDirName)

    # path nil check
    return nil unless template_path
    return nil unless output_path
    return nil unless log_path

    output_path = File.join(output_path, Log4JFileName)
    # make setEnvWatcher.sh
    temp_io = File.open(template_path, "r")
    env_io = File.open(output_path, "w")

    temp_io.each do |line|
      line.chomp!
      line = line.gsub(/\[LOG_PATH\]/, log_path)

      env_io.puts(line)
    end

    temp_io.close
    env_io.close 

    return output_path

  end


  def find_filter_config_path (config_path)

    # check nil
    return "NO_CONFIG" unless config_path

    unless File.file?(config_path)

      path = find_watcher_java_path(ConfigDirName)
      config_path = File.join(path, config_path)
      config_path = "NO_CONFIG" unless File.file?(config_path)

    end

    return config_path
  end

  module_function :find_watcher_java_path
  module_function :make_setenv_file
  module_function :make_log4j_file
  module_function :find_filter_config_path

end

