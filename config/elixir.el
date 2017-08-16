(defvar my/elixir-loaded nil)

(defun my/load-elixir ()
  (add-to-list 'load-path (concat
			   (file-name-directory user-init-file)
			   "packages/"
			   "elixir-mode"))
  (require 'elixir-mode)
  (add-hook 'elixir-mode-hook (lambda ()
				(setq indent-tabs-mode nil)))
  (elixir-mode))

(defun my/elixir-find-hook ()
  (let ((fn (buffer-file-name)))
    (when (string-match "\\.ex" fn)
      (unless my/elixir-loaded (my/load-elixir)))))

(add-hook 'find-file-hooks 'my/elixir-find-hook)
