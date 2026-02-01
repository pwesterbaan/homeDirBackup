#!/usr/bin/env bash

cleanTex(){
  # sourced in .bash_aliases
  # locates *.tex files in current dir and sub dirs,
  # either based on filenames passed, or wildcard (default)
  # then removes temp files with the following exts,
  # including versioned variants like _VA / _VA_KEY.

  if [ $# -eq 0 ]; then
    clean_pattern="*.tex"
  else
    clean_pattern="$@"
  fi

  # Common LaTeX/latexmk aux files; extend as needed
  exts=(
    "-blx.bib" "-eps-converted-to" "-eps-converted-to.pdf"
    ".aux" ".bbl" ".bcf" ".blg" ".dvi" ".fdb_latexmk" ".fls"
    ".fuse_hidden*" ".goutputstream" ".lof" ".log" ".lot"
    ".nav" ".out" ".run.xml" ".snm" ".synctex.gz" ".synctex(busy)"
    ".ps"
  )

  shopt -s nullglob

  # Find source .tex files and clean products derived from them
  find -L . -name "$clean_pattern" | while IFS= read -r fname; do
    # Full path minus .tex (e.g., ./dir/my_exam_KEY)
    base_noext="${fname%.tex}"
    # Full path with _KEY stripped (e.g., ./dir/my_exam)
    base_nokey="${base_noext%_KEY}"

    # 1) Remove aux/temp files for: source (_KEY) and blank (no _KEY)
    for ext in "${exts[@]}"; do
      # From the source file name (my_exam_KEY + ext)
      for tmp in "${base_noext}${ext}"; do
        [ -e "$tmp" ] && rm -v -- "$tmp"
      done
      # From the blank base (my_exam + ext)
      for tmp in "${base_nokey}${ext}"; do
        [ -e "$tmp" ] && rm -v -- "$tmp"
      done

      # 2) Remove aux/temp files for versioned outputs (_V? and _V?_KEY)
      # Example: my_exam_VA.aux, my_exam_VA_KEY.aux, etc.
      for tmp in ${base_nokey}_V?${ext}; do
        [ -e "$tmp" ] && rm -v -- "$tmp"
      done
      for tmp in ${base_nokey}_V?_KEY${ext}; do
        [ -e "$tmp" ] && rm -v -- "$tmp"
      done
    done
  done

  shopt -u nullglob
}
