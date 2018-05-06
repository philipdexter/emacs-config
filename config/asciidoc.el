(defvar my/asciidoc-loaded nil)

(defun my/load-asciidoc ()
  (interactive)

  (add-to-list 'load-path "~/.emacs.d/packages/adoc-mode")
  (add-to-list 'load-path "~/.emacs.d/packages/markup-faces")
  (require 'adoc-mode)
  (adoc-mode)

  ; (setq my/asciidoc-loaded t)

  ;; (set-face-attribute 'markup-list-face nil :background "yellow" :foreground "black")
  ;; (set-face-attribute 'markup-meta-hide-face nil :background "black" :foreground "yellow")
  ;; (set-face-attribute 'markup-typewriter-face nil :background "black" :foreground "bright red")
  ;; (set-face-attribute 'markup-meta-face nil :background "black" :foreground "bright red")

  (global-set-key (kbd "C-c C-c") (lambda () (interactive) (compile (concat "asciidoctor -r asciidoctor-diagram " (buffer-name))))))

(defun my/asciidoc-find-hook ()
  (let ((fn (buffer-file-name)))
    (when (string-match "\\.txt" fn)
      (unless my/asciidoc-loaded (my/load-asciidoc)))))

(add-hook 'find-file-hooks 'my/asciidoc-find-hook)
