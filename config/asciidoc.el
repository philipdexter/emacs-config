(add-to-list 'load-path "~/.emacs.d/packages/adoc-mode")
(add-to-list 'load-path "~/.emacs.d/packages/markup-faces")
(require 'adoc-mode)
(adoc-mode)

(global-set-key (kbd "C-c C-c") (lambda () (interactive) (compile "asciidoctor -r asciidoctor-diagram meeting.txt")))
