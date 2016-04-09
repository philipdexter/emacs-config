(defun twelf-find-hook ()
  (let ((fn (buffer-file-name)))
    (when (string-match "\\.elf$" fn)
      (progn (setq twelf-root "/home/philip/twelf/twelf/")
	     (load (concat twelf-root "emacs/twelf-init.el"))
	     (twelf-mode)))))


(add-hook 'find-file-hooks 'twelf-find-hook)
