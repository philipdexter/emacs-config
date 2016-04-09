(defvar coq-packages
  '(yasnippet
    dash
    company
    math-symbol-lists
    company-math
    company-coq))

(defun proof-goto-next ()
  (interactive)
  (progn (proof-goto-end-of-locked)
         (proof-goto-command-end)
         (proof-goto-command-end)
         (company-coq-proof-goto-point)))

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
      (setq overlay-arrow-string "")
      (company-coq-mode)
      (put #'company-coq-fold 'disabled nil)
      (setq company-coq-features/prettify-symbols-in-terminals t)
      (proof-electric-terminator-enable 1)
      (define-key coq-mode-map (kbd "C-c ,") 'company-coq-occur)
      (define-key coq-mode-map (kbd "C-c C-s") nil)
      (define-key coq-mode-map (kbd "C-c C-_") 'company-coq-fold)
      (define-key coq-mode-map (kbd "M-p") 'proof-undo-last-successful-command)
      (define-key coq-mode-map (kbd "M-n") 'proof-goto-next)
      (define-key proof-mode-map (kbd "M-p") 'proof-undo-last-successful-command)
      (define-key proof-mode-map (kbd "M-n") 'proof-goto-next)
      (define-key coq-mode-map (kbd "C-c RET") 'proof-goto-point)
      (define-key coq-mode-map (kbd "C-c C-a d") 'company-coq-toggle-definition-overlay)
      (define-key coq-mode-map (kbd "M-RET") 'proof-goto-point))))
(add-hook 'find-file-hooks 'coq-find-hook)

(custom-set-variables
  '(coq-prog-args '("-R" "/home/philip/coq/cpdt/src" "Cpdt")))

(custom-set-faces
 '(proof-locked-face ((t (:background "color-123" :underline nil)))))
