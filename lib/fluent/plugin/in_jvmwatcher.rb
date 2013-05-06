module Fluent

require 'json'

class JvmwatcherInput < Input
  Plugin.register_input('jvmwatcher', self)

  config_param :tag, :string
  config_param :log_interval, :integer, :default => 1000
  config_param :log_buff_num, :integer, :default => 1
  config_param :jvm_refind_interval, :integer, :default => 20000
  
  def initialize
    super
    @jvmwatcher_connamd = './JvmWatcher.sh'
    $LOAD_PATH.map {|lp|
      path = File.join(lp, "fluent/plugin")
      if File.directory?(path)
        Dir.glob(["**/bin/JvmWatcher.sh", "**/config"]).each do |name|
          puts name
        end
      end
    }

    Dir::chdir("fluent-plugin-jvmwatcher/lib/fluent/plugin/jvmwatcher/bin")
  end



  def start
    @io = IO.popen(@jvmwatcher_connamd, "r")
    @pid = @io.pid
    @thread = Thread.new(&method(:run))
  end

  def shutdown
    Process.kill(:TERM, @pid)
    if @thread.join(60)
      return
    end
    Process.kill(:KILL, @pid)
    @yhread.join
  end

  def run
    @io.each_line(&method(:each_line))
  end

  private
  def each_line(line)
    begin
      line.chomp!
      # JSON text convert to data
      data = JSON.parse(line)
      # get log time
      logtime = data["logtime"] / 1000
 
      Engine.emit(@tag, logtime.to_i , data)
    rescue
      $log.error "exec failed to emit", :error=>$!.to_s
      $log.warn_backtrace $!.backtrace
    end
  end  


end


end

