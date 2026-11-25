#!/bin/sh
# Builds bin/unit.swf with mxmlc.
# The SDK is taken from FLEX_HOME (default: ../tools/flexsdk460, see tools/env.sh
# and local.env.example). Adobe Flex SDK 4.6.0 build 23201 is the toolchain of the
# original unit.swf; Apache Flex 4.16 also works but gives different bytecode.
# Flex classes (mx.*) are linked from the SDK's framework.swc, as in the original.
# Usage: ./build.sh [output.swf]
set -e
cd "$(dirname "$0")"
. tools/env.sh
if [ ! -e "$FLEX_HOME/bin/mxmlc" ] && [ ! -e "$FLEX_HOME/lib/mxmlc.jar" ]; then
  echo "Flex SDK not found in $FLEX_HOME; set FLEX_HOME (see local.env.example)." >&2
  exit 1
fi
OUT="${1:-bin/unit.swf}"
mkdir -p "$(dirname "$OUT")"
set --
# Apache Flex 4.16 looks for playerglobal.swc through the {playerglobalHome} token
if grep -q playerglobalHome "$FLEX_HOME/frameworks/flex-config.xml"; then
  PLAYERGLOBAL_HOME="${PLAYERGLOBAL_HOME:-$FLEX_HOME/frameworks/libs/player}"
  if command -v cygpath >/dev/null 2>&1; then
    PLAYERGLOBAL_HOME="$(cygpath -m "$PLAYERGLOBAL_HOME")"
  fi
  export PLAYERGLOBAL_HOME
  set -- "+playerglobalHome=$PLAYERGLOBAL_HOME"
fi
"$FLEX_HOME/bin/mxmlc" "$@" \
  -source-path+=src \
  -target-player=11.1 \
  -swf-version=14 \
  -static-link-runtime-shared-libraries=true \
  -warnings=false \
  -output="$OUT" \
  src/unit.as
