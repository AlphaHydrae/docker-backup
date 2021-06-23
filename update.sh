#!/usr/bin/env sh

dockerfile_file=Dockerfile
dockerfile_header_file=templates/Dockerfile.header
dockerfile_footer_file=templates/Dockerfile.footer
template_file=Dockerfile.template
variants_dir=variants

for ruby_docker_image_tag in $(ls variants); do
  for variant in $(ls variants/$ruby_docker_image_tag); do
    variant_file="$variants_dir/$ruby_docker_image_tag/$variant"

    if [[ "$variant" == "base" ]]; then
      version_file="Dockerfile"
    else
      version_file="Dockerfile.$variant"
    fi

    printf "FROM ruby:${ruby_docker_image_tag}\n\n" > "$version_file"
    cat "$dockerfile_header_file" "$variant_file" "$dockerfile_footer_file" >> "$version_file"
    echo "$variant_file -> $version_file"
  done
done
