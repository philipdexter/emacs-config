(defvar my/factor-loaded nil)

(defun my/load-factor ()
  (add-to-list 'load-path "~/projects/factor/misc/fuel")
  (require 'factor-mode)
  (setq fuel-listener-factor-binary "~/projects/factor/factor")
  (setq fuel-listener-factor-image "~/projects/factor/factor.image")

  (setq my/factor-loaded t))

(defun my/factor-find-hook ()
  (let ((fn (buffer-file-name)))
    (when (string-match "\\.factor" fn)
      (unless my/factor-loaded (my/load-factor)))))

(add-hook 'find-file-hooks 'my/factor-find-hook)
