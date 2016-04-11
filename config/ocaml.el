(push "~/.opam/4.02.3/share/emacs/site-lisp" load-path)

(defun ocaml-find-hook()
  (let ((fn (buffer-file-name)))
    (when (or
	   (string-match "\\.ml$" fn)
	   (string-match "\\.mli$" fn))
      (progn
	(setq-default indent-tabs-mode nil)
	(add-to-list 'load-path "~/.emacs.d/packages/company")
	(require 'company)
	(autoload 'merlin-mode "merlin" "Merlin mode" t)
	(add-hook 'tuareg-mode-hook 'merlin-mode)
	(add-hook 'caml-mode-hook 'merlin-mode)
	(tuareg-mode)
	(company-mode)))))
(add-hook 'find-file-hooks 'ocaml-find-hook)

(set-face-attribute 'tuareg-font-lock-operator-face nil :foreground "#5f5faf")
