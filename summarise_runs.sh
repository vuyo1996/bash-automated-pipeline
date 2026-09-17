#!/bin/bash

set -uo pipefail

script_dir="$(dirname "$0")"
log_file="$script_dir/log_file.txt"

cutoff="$(date -d '7 days ago' +%s)"

successes=0
failures=0

while IFS= read -r line; do
    log_date="$(echo "$line" | cut -d ' ' -f1)"
    log_time="$(echo "$line" | cut -d ' ' -f2)"
    log_timestamp="$(date -d "$log_date $log_time" +%s)"

    if [[ "$log_timestamp" -ge "$cutoff" ]]; then
        if [[ "$line" == *"successfully"* ]]; then
            (( successes++ ))
        elif [[ "$line" == *"failed"* ]]; then
            (( failures++ ))
        fi
    fi
done < "$log_file"

echo "There were ${successes} successful runs."
echo "There were ${failures} failed runs."
