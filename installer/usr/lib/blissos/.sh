#!/bin/bash

# Global exported functions, only be used within bash (shebang #!/bin/bash)
# Other shells like busybox sh, toybox sh or else may need implement of themselves

die() { echo "==> ERROR: $1" >&2 && quit "${2:-1}"; }

# Override this if needed
quit() { exit "$1"; }

checkfree() { "$INSLIB"/checkfree "$@"; }

decomsize() { "$INSLIB"/decomsize "$@"; }

extract() { "$INSLIB"/extract "$@"; }

export -f checkfree decomsize extract 
