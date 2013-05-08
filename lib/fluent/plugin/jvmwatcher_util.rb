
module JvmwatcherUtil

  SetEnvFileName = "setEnv.sh"
  Log4JFileName  = "log4j.xml"
  SetEnvTemplateFileName = "setEnv.sh.template"
  Log4JTemplateFileName  = "log4j.xml.template"

  BinDirName     = "bin"
  LibDirName     = "lib"
  ConfigDirName  = "config"
  LogDirName     = "log"

  LibPathKey     = "[LIB_PATH]"
  ConfigPathKey  = "[CONFIG_PATH]"
  LogPathKey     = "[LOG_PATH]"


  def find_watcher_java_path (dir_name, file_name = nil)

    java_path = nil

    $LOAD_PATH.map do |load_path|
      path = File.join(load_path, "fluent/plugin")  # make fluentd plugin path
      if File.directory?(path)

        # find target directory
        Dir.glob("**/jvmwatcher/#{dir_name}").each do |path_name|

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

  end


  def make_log4j_file

  end



  module_function :find_watcher_java_path
  module_function :make_setenv_file
  module_function :make_log4j_file

end

