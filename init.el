(require 'cl)

;; locally installed packages
(defvar packages
  '(haskell-mode
    ace-jump-mode
    smex
    color-theme
    color-theme-solarized
    prop-menu
    idris-mode
    markdown-mode
    tuareg
    dash
    s
    f
    let-alist
    undo-tree
    writegood-mode
    expand-region
    multiple-cursors))

;; local config files
(defvar configs
  '("global"
    "haskell"
    "latex"
    "smex"
    "color-theme"
    "markdown"
    "java"
    "idris"
    "coq"
    "twelf"
    "agda"
    "c"
    "ocaml"
    "magit"
    "org"
    "undo-tree"
    "writegood"
    "expand"
    "multiple-cursors"))

(loop for name in packages
      do (progn (unless (fboundp name)
                  (add-to-list 'load-path
                               (concat (file-name-directory (or load-file-name
                                                                (buffer-file-name)))
                                       "packages/"
                                       (symbol-name name)))
                  (require name))))

(add-to-list 'load-path
             (concat (file-name-directory load-file-name)
                     "packages/"))

(loop for name in configs
      do (load (concat (file-name-directory load-file-name)
                       "config/"
                       name ".el")))
