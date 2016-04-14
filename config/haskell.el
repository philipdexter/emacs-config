(require 'haskell-mode-autoloads)
(define-key haskell-mode-map (kbd "C-c c") 'haskell-compile)
(define-key haskell-mode-map (kbd "C-c C-u") 'haskell-insert-undefined)
(define-key haskell-mode-map (kbd "C-c [") 'haskell-move-nested-left)
(define-key haskell-mode-map (kbd "C-c ]") 'haskell-move-nested-right)
(define-key haskell-mode-map (kbd "C-c C-m") 'haskell-auto-insert-module-template)

(define-key haskell-mode-map (kbd "C-c C-e") 'haskell-indent-insert-equal)
(define-key haskell-mode-map (kbd "C-c |") 'haskell-indent-insert-guard)
(define-key haskell-mode-map (kbd "C-c C-f") 'haskell-mode-format-imports)

(define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-file)
(setq haskell-process-type 'stack-ghci)
(setq haskell-compile-cabal-build-command "stack build")

(define-key haskell-mode-map (kbd "C-c `") 'haskell-interactive-bring)
(define-key haskell-mode-map (kbd "C-c C-t") 'haskell-process-do-type)
(define-key haskell-mode-map (kbd "C-c C-i") 'haskell-process-do-info)

(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)


(defun haskell-insert-undefined ()
  "Insert undefined."
  (interactive)
  (insert "undefined"))

(defun haskell-auto-insert-module-template ()
  "Insert a module template for the newly created buffer."
  (interactive)
  (when (buffer-file-name)
    (insert
     "-- | "
     "\n"
     "\n"
     "module " (haskell-guess-module-name) " where"
     "\n"
     "\n")
    (goto-char (point-min))
    (forward-char 5)))
