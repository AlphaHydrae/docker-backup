#!/usr/bin/env bash
set -e

dump_dir=/var/run/container/environment

while test $# -gt 0; do
  arg="$1"
  case "$arg" in
    -d|--dir)
      dump_dir="$2"
      shift
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

for variable_to_load in $(ls -1 "$dump_dir"); do
  printf -v $variable_to_load "$(cat "$dump_dir/$variable_to_load")"
  export $variable_to_load
done

exec "$@"
