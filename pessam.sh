#!/bin/sh
printf '\033c\033]0;%s\a' pessam
base_path="$(dirname "$(realpath "$0")")"
"$base_path/pessam.x86_64" "$@"
