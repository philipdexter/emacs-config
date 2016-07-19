(defvar my/ocaml-loaded nil)

(defun my/load-ocaml ()
    (add-to-list 'load-path (concat
			   (file-name-directory user-init-file)
			   "packages/"
			   "tuareg"))
    (require 'tuareg)


    (setq opam-share
	  (substring
	   (shell-command-to-string "opam config var share 2> /dev/null") 0 -1))
    (push (concat opam-share "/emacs/site-lisp") load-path)

    (set-face-attribute 'tuareg-font-lock-operator-face nil :foreground "#5f5faf")

    (setq my/ocaml-loaded t))

(defun ocaml-find-hook()
  (let ((fn (buffer-file-name)))
    (when (or
	   (string-match "\\.ml$" fn)
	   (string-match "\\.mli$" fn))
      (progn
	(unless my/ocaml-loaded (my/load-ocaml))
	(setq-default indent-tabs-mode nil)
	(setq merlin-command 'opam)
	(add-to-list 'load-path "~/.emacs.d/packages/company")
	(require 'company)
	(autoload 'merlin-mode "merlin" "Merlin mode" t)
	(add-hook 'tuareg-mode-hook 'merlin-mode)
	(add-hook 'caml-mode-hook 'merlin-mode)
	(require 'ocp-indent)
	(tuareg-mode)
	(company-mode)))))

(add-hook 'find-file-hooks 'ocaml-find-hook)
