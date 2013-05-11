Java VM status input plugin for Fluent
====
fluent-plugin-jvmwatcher is input plugin which collects the CPU usage rate and the memory usage of more than one JavaVM, information on GC to the constant period.

fluent-plugin-jvmwatcherは、複数のJavaVMの、CPU使用率やメモリ使用量、GCの情報を、一定周期に収集するinput pluginです。

## Installation


What you have to do is only installing like this:

    $ gem install fluent-plugin-jvmwatcher

Then fluent automatically loads the plugin installed.

## Configuration

    <source>
      type jvmwatcher
      log_interval 1000
      log_buff_num 3
      jvm_refind_interval 30000
      filter_config_path filter_config.json
      tag jvmwatcher.log
    </source>

## filtering Configuration

    {"target" :
      [
        { "shortname" : "TestJavaProcess" ,  "pattern" : "(jvmwatcher.test.TestJavaProcess)"},
        { "shortname" : "Tomcat" ,  "pattern" : "(org.apache.catalina)"}
      ]
    }

There is a sample of the command which outputs the list of the Java process under the directory of fluent-plugin-jvmwatcher which was installed in gem and the definition file of filtering.

gemでインストールした、fluent-plugin-jvmwatcherのディレクトリの下に、Javaプロセスの一覧を出力するコマンドと、フィルタリングの定義ファイルのサンプルがあります。


    fluent-plugin-jvmwatcher-*.*.*
      |-lib
         |-fluent
             |-plugin
                 |-jvmwatcher
                     |- bin 
                     |   |-JvmProcCheck.sh
                     |-config
                     |   |-config_sample.json <-- sample file
                     |   |-filter_config.json <-- It is the filter definition file which you created.



###Java process listup.
Before creating the definition file of filtering, it executes JvmProcCheck.sh command and it makes output the list of the Java process which is working on the host.
It finds the character string which suited the key word to use for the regular expression to set to "pattern" from the name of the Java process which is output by [ CommandLine ] of the list.

フィルタリングの定義ファイルを作成する前に、JvmProcCheck.shコマンドを実行して、ホスト上で動作しているJavaプロセスの一覧を出力させます。
一覧の[CommandLine]に出力されるJavaプロセスの名称から、"pattern"に設定する正規表現に使用するキーワードに適した文字列を、見つけ出します。

    cd lib/fluent/plugin/jvmwatcher/bin
    ./JvmProcCheck.sh

