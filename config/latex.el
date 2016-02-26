(require 'tex-mode)

;; fill paragraph using punctuation
(defun fill-using-punctuation ()
  (interactive)
  (save-excursion
    (progn (mark-paragraph)
	   (let ((begin (region-beginning))
		 (end (region-end)))
	     (replace-regexp "\\([.,?:;!]\\)\s+" "\\1
" nil begin end)))))
(define-key tex-mode-map (kbd "C-c q") 'fill-using-punctuation)

(add-hook 'tex-mode-hook
	  (lambda () (progn (add-to-list 'load-path "~/.emacs.d/packages/auctex")
			    (load "auctex.el" nil t t)
			    (load "preview-latex.el" nil t t)
			    (LaTeX-mode))))
