(require 'tex-mode)

;; unset C-c C-s so we can use it in ace-jump
(define-key latex-mode-map (kbd "C-c C-s") nil)

;; fill paragraph using punctuation
(defun fill-using-punctuation ()
  (interactive)
  (save-excursion
    (progn (mark-paragraph)
	   (let ((begin (region-beginning))
		 (end (region-end)))
	     (replace-regexp "\\([.,?:;!]\\)\s+" "\\1
" nil begin end)))))
(define-key latex-mode-map (kbd "C-c q") 'fill-using-punctuation)