Output

    -- process list start --
    Target prosecc  [pid]=7552  [ShortName]=org.eclipse.equinox.launcher_1.3.0.v20120522-1813.jar -os linux -ws gtk -arch x86_64 -showsplash -launcher /home/miyake/Develop/Java/Tools/eclipse_juno/eclipse -name Eclipse --launcher.library /home/miyake/Develop/Java/Tools/eclipse_juno//plugins/org.eclipse.equinox.launcher.gtk.linux.x86_64_1.1.200.v20120913-144807/eclipse_1502.so -startup /home/miyake/Develop/Java/Tools/eclipse_juno//plugins/org.eclipse.equinox.launcher_1.3.0.v20120522-1813.jar --launcher.overrideVmargs -exitdata 60009 -product org.eclipse.epp.package.jee.product -vm /usr/bin/java -vmargs -Dosgi.requiredJavaVersion=1.5 -Dhelp.lucene.tokenizer=standard -XX:MaxPermSize=256m -Xms512m -Xmx1024m -javaagent:/home/miyake/Develop/Java/Tools/eclipse_juno/plugins/jp.sourceforge.mergedoc.pleiades/pleiades.jar -jar /home/miyake/Develop/Java/Tools/eclipse_juno//plugins/org.eclipse.equinox.launcher_1.3.0.v20120522-1813.jar  [CommandLine]=/home/miyake/Develop/Java/Tools/eclipse_juno//plugins/org.eclipse.equinox.launcher_1.3.0.v20120522-1813.jar -os linux -ws gtk -arch x86_64 -showsplash -launcher /home/miyake/Develop/Java/Tools/eclipse_juno/eclipse -name Eclipse --launcher.library /home/miyake/Develop/Java/Tools/eclipse_juno//plugins/org.eclipse.equinox.launcher.gtk.linux.x86_64_1.1.200.v20120913-144807/eclipse_1502.so -startup /home/miyake/Develop/Java/Tools/eclipse_juno//plugins/org.eclipse.equinox.launcher_1.3.0.v20120522-1813.jar --launcher.overrideVmargs -exitdata 60009 -product org.eclipse.epp.package.jee.product -vm /usr/bin/java -vmargs -Dosgi.requiredJavaVersion=1.5 -Dhelp.lucene.tokenizer=standard -XX:MaxPermSize=256m -Xms512m -Xmx1024m -javaagent:/home/miyake/Develop/Java/Tools/eclipse_juno/plugins/jp.sourceforge.mergedoc.pleiades/pleiades.jar -jar /home/miyake/Develop/Java/Tools/eclipse_juno//plugins/org.eclipse.equinox.launcher_1.3.0.v20120522-1813.jar
    Target prosecc  [pid]=7723  [ShortName]=sun.tools.jconsole.JConsole  [CommandLine]=sun.tools.jconsole.JConsole
    Target prosecc  [pid]=2677  [ShortName]=org.apache.catalina.startup.Bootstrap start  [CommandLine]=org.apache.catalina.startup.Bootstrap start
    Target prosecc  [pid]=7684  [ShortName]=jvmwatcher.test.TestJavaProcess 4096 512 20 5  [CommandLine]=jvmwatcher.test.TestJavaProcess 4096 512 20 5
    Target prosecc  [pid]=7640  [ShortName]=jvmwatcher.test.TestJavaProcess 1024 2048 10 5  [CommandLine]=jvmwatcher.test.TestJavaProcess 1024 2048 10 5
    -- process list end   --

###Java process filtering check.
Create the definition file of filtering from the found key word and preserve it under config.
It executes JvmProcCheck.sh command and it confirms that only a Java process for the purpose is done by filtering by the definition file of created filtering.
The way of confirming set the definition file of created filtering to the argument of the JvmProcCheck.sh command and execute it.

見つけ出したキーワードから、フィルタリングの定義ファイルを作成し、configの下に保存して下さい。
作成したフィルタリングの定義ファイルによって、目的のJavaプロセスだけがフィルタリングされることは、JvmProcCheck.shコマンドを実行して確認します。
確認方法は、作成したフィルタリングの定義ファイルを、JvmProcCheck.shコマンドの引数に設定して、実行してください。

    ./JvmProcCheck.sh ../config/filter_config.json

Output

    -- process list start --
    Target prosecc  [pid]=2677  [ShortName]=Tomcat  [CommandLine]=org.apache.catalina.startup.Bootstrap start
    Target prosecc  [pid]=7684  [ShortName]=TestJavaProcess  [CommandLine]=jvmwatcher.test.TestJavaProcess 4096 512 20 5
    Target prosecc  [pid]=7640  [ShortName]=TestJavaProcess  [CommandLine]=jvmwatcher.test.TestJavaProcess 1024 2048 10 5
    -- process list end   --


##JVM status log sample
It is the sample of the log which was output from jvmwatcher.
This sample is outputting only a necessary Java process using filter_config_path of the configuration.
The name to set to "shortname" of the definition file of filtering is output by "name" of the output log.
When not using filter_config_path of the configuration, the contents which are the same as "display_name" are output by "shortname".
Also, the log of all Java processes of the node is output.

