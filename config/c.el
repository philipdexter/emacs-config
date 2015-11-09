(add-hook 'c-mode-hook
	  (lambda ()
	    (c-set-style "linux")
	    (setq indent-tabs-mode t)))
