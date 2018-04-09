(defun my/load-asciidoc ()
  (interactive)

  (add-to-list 'load-path "~/.emacs.d/packages/adoc-mode")
  (add-to-list 'load-path "~/.emacs.d/packages/markup-faces")
  (require 'adoc-mode)
  (adoc-mode)

  (set-face-attribute 'markup-list-face nil :background "yellow" :foreground "black")
  (set-face-attribute 'markup-meta-hide-face nil :background "black" :foreground "yellow")
  (set-face-attribute 'markup-typewriter-face nil :background "black" :foreground "bright red")
  (set-face-attribute 'markup-meta-face nil :background "black" :foreground "bright red")

  (global-set-key (kbd "C-c C-c") (lambda () (interactive) (compile "asciidoctor -r asciidoctor-diagram meeting.txt"))))
