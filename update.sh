#!/usr/bin/env sh

template_file=Dockerfile.template
variants_dir=variants
versions_dir=versions

cat Dockerfile.header Dockerfile.footer > Dockerfile
echo "base -> Dockerfile"

for variant in $(ls variants); do

  variant_file="$variants_dir/$variant"
  version_file="$versions_dir/Dockerfile.$variant"
  extras="$(cat "$variant_file")"

  cat Dockerfile.header "$variant_file" Dockerfile.footer > "$version_file"

  echo "$variant_file -> $version_file"
done
