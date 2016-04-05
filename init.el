(require 'cl)

;; locally installed packages
(defvar packages
  '(haskell-mode
    cycle-buffer
    ace-jump-mode
    smex
    color-theme
    color-theme-solarized
    idris-mode
    markdown-mode
    rust-mode
    tuareg
    dash
    s
    f
    let-alist))

;; local config files
(defvar configs
  '("global"
    "haskell"
    "cycle-buffer"
    "latex"
    "smex"
    "color-theme"
    "markdown"
    "java"
    "idris"
    "coq"
    "agda"
    "c"
    "ocaml"
    "magit"))

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