jvmwatcherから出力されたログのサンプルです。
このサンプルは、コンフィグレーションのfilter_config_pathを使用して、必要なJavaプロセスだけを出力しています。
出力されているログの"name"には、フィルタリングの定義ファイルの"shortname"に設定している名称が出力されます。
コンフィグレーションのfilter_config_pathを使用しない場合は、"shortname"に"display_name"と同じ内容が出力されます。また、ノードのすべてのJavaプロセスのログが出力されます。

    2013-05-11T13:53:50+09:00       jvmwatcher.log  {"logtime":1368248030423,"host_name":"nanoha","proc_state":"START_PROCESS","pid":2677,"name":"Tomcat","display_name":"org.apache.catalina.startup.Bootstrap start","start_time":1368235715885,"up_time":12314590,"cpu_usage":0.13756041,"compile_time":2280,"c_load_cnt":2110,"c_unload_cnt":0,"c_total_load_cnt":2111,"th_cnt":15,"daemon_th_cnt":14,"peak_th_cnt":15,"heap_init":62766272,"heap_used":14218752,"heap_commit":60227584,"heap_max":892928000,"notheap_init":24313856,"notheap_used":18505232,"notheap_commit":31784960,"notheap_max":224395264,"pending_fin_cnt":0,"total_phy_mem_size":4017041408,"total_swap_mem_size":4160741376,"free_phy_mem_size":1830621184,"free_swap_mem_size":4160741376,"commit_vmem_size":2432827392,"gc_collect":[{"gc_mgr_name":"PS MarkSweep","gc_coll_cnt":4,"gc_coll_time":159},{"gc_mgr_name":"PS Scavenge","gc_coll_cnt":7,"gc_coll_time":44}]}
    2013-05-11T13:53:51+09:00       jvmwatcher.log  {"logtime":1368248031423,"host_name":"nanoha","proc_state":"LIVE_PROCESS","pid":2677,"name":"Tomcat","display_name":"org.apache.catalina.startup.Bootstrap start","start_time":1368235715885,"up_time":12315551,"cpu_usage":4.162331,"compile_time":2334,"c_load_cnt":2153,"c_unload_cnt":0,"c_total_load_cnt":2153,"th_cnt":15,"daemon_th_cnt":14,"peak_th_cnt":15,"heap_init":62766272,"heap_used":15915928,"heap_commit":60227584,"heap_max":892928000,"notheap_init":24313856,"notheap_used":18749552,"notheap_commit":31784960,"notheap_max":224395264,"pending_fin_cnt":0,"total_phy_mem_size":4017041408,"total_swap_mem_size":4160741376,"free_phy_mem_size":1805737984,"free_swap_mem_size":4160741376,"commit_vmem_size":2432827392,"gc_collect":[{"gc_mgr_name":"PS MarkSweep","gc_coll_cnt":4,"gc_coll_time":159},{"gc_mgr_name":"PS Scavenge","gc_coll_cnt":7,"gc_coll_time":44}]}
    2013-05-11T13:53:52+09:00       jvmwatcher.log  {"logtime":1368248032423,"host_name":"nanoha","proc_state":"LIVE_PROCESS","pid":2677,"name":"Tomcat","display_name":"org.apache.catalina.startup.Bootstrap start","start_time":1368235715885,"up_time":12316551,"cpu_usage":1.0,"compile_time":2334,"c_load_cnt":2154,"c_unload_cnt":0,"c_total_load_cnt":2154,"th_cnt":15,"daemon_th_cnt":14,"peak_th_cnt":15,"heap_init":62766272,"heap_used":16446200,"heap_commit":60227584,"heap_max":892928000,"notheap_init":24313856,"notheap_used":18755256,"notheap_commit":31784960,"notheap_max":224395264,"pending_fin_cnt":0,"total_phy_mem_size":4017041408,"total_swap_mem_size":4160741376,"free_phy_mem_size":1803935744,"free_swap_mem_size":4160741376,"commit_vmem_size":2432827392,"gc_collect":[{"gc_mgr_name":"PS MarkSweep","gc_coll_cnt":4,"gc_coll_time":159},{"gc_mgr_name":"PS Scavenge","gc_coll_cnt":7,"gc_coll_time":44}]}
    2013-05-11T13:53:50+09:00       jvmwatcher.log  {"logtime":1368248030850,"host_name":"nanoha","proc_state":"START_PROCESS","pid":7684,"name":"TestJavaProcess","display_name":"jvmwatcher.test.TestJavaProcess 4096 512 20 5","start_time":1368244328237,"up_time":3702631,"cpu_usage":2.3138952,"compile_time":82,"c_load_cnt":1126,"c_unload_cnt":0,"c_total_load_cnt":1127,"th_cnt":14,"daemon_th_cnt":8,"peak_th_cnt":14,"heap_init":62766272,"heap_used":5471312,"heap_commit":6881280,"heap_max":892928000,"notheap_init":24313856,"notheap_used":9034992,"notheap_commit":24313856,"notheap_max":224395264,"pending_fin_cnt":0,"total_phy_mem_size":4017041408,"total_swap_mem_size":4160741376,"free_phy_mem_size":1817698304,"free_swap_mem_size":4160741376,"commit_vmem_size":2421960704,"gc_collect":[{"gc_mgr_name":"PS MarkSweep","gc_coll_cnt":1243,"gc_coll_time":10825},{"gc_mgr_name":"PS Scavenge","gc_coll_cnt":12796,"gc_coll_time":11733}]}
    2013-05-11T13:53:51+09:00       jvmwatcher.log  {"logtime":1368248031851,"host_name":"nanoha","proc_state":"LIVE_PROCESS","pid":7684,"name":"TestJavaProcess","display_name":"jvmwatcher.test.TestJavaProcess 4096 512 20 5","start_time":1368244328237,"up_time":3703650,"cpu_usage":7.8508344,"compile_time":96,"c_load_cnt":1169,"c_unload_cnt":0,"c_total_load_cnt":1169,"th_cnt":14,"daemon_th_cnt":8,"peak_th_cnt":14,"heap_init":62766272,"heap_used":6286216,"heap_commit":9043968,"heap_max":892928000,"notheap_init":24313856,"notheap_used":9261848,"notheap_commit":24313856,"notheap_max":224395264,"pending_fin_cnt":0,"total_phy_mem_size":4017041408,"total_swap_mem_size":4160741376,"free_phy_mem_size":1804816384,"free_swap_mem_size":4160741376,"commit_vmem_size":2421960704,"gc_collect":[{"gc_mgr_name":"PS MarkSweep","gc_coll_cnt":1243,"gc_coll_time":10825},{"gc_mgr_name":"PS Scavenge","gc_coll_cnt":12797,"gc_coll_time":11735}]}
    2013-05-11T13:53:52+09:00       jvmwatcher.log  {"logtime":1368248032852,"host_name":"nanoha","proc_state":"LIVE_PROCESS","pid":7684,"name":"TestJavaProcess","display_name":"jvmwatcher.test.TestJavaProcess 4096 512 20 5","start_time":1368244328237,"up_time":3704647,"cpu_usage":4.5135407,"compile_time":102,"c_load_cnt":1171,"c_unload_cnt":0,"c_total_load_cnt":1171,"th_cnt":14,"daemon_th_cnt":8,"peak_th_cnt":14,"heap_init":62766272,"heap_used":7337016,"heap_commit":9437184,"heap_max":892928000,"notheap_init":24313856,"notheap_used":9278600,"notheap_commit":24313856,"notheap_max":224395264,"pending_fin_cnt":0,"total_phy_mem_size":4017041408,"total_swap_mem_size":4160741376,"free_phy_mem_size":1803935744,"free_swap_mem_size":4160741376,"commit_vmem_size":2421960704,"gc_collect":[{"gc_mgr_name":"PS MarkSweep","gc_coll_cnt":1243,"gc_coll_time":10825},{"gc_mgr_name":"PS Scavenge","gc_coll_cnt":12798,"gc_coll_time":11736}]}

In the date and time which is output at the head of the log, it is generating from "logtime" which is the time by which the information was acquired actually from JavaVM.

ログの先頭に出力されている日時は、実際にJavaVMから情報を取得した時間である"logtime"から生成しています。
