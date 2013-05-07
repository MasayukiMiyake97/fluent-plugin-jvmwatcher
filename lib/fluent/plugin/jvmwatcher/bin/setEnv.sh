#!/bin/bash
export WATCHER_LIBPATH=../lib
export WATCHER_CONFIGPATH=../config

# get JDK path
pathtojava=$(readlink -e $(which javac))
export JDK_LIB=${pathtojava%/*/*}/lib

