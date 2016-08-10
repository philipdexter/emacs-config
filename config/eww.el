(setq eww-download-directory "~/eww-downloads")
(add-hook 'eww-mode-hook
	  (lambda () (setq show-trailing-whitespace nil)))
