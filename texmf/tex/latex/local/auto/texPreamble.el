(TeX-add-style-hook
 "texPreamble"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("xy" "all") ("geometry" "lmargin=1.0in" "rmargin=1.0in" "tmargin=1.0in" "bmargin=1.0in") ("xcolor" "table") ("enumitem" "shortlabels" "inline") ("cancel" "makeroom") ("ulem" "normalem") ("wasysym" "nointegrals") ("algorithm2e" "linesnumbered" "lined" "ruled" "commentsnumbered") ("nth" "super")))
   (add-to-list 'LaTeX-verbatim-environments-local "VerbatimOut")
   (add-to-list 'LaTeX-verbatim-environments-local "SaveVerbatim")
   (add-to-list 'LaTeX-verbatim-environments-local "LVerbatim*")
   (add-to-list 'LaTeX-verbatim-environments-local "LVerbatim")
   (add-to-list 'LaTeX-verbatim-environments-local "BVerbatim*")
   (add-to-list 'LaTeX-verbatim-environments-local "BVerbatim")
   (add-to-list 'LaTeX-verbatim-environments-local "Verbatim*")
   (add-to-list 'LaTeX-verbatim-environments-local "Verbatim")
   (add-to-list 'LaTeX-verbatim-environments-local "lstlisting")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "href")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperref")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperimage")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperbaseurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "nolinkurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "lstinline")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "Verb*")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "Verb")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "lstinline")
   (TeX-run-style-hooks
    "texShortcutsWesterbaan"
    "xy"
    "array"
    "advdate"
    "graphicx"
    "geometry"
    "amsmath"
    "amssymb"
    "xfrac"
    "amsthm"
    "verbatim"
    "multirow"
    "pbox"
    "hhline"
    "multicol"
    "xcolor"
    "bm"
    "fp"
    "nicefrac"
    "mathtools"
    "standalone"
    "hyperref"
    "textcomp"
    "pdfpages"
    "pdflscape"
    "nameref"
    "lipsum"
    "enumitem"
    "cancel"
    "ulem"
    "tabularray"
    "tasks"
    "blindtext"
    "pgf"
    "tikz"
    "tabu"
    "wasysym"
    "xparse"
    "xspace"
    "bigstrut"
    "blkarray"
    "xifthen"
    "moreverb"
    "fancybox"
    "framed"
    "fancyvrb"
    "algorithm2e"
    "scalerel"
    "pgfplotstable"
    "pgfplots"
    "subcaption"
    "cleveref"
    "listings"
    "tabularx"
    "tabto"
    "harpoon"
    "nth"
    "wrapfig"
    "diagbox"
    "arydshln"
    "polynom"
    "etoolbox"
    "colorPalette")
   (TeX-add-symbols
    '("botstrut" ["argument"] 0)
    '("topstrut" ["argument"] 0)
    "texFolder"
    "verbatiminput")
   (LaTeX-add-xcolor-definecolors
    "lightgray"))
 :latex)

