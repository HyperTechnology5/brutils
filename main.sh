#!/bin/bash
#
: $MKSCRIPTNAME $MKSCRIPTDIR
srcdir=${MKSCRIPTDIR:-}
if [ -z "$srcdir" ] ; then
  echo "Must be called from \"mk\"" 1>&2
  exit 1
fi
scriptdir=$(cd "$(dirname "$0")" && pwd)
[ -z "$scriptdir" ] && exit 2
export LIBDIR=$scriptdir/lib

. $LIBDIR/general.sh
. $LIBDIR/voidlinux.sh

#
# Special arguments...
#

while [ $# -gt 0 ] ; do
  if [ x"$1" = x"-s" ] ; then
    shift
    exec script -c "/bin/bash $0 $*" typescript.$(date +%F.%H.%M.%S)
  elif [ x"$1" = x"-x" ] ; then
    shift
    set -x
  else
    break
  fi
done

# Load required modules
for module in $(echo $MKMODULES | tr : ' ')
do
  . "$LIBDIR/$module.sh"
done

main() {
  if [ $# -eq 0 ] ; then
    echo "Usage: $0 [-s] [-x] <op> ...options..."
    echo "Available op's:"
    #declare -F | grep  '^declare -f op_' | sed 's/declare -f op_/	/'
    for op in $(declare -F | grep  '^declare -f op_' | sed 's/^declare -f op_//')
    do
      echo "- $op"
      if type hlp_$op >/dev/null 2>&1 ; then
	hlp_$op
      fi
    done
    exit
  fi
  cksubmodules
  op="$1" ; shift
  op_"$op" "$@"
}



main "$@"

