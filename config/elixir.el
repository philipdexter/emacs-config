(defvar my/elixir-loaded nil)

(defun my/load-elixir ()
  (add-to-list 'load-path (concat
			   (file-name-directory user-init-file)
			   "packages/"
			   "elixir-mode"))
  (require 'elixir-mode)
  (add-hook 'elixir-mode-hook (lambda ()
				(setq indent-tabs-mode nil)))
  (set-face-attribute 'elixir-atom-face nil :foreground "brightmagenta")
  (set-face-attribute 'font-lock-type-face nil :foreground "cyan")
  (defun my/elixir-end ()
    (interactive)
    (insert "end")
    (indent-for-tab-command))
  (define-key elixir-mode-map (kbd "C-c ]") 'my/elixir-end)
  (elixir-mode))

(defun my/elixir-find-hook ()
  (let ((fn (buffer-file-name)))
    (when (string-match "\\.ex" fn)
      (unless my/elixir-loaded (my/load-elixir)))))

(add-hook 'find-file-hooks 'my/elixir-find-hook)
