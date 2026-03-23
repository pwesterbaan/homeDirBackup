#!/usr/bin/env bash

#TODO: trap for cleanup
# https://www.reddit.com/r/bash/comments/1rlrlom/stop_leaving_temp_files_behind_when_your_scripts/

# auto complete filenames for cpKey
complete -f -o plusdirs -X '!*.tex' cpKey

cpKey() {
  # sourced in .bash_aliases
  # Function to compile blank and key versions of *_KEY.tex,
  # optionally for multiple VERSIONs (A, B, C, D...) where we
  # inject \def\version{VERSION} and name outputs base_VX.pdf and base_VX_KEY.pdf

  local old_dir=$OLDPWD
  local current_dir
  current_dir="$(pwd)"

  # --- Parse args: -V/--versions "A B C" (or comma-separated), plus optional file list ---
  local -a versions=()
  local -a files=()
  while [[ $# -gt 0 ]]; do
    case "$1" in
      -V|--version|--versions)
        shift
        if [[ $# -eq 0 ]]; then
          echo "Error: -V/--versions requires an argument (e.g., 'A', 'A B C', or 'A,B,C')."
          return 2
        fi
        IFS=', ' read -r -a _vers <<< "$1"
        versions+=("${_vers[@]}")
        ;;
      -h|--help)
        cat <<'EOF'
Usage:
  cpKey [ -V "A B C D" ] [file1_KEY.tex file2_KEY.tex ... ]
  cpKey [ -V A -V B -V C -V D ] [files...]
  cpKey [files...]
  cpKey   # no args: uses *_KEY*.tex in current dir

Behavior:
  - With -V:    compiles both blank and key for each version; injects \def\version{X}
  - Without -V: no \def\version

Outputs with -V A:
  - Blank:  <base>_VA.pdf
  - Key:    <base>_VA_KEY.pdf

Outputs (no -V):
  - Blank:  <base>.pdf
  - Key:    <base>_KEY.pdf
EOF
        return 0
        ;;
      d) set -x ;; # ENABLE DEBUG STATEMENTS
      --) shift; break;;
      -*)
        echo "Unknown option: $1"
        return 2
        ;;
      *)
        files+=("$1")
        ;;
    esac
    shift
  done

  # Any leftover args are files too
  while [[ $# -gt 0 ]]; do files+=("$1"); shift; done

  # Default versions => single empty sentinel means "no versioning"
  if [[ ${#versions[@]} -eq 0 ]]; then
    versions=("")
  fi

  # Determine the pattern (files to process)
  local -a pattern=()
  if [[ ${#files[@]} -eq 0 ]]; then
    pattern=(*_KEY*.tex)
  else
    pattern=("${files[@]}")
  fi

  # Verify we have matches
  shopt -s nullglob
  if [[ ${#pattern[@]} -eq 0 ]]; then
    echo "No files match *_KEY*.tex pattern (and none provided)."
    return 1
  fi

  # Process each file (subshell per file to isolate cd)
  for f in "${pattern[@]}"; do
    (
      cd "$(dirname -- "$f")" || exit 1
      f="$(basename -- "$f")"
      ls "$f"

      cleanTex "$f" >/dev/null

      # Base name without extension and without _KEY suffix
      local base="${f%.*}"
      base="${base/_KEY/}"

      for ver in "${versions[@]}"; do
        local defver=""
        local jobname_blank=""
        local jobname_key=""
        local label=""

        if [[ -n "$ver" ]]; then
          # New naming: base_VA.pdf and base_VA_KEY.pdf
          jobname_blank="${base}_V${ver}"
          jobname_key="${base}_V${ver}_KEY"
          defver="\\def\\version{${ver}} "
          label=" (${ver})"
        else
          # Legacy naming when no version is provided
          jobname_blank="${base}"
          jobname_key="${base}_KEY"
        fi

        echo "**************"
        echo "Compile blank${label}: $f"

	# BLANK build (no injected answers/noanswers; source handles default)
	BLANK_TEX="${defver}\\PassOptionsToClass{noanswers}{exam}\\input{%S}"
	JOBOPTS="pdflatex %O -interaction=nonstopmode -synctex=1 \"${BLANK_TEX}\""
	# JOBOPTS="pdflatex %O \"${BLANK_TEX}\""
	latexmk -pdf -silent -g -jobname="$jobname_blank" -pdflatex="$JOBOPTS" "$f" >/dev/null

        echo "Compile key${label}: $f"
	# KEY build (inject answers)
	KEY_TEX="${defver}\\PassOptionsToClass{answers}{exam}\\input{%S}"
	JOBOPTS="pdflatex %O -interaction=nonstopmode -synctex=1 \"${KEY_TEX}\""
	latexmk -pdf -silent -g -jobname="$jobname_key" -pdflatex="$JOBOPTS" "$f" >/dev/null

        echo "**************"
        echo
      done
    )
  done


local choice
  while :; do
    echo -n "[y]es clean and open, [n]o clean, [c]lean only [default: c]: "
    read -r choice
    # lower-case normalize
    choice="${choice,,}"
    if [[ -z "$choice" || "$choice" == "y" || "$choice" == "n" || "$choice" == "c" ]]; then
      break
    fi
    echo "Please enter n, y, or c."
  done

  # Default to 'c' if empty
  if [[ -z "$choice" ]]; then choice="c"; fi

  # Execute based on choice
  case "$choice" in
    n)
      # [n]o clean, don't open pdfs
      :
      ;;
    y)
      # [y]es clean and open
      cleanTex
      # Open generated PDFs
      for f in "${pattern[@]}"; do
        local dir base
        dir="$(dirname -- "$f")"
        base="$(basename -s .tex "${f/_KEY/}")"
        for ver in "${versions[@]}"; do
          if [[ -n "$ver" ]]; then
            exo-open "$dir/${base}_V${ver}.pdf"        2>/dev/null
            exo-open "$dir/${base}_V${ver}_KEY.pdf"    2>/dev/null
          else
            exo-open "$dir/${base}.pdf"                2>/dev/null
            exo-open "$dir/${base}_KEY.pdf"            2>/dev/null
          fi
        done
      done
      ;;
    c)
      # [c]lean only; don't open
      cleanTex
      ;;
  esac

  cd "$current_dir" || true
  OLDPWD="$old_dir"
}
