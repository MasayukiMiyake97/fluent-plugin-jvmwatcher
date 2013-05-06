#!/bin/bash

localhostname=$(hostname)

# get JDK path
pathtojava=$(readlink -e $(which javac))
JDK_LIB=${pathtojava%/*/*}/lib

export CLASSPATH=$CLASSPATH:../lib/jvmwatcher.jar
export CLASSPATH=$CLASSPATH:../lib/jackson-core-2.2.0.jar
export CLASSPATH=$CLASSPATH:../lib/commons-logging-1.1.2.jar
export CLASSPATH=$CLASSPATH:../lib/log4j-1.2.17.jar
export CLASSPATH=$CLASSPATH:$JDK_LIB/tools.jar
export CLASSPATH=$CLASSPATH:../config

java org.fluentd.jvmwatcher.JvmWatcher watcher $1 $localhostname

exit 0
