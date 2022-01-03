#!/bin/sh

# all our current distros support C.UTF-8 out of the box, except
# CentOS 7, which comes with an en_US.UTF-8 override by default.

if locale -a | grep -iE '^c\.utf.?8'
then
  export LC_ALL=C.UTF-8 \
         LANG=C.UTF-8
else
  export LC_ALL=en_US.UTF-8 \
         LANG=en_US.UTF-8
fi
