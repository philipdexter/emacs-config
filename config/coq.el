(defvar coq-packages
  '(yasnippet
    dash
    company
    math-symbol-lists
    company-math
    company-coq))

(defun coq-find-hook()
  (let ((fn (buffer-file-name)))
    (when (string-match "\\.v$" fn)
      (load-file "/home/philip/.emacs.d/packages/ProofGeneral/generic/proof-site.el")
      (loop for name in coq-packages
	    do (progn (unless (fboundp name)
			(add-to-list 'load-path
				     (concat "~/.emacs.d/"
					     "packages/"
					     (symbol-name name)))
			(require name))))
      (coq-mode)
      (company-coq-mode)
      (setq company-coq-features/prettify-symbols-in-terminals t)
      (proof-electric-terminator-toggle)
      (define-key coq-mode-map (kbd "M-p") 'proof-goto-command-start)
      (define-key coq-mode-map (kbd "M-n") 'proof-goto-command-end)
      (define-key coq-mode-map (kbd "C-c RET") 'proof-goto-point)
      (define-key coq-mode-map (kbd "M-RET") 'proof-goto-point))))
(add-hook 'find-file-hooks 'coq-find-hook)

(custom-set-faces
 '(proof-locked-face ((t (:background "color-123" :underline nil)))))

; (add-to-list 'auto-mode-alist '("\\.v$" . coq-mode))
