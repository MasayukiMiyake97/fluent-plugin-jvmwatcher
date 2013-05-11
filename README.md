Java VM status input plugin for Fluent
====

2013/07/06：まだ完成していないため、利用できません...orz

July 6th, 2013: Because it hasn't been complete yet, fluent-plugin-jvmwatcher can not be used by installing it.


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
        { "shortname" : "Tomcat" ,  "pattern" : "(tomcat)"}
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



