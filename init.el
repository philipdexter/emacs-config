(require 'cl-lib)

;; locally installed packages
(defvar packages
  '(smex
    dash
    s
    f
    let-alist
    undo-tree
    writegood-mode
    multiple-cursors
    fzf
    browse-kill-ring))

;; local config files
(defvar configs
  '("global"
    "haskell"
    "latex"
    "smex"
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
    "multiple-cursors"
    "eww"
    "erlang"
    "asciidoc"
    "elixir"
    "factor"))

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

(defun new-scratch-buffer ()
  (interactive)
  (let ((buf (generate-new-buffer "my.scratch")))
    (switch-to-buffer buf)
    (setq buffer-offer-save t)
    (lisp-interaction-mode)))
(setq initial-scratch-message "(new-scratch-buffer)\n")
