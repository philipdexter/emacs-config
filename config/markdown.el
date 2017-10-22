(defvar my/markdown-loaded nil)

(defun my/load-markdown ()
  (add-to-list 'load-path (concat
			   (file-name-directory user-init-file)
			   "packages/"
			   "markdown-mode"))
  (require 'markdown-mode)
  (markdown-mode))

(defun my/markdown-find-hook ()
  (let ((fn (buffer-file-name)))
    (when (string-match "\\.md" mfn)
      (unless my/markdown-loaded (my/load-markdown)))))

(add-hook 'find-file-hooks 'my/markdown-find-hook)

; todo check out auto-mode-alist , maybe that can run functions too
;; (autoload 'markdown-mode "markdown-mode"
;;   "Major mode for editing Makrdown files" t)
;; (add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
;; (add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
