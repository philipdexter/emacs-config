
(defun ocaml-find-hook()
  (let ((fn (buffer-file-name)))
    (when (or
	   (string-match "\\.ml$" fn)
	   (string-match "\\.mli$" fn))
      (progn
	(setq-default indent-tabs-mode nil)
	(tuareg-mode)))))
(add-hook 'find-file-hooks 'ocaml-find-hook)
