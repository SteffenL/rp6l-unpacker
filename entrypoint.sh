#!/usr/bin/env bash

input_file=${1}
output_dir=${2}
output_subdir="${output_dir}/$(basename "${input_file}")"
script_dir=$(dirname "$(realpath "${BASH_SOURCE[0]}")")

mkdir --parents "${output_subdir}" || exit 1
"${script_dir}/rp6l" "${input_file}" "${output_subdir}" || exit $?
