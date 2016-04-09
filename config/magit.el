(add-to-list 'load-path "~/.emacs.d/packages/magit/lisp")
(add-to-list 'load-path "~/.emacs.d/packages/with-editor")
(setq git-commit-fill-column nil)
(setq git-commit-summary-max-length 70)
(setq magit-auto-revert-mode nil)

(defun load-magit () (interactive) (require 'magit))
(define-key global-map (kbd "C-x C-a l") 'load-magit)
