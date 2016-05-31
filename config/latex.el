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
          (lambda ()
	    (add-to-list 'load-path "~/.emacs.d/packages/auctex")
	    (load "auctex.el" nil t t)
	    (load "preview-latex.el" nil t t)
	    (LaTeX-mode)
	    (add-to-list 'load-path "~/.emacs.d/packages/auctex-latexmk")
	    (require 'latex-mode-expansions)
	    (require 'auctex-latexmk)
	    (auctex-latexmk-setup)
	    (setq auctex-latexmk-inherit-TeX-PDF-mode t)
	    (setq-default TeX-command-default "LatexMk")
	    (setq TeX-view-program-selection '((output-pdf "zathura")))
	    (setq TeX-view-program-list '(("zathura" ("zathura" " --fork" " %o"))))
	    (setq-default TeX-master "paper-sigplan")))
