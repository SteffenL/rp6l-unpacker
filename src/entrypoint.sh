#!/usr/bin/env bash

input_file=${1}
output_dir=${2}
output_subdir="${output_dir}/$(basename "${input_file}")"

mkdir --parents "${output_subdir}" || exit 1
lua /rp6l/rp6l "${input_file}" "${output_subdir}" || exit $?
