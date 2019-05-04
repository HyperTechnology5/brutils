#!/bin/bash
#
# Some voidlinux specific things...
#
## Check if we are using voidlinux musl
if type xbps-query >/dev/null 2>&1 ; then
  if ( xbps-query -L | grep -q musl ) ; then
    if type glibc >/dev/null 2>&1 ; then
      echo "Using musl, switching to glibc" 1>&2
      exec glibc bash "$0" "$@"
    else
      echo "This does not work with MUSL, must use GLIBC" 1>&2
      exit 2
    fi
  fi
fi
