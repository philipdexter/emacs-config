(defvar my/idris-loaded nil)

(defun my/load-idris ()
  (add-to-list 'load-path (concat
			   (file-name-directory user-init-file)
			   "packages/"
			   "idris-mode"))
  (add-to-list 'load-path (concat
			   (file-name-directory user-init-file)
			   "packages/"
			   "prop-menu"))
  (require 'idris-mode)

  (idris-mode)

  (setq idris-interpreter-flags '("-i" "/home/philip/projects/idris/libs/prelude" "-i" "/home/philip/projects/idris/libs/base"))

  (setq my/idris-loaded t))

(defun my/idris-find-hook ()
  (let ((fn (buffer-file-name)))
    (when (string-match "\\.idr" fn)
      (unless my/idris-loaded (my/load-idris)))))

(add-hook 'find-file-hooks 'my/idris-find-hook)
