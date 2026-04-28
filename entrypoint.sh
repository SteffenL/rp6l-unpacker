#!/usr/bin/env bash

input_dir=/tmp/rp6l/in
input_file_name=${1}
input_file=${input_dir}/${input_file_name}
output_dir=/tmp/rp6l/out
output_subdir="${output_dir}/$(basename "${input_file}")"
script_dir=$(dirname "$(realpath "${BASH_SOURCE[0]}")")

mkdir --parents "${output_subdir}" || exit 1
"${script_dir}/rp6l" "${input_file}" "${output_subdir}" || exit $?
