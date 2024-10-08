#!/bin/bash

mkdir -p build

FILELIST=$(find installer -mindepth 1 -type f)
LINKLIST=$(find installer -mindepth 1 -type l)

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
