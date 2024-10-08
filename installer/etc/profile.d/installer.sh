#!/bin/sh

set -- $(cat /proc/cmdline)
for arg in "$@"; do
	case "$arg" in
	*.*=*) eval "export $(echo "${arg%%=*}" | sed 's/\./__/g')='${arg#*=}'" ;;
	*=*) eval "export ${arg%%=*}='${arg#*=}'" ;;
	esac
done

# root folder
SRCDIR=/cdrom/$SRC
INSLIB=/usr/lib/blissos
INSDATA=/usr/share/blissos

BOOT_PART=/boot

# Log file
LOG=/var/log/blissos.log

# SquashFS compression
# Available compressor: gzip, lzo, lz4, xz, zstd or empty
# More info: mksquashfs --help
SFS_COMPRESSION=zstd
SFS_COMPRESSION_OPTS="-Xcompression-level 22 -b 1M -no-duplicates -no-recovery -always-use-fragments -no-xattrs"

# EroFS compression
# Available compressor: lz4hc, lzma, xz or empty
# format: X[,Y][:X[,Y]...], with X is compressor, Y is compression level
EFS_COMPRESSION="zstd"
EFS_COMPRESSION_OPTS=""
