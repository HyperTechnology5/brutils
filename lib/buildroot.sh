#!/bin/sh
#
# Buildroot related operations...
#
hlp_buildroot() {
  echo "  Invoke buildroot make operations"
  echo "  Usage: $MKSCRIPTNAME buildroot <make options>"
}
op_buildroot() {
  make -C "$mydir/buildroot" O="$mydir/br-output" BR2_EXTERNAL="$mydir" "$@"
}
hlp_br() {
  echo "  Alias for buildroot"
}
op_br() {
  op_buildroot "$@"
}

hlp_brcfg() {
  echo "  Configure buildroot environment"
  echo "  Usage: $MKSCRIPTNAME brcfg"
}
op_brcfg() {
  op_buildroot prj_defconfig
}


