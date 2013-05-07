#!/bin/bash

source setEnv.sh

# get JDK path
#pathtojava=$(readlink -e $(which javac))
#JDK_LIB=${pathtojava%/*/*}/lib

export CLASSPATH=$CLASSPATH:$WATCHER_LIBPATH/jvmwatcher.jar
export CLASSPATH=$CLASSPATH:$WATCHER_LIBPATH/jackson-core-2.2.0.jar
export CLASSPATH=$CLASSPATH:$WATCHER_LIBPATH/commons-logging-1.1.2.jar
export CLASSPATH=$CLASSPATH:$WATCHER_LIBPATH/log4j-1.2.17.jar
export CLASSPATH=$CLASSPATH:$JDK_LIB/tools.jar
export CLASSPATH=$CLASSPATH:$WATCHER_CONFIGPATH

echo $1

java org.fluentd.jvmwatcher.JvmWatcher targetlist $1

exit 0
