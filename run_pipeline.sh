#!/bin/bash

set -u

script_dir="$(dirname "$0")"
data_file="$script_dir/data.json"
log_file="$script_dir/log_file.txt"
err_file="$script_dir/script_error.log"

log() {
    echo "$(date '+%Y/%m/%d %H:%M:%S') $1" >> "$log_file"
}

cleanup() {
    rm -f "$data_file"
}

trap cleanup EXIT

curl -fL "https://api.restcountries.com/countries/v5/name?q=canada&pretty=1" \
  -H "Authorization: Bearer rc_live_demo" \
  -o "$data_file"

code1=$?

if [[ "$code1" -eq 0 ]]; then
    log "Download successful."
else
    log "Download failed."
    exit 1
fi

source "$script_dir/venv/bin/activate"

python_output=$(python "$script_dir/process_country.py" 2>"$err_file")

code2=$?

if [[ $code2 -eq 0 ]]; then
    log "Script ran successfully. Records processed: $python_output."
else
    log "Script failed to run. See "$err_file" for detailed logs."
    exit 1
fi
