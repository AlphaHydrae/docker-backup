#!/usr/bin/env sh

dockerfile_file=Dockerfile
dockerfile_header_file=templates/Dockerfile.header
dockerfile_footer_file=templates/Dockerfile.footer
template_file=Dockerfile.template
variants_dir=variants

cat "$dockerfile_header_file" "$dockerfile_footer_file" > "$dockerfile_file"
echo "base -> Dockerfile"

for variant in $(ls variants); do

  variant_file="$variants_dir/$variant"
  version_file="Dockerfile.$variant"
  extras="$(cat "$variant_file")"

  cat "$dockerfile_header_file" "$variant_file" "$dockerfile_footer_file" > "$version_file"

  echo "$variant_file -> $version_file"
done
