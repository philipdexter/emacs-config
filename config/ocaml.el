(push "/usr/local/share/emacs/site-lisp" load-path)

(defun ocaml-find-hook()
  (let ((fn (buffer-file-name)))
    (when (or
	   (string-match "\\.ml$" fn)
	   (string-match "\\.mli$" fn))
      (progn
	(setq-default indent-tabs-mode nil)
	(autoload 'merlin-mode "merlin" "Merlin mode" t)
	(add-hook 'tuareg-mode-hook 'merlin-mode)
	(add-hook 'caml-mode-hook 'merlin-mode)
	(tuareg-mode)))))
(add-hook 'find-file-hooks 'ocaml-find-hook)
