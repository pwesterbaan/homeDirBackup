#!/usr/bin/env bash

rm_old_student_work_scans() {
    teaching_dir="$DROPBOX_PATH/work/lander/teaching"
    years=1
    min_age=$((years * 365))

    mode="${1:-dry-run}"   # dry-run | delete

    find "$teaching_dir" -mindepth 4 -type d -path '*/scans/*' -print0 |
    while IFS= read -r -d '' scans_dir; do

        # list all file extensions:
        # find . -type f -path '*/scans/*' | sed 's/.*\.//' | sort -u

        # Skip if file is newer than min_age
        if find "$scans_dir" -type f \
                \( -name '*.pdf' -o \
                   -name '*.jpeg' -o \
                   -name '*.jpg' -o \
                   -name '*.png' \) \
                -mtime -"$min_age" -print -quit | grep -q .; then
            continue
        fi

        echo
        echo "Eligible scans directory:"
        echo "  $scans_dir"

        case "$mode" in
            dry-run) echo "  DRY-RUN: would remove $scans_dir" ;;
            delete)  echo "  DELETING: $scans_dir"; rm -rf -- "$scans_dir" ;;
            *)       echo "Unknown mode: $mode" >&2; return 1 ;;
        esac
    done
}
