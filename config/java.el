(add-hook 'java-mode-hook (lambda ()
			    (setq c-basic-offset 4
				  tab-width 4
				  indent-tabs-mode nil)))

(defun ant-at-git ()
  (interactive)
  (let ((old-dir default-directory))
    (cd (locate-dominating-file "." ".git"))
    (compile "ant build")
    (cd old-dir)))
