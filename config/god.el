;; uncomment to start with god-mode on
;; (god-mode)

;; C-\ to toggle
(global-set-key (kbd "C-\\") 'god-local-mode)

;; easier keys in god-mode
(global-set-key (kbd "C-x C-1") 'delete-other-windows)
(global-set-key (kbd "C-x C-2") 'split-window-below)
(global-set-key (kbd "C-x C-3") 'split-window-right)
(global-set-key (kbd "C-x C-0") 'delete-window)

(define-key god-local-mode-map (kbd ".") 'repeat)

;; disable for modes
(add-to-list 'god-exempt-major-modes 'haskell-interactive-mode)
(add-to-list 'god-exempt-major-modes 'idris-repl-mode)
(add-to-list 'god-exempt-major-modes 'idris-metavariable-list-mode)
