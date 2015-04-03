(defun coq-find-hook()
  (let ((fn (buffer-file-name)))
    (when (string-match "\\.v$" fn)
      (load-file "/home/philip/.emacs.d/packages/ProofGeneral/generic/proof-site.el")
      (coq-mode)
      (define-key coq-mode-map (kbd "C-c RET") 'proof-goto-point))))
(add-hook 'find-file-hooks 'coq-find-hook)

; (add-to-list 'auto-mode-alist '("\\.v$" . coq-mode))
