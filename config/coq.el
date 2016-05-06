(defvar my/coq-loaded nil)

(defun my/load-coq ()
  (let ((coq-packages '(yasnippet
			dash
			company
			math-symbol-lists
			company-math
			company-coq)))
    (load-file "/home/philip/.emacs.d/packages/ProofGeneral/generic/proof-site.el")
    (loop for name in coq-packages
	  do (unless (fboundp name)
	       (add-to-list 'load-path
			    (concat
			     "~/.emacs.d/"
			     "packages/"
			     (symbol-name name)))
	       (require name)))
    (setq overlay-arrow-string "")
    (coq-mode)
    (company-coq-mode)
    (put 'company-coq-fold 'disabled nil)
    (setq company-coq-features/prettify-symbols-in-terminals t)
    (set-face-attribute 'proof-locked-face nil :background "#1c1c1c" :underline nil)
    (proof-electric-terminator-enable 1)
    (setq coq-prog-args '("-emacs-U" "-R" "/home/philip/coq/cpdt/src" "Cpdt"))
    (define-key coq-mode-map (kbd "C-c C-s") nil)
    (define-key coq-mode-map (kbd "C-c C-_") 'company-coq-fold)
    (define-key coq-mode-map (kbd "M-p") 'proof-undo-last-successful-command)
    (define-key coq-mode-map (kbd "M-n") 'my/proof-goto-next)
    (define-key proof-mode-map (kbd "M-p") 'proof-undo-last-successful-command)
    (define-key proof-mode-map (kbd "M-n") 'my/proof-goto-next)
    (define-key coq-mode-map (kbd "C-c C-a d") 'company-coq-toggle-definition-overlay)
    (define-key coq-mode-map (kbd "M-RET") 'proof-goto-point)
    (setq my/coq-loaded t)))

(defun my/proof-goto-next ()
  (interactive)
  (proof-goto-end-of-locked)
  (proof-goto-command-end)
  (proof-goto-command-end)
  (company-coq-proof-goto-point))

(defun my/coq-find-hook()
  (let ((fn (buffer-file-name)))
    (when (string-match "\\.v$" fn)
      (unless my/coq-loaded (my/load-coq)))))

(add-hook 'find-file-hooks 'my/coq-find-hook)
