(add-to-list 'auto-mode-alist '("\\.v$" . coq-mode))

(define-key coq-mode-map (kbd "C-c RET") 'proof-goto-point)
