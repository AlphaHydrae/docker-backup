#!/usr/bin/env sh
set -e

dump_all=
dump_dir=/var/run/container/environment
dump_strict=

while test $# -gt 0; do
  arg="$1"
  case "$arg" in
    -a|--all)
      dump_all=1
      shift
      ;;
    -o|--out)
      dump_dir="$2"
      shift
      shift
      ;;
    -s|--strict)
      dump_strict=1
      shift
      ;;
    --)
      shift
      break
      ;;
    *)
      break;
      ;;
  esac
done

if test -n "$dump_all"; then
  variables_to_dump="$(printenv|grep -E '^[A-Z_]'|sed 's/=.*//')"
else
  variables_to_dump="$@"
fi

if ! mkdir -p "$dump_dir"; then
  >&2 echo "Could not create $dump_dir directory"
  exit 1
fi

if ! chmod 700 "$dump_dir"; then
  >&2 echo "Could not change $dump_dir permissions"
  exit 1
fi

for variable_to_dump in $variables_to_dump; do
  echo "Dumping \$$variable_to_dump to $dump_dir..."
  if ! (umask 0277 && printenv "$variable_to_dump" > "$dump_dir/$variable_to_dump"); then
    >&2 echo "Warning: variable $variable_to_dump is not set"
    if test -n "$dump_strict"; then
      exit 1
    fi
  fi
done
