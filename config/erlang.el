(defvar my/erlang-loaded nil)

(defun my/load-erlang ()
  (add-to-list 'load-path
	       "/home/philip/projects/elixir/otp/lib/tools/emacs")
  (setq erlang-root-dir "/opt/erlang")
  (setq exec-path (cons "/opt/erlang/bin" exec-path))
  (require 'erlang-start)
  (erlang-mode)
  (setq indent-tabs-mode nil)
  (setq my/erlang-loaded t))

(defun my/erlang-find-hook ()
  (let ((fn (buffer-file-name)))
    (when (string-match "\\.erl" fn)
      (unless my/erlang-loaded (my/load-erlang)))))

(add-hook 'find-file-hooks 'my/erlang-find-hook)
