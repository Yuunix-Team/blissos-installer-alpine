#!/bin/bash

mkdir -p build
DISTRO=$1

declare -A DIST_EXCLUDE=(["alpine"]="etc/apk" ["arch"]="usr/share/libalpm" ["void"]="" ["debian"]="")

EXCLUDES=""
for dist in "${!DIST_EXCLUDE[@]}"; do
	{ [ ! "${DIST_EXCLUDE["$dist"]}" ] || [ "$dist" = "$DISTRO" ]; } && continue
	EXCLUDES="$EXCLUDES|${DIST_EXCLUDE["$dist"]}"
done
EXCLUDES=${EXCLUDES#|}

FILELIST=$(find installer -mindepth 1 -type f | grep -Ev "$EXCLUDES")
LINKLIST=$(find installer -mindepth 1 -type l | grep -Ev "$EXCLUDES")

while read -r file; do
	header=$(head -1 "$file")
	target=build/${file#installer}

	target_dir=${target%/*}
	[ -d "$target_dir" ] || mkdir -p "$target_dir"

	case "$header" in
	\#\!/*)
		[ "${DEBUG#0}" ] &&
			cp -a "$file" "$target" ||
			shfmt -mn "$file" >"$target" ||
			shfmt -mn -ln=mksh "$file" >"$target"
		chmod +x "$target"
		;;
	*) cp "$file" "$target" ;;
	esac

done <<<"$FILELIST"

while read -r file; do
	target=build/${file#installer}

	target_dir=${target%/*}
	[ -d "$target_dir" ] || mkdir -p "$target_dir"

	cp -a "$(readlink -f "$file")" "$target"
done <<<"$LINKLIST"
