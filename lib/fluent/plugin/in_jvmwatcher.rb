module Fluent

require 'json'

class JvmwatcherInput < Input
  Plugin.register_input('jvmwatcher', self)

  def initialize
    super
    @jvmwatcher_connamd = './JvmWatcher.sh'

    Dir::chdir("fluent-plugin-jvmwatcher/lib/fluent/plugin/jvmwatcher/bin")
  end

  config_param :tag, :string
  config_param :log_interval, :integer, :default => 1000
  config_param :log_buff_num, :integer, :default => 1
  config_param :jvm_refind_interval, :integer, :default => 20000

  def start
    command = "#{@jvmwatcher_connamd} NO_CONFIG #{@jvm_refind_interval} #{@log_interval} #{@log_buff_num} setEnv.sh"

    @io = IO.popen(command, "r")
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

