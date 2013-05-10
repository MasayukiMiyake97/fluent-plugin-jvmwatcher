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

Java process listup.

    JvmProcCheck.sh

Java process filtering check.

    JvmProcCheck.sh ../config/filter_config.json



