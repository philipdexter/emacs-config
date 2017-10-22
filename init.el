(require 'cl-lib)

;; locally installed packages
(defvar packages
  '(ace-jump-mode
    smex
    color-theme
    color-theme-solarized
    dash
    s
    f
    let-alist
    undo-tree
    writegood-mode
    expand-region
    multiple-cursors
    ranger
    fzf))

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
    "mail"
    "org"
    "undo-tree"
    "writegood"
    "expand"
    "multiple-cursors"
    "eww"
    "erlang"
    "elixir"))

(cl-loop for name in packages
      do (progn (unless (fboundp name)
                  (add-to-list 'load-path
                               (concat (file-name-directory (or load-file-name
                                                                (buffer-file-name)))
                                       "packages/"
                                       (symbol-name name)))
                  (let ((ct (current-time)))
		    (cl-flet ((dt (time)
				  (+ (* (car (cdr time)) 1000000) (car (cdr (cdr time))))))
		      (require name)
		      (message "load time %22s %d" name (- (dt (current-time)) (dt ct))))))))

(add-to-list 'load-path
             (concat (file-name-directory load-file-name)
                     "packages/"))

(loop for name in configs
      do (load (concat (file-name-directory load-file-name)
                       "config/"
                       name ".el")))
(put 'narrow-to-region 'disabled nil)
