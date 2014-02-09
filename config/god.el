;; start with god-mode on
(god-mode)

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

;; switch mode line color with god-mode
(defun c/god-mode-mode-line ()
  (let ((limited-colors-p (> 257 (length (defined-colors)))))
    (cond (god-local-mode (progn
			    (set-face-background 'mode-line (if limited-colors-p "color-209" "#d4552a"))
			    (set-face-background 'mode-line-inactive (if limited-colors-p "color-209" "#d4552a"))))
	  (t (progn
	       (set-face-background 'mode-line (if limited-colors-p "white" "#e9e2cb"))
	       (set-face-background 'mode-line-inactive (if limited-colors-p "white" "#e9e2cb")))))))

(add-hook 'god-mode-enabled-hook 'c/god-mode-mode-line)
(add-hook 'god-mode-disabled-hook 'c/god-mode-mode-line)
