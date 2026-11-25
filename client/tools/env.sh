# Build configuration; paths are relative to the client directory.
ROOT="$(cd "$(dirname "$0")" && pwd)"
[ -f "$ROOT/local.env" ] && . "$ROOT/local.env"
abspath() { case "$1" in /* | [A-Za-z]:*) echo "$1" ;; *) echo "$ROOT/$1" ;; esac; }
FLEX_HOME="$(abspath "${FLEX_HOME:-../tools/flexsdk460}")"
export ROOT FLEX_HOME
