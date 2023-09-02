#!/bin/bash

versions=(
  "deno,latest,https://github.com/asdf-community/asdf-deno.git"
  "golang,latest,https://github.com/kennyp/asdf-golang.git"
  "nodejs,lts,https://github.com/asdf-vm/asdf-nodejs.git"
  "rust,latest,https://github.com/code-lever/asdf-rust.git"
)

for appObj in "${versions[@]}"; do
    IFS="," read -r -a arr <<< "${appObj}"

    app="${arr[0]}"
    version="${arr[1]}"
    repo="${arr[2]}"

    asdf plugin-add "$app" "$repo"
    asdf install "$app" "$version"
    asdf global "$app" "$version"
done
