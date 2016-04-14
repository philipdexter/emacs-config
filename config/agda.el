(defvar my/agda-loaded nil)

(defun my/load-agda ()
  (setq agda2-program-args '("--include-path=/home/philip/projects/agda/std-lib/src" "--include-path=."))
  (load-file (let ((coding-system-for-read 'utf-8))
	       (shell-command-to-string "agda-mode locate")))
  (setq my/agda-loaded t))

(defun my/agda-find-hook()
  (let ((fn (buffer-file-name)))
    (when (string-match "\\.agda$" fn)
      (unless my/agda-loaded (my/load-agda))
      (agda2-mode))))

(add-hook 'find-file-hooks 'my/agda-find-hook)
