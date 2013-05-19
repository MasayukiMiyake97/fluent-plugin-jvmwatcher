#
# A Java VM status Watcher for Fluent
#
# Copyright (C) 2013 Masayuki Miyake
#
#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at
#
#        http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.
#
module Fluent

require 'json'
require 'fluent/plugin/jvmwatcher_util'

class JvmwatcherInput < Input
  Plugin.register_input('jvmwatcher', self)

  def initialize
    super
    @log4j_path = JvmwatcherUtil.make_log4j_file
    @setenv_path = JvmwatcherUtil.make_setenv_file
    @bin_path = JvmwatcherUtil.find_watcher_java_path(JvmwatcherUtil::BinDirName)
    @jvmwatcher_connamd = File.join(@bin_path, "JvmWatcher.sh")
  end

  config_param :tag, :string
  config_param :filter_config_path, :string, :default => nil
  config_param :log_interval, :integer, :default => 1000
  config_param :log_buff_num, :integer, :default => 1
  config_param :jvm_refind_interval, :integer, :default => 20000

  def start
    @config_path = JvmwatcherUtil.find_filter_config_path(@filter_config_path)
    command = "#{@jvmwatcher_connamd} '#{@config_path}' #{@jvm_refind_interval} #{@log_interval} #{@log_buff_num} #{@setenv_path}"

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

