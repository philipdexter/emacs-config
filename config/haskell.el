(require 'haskell-mode-autoloads)
(require 'haskell-indentation)

;; functions

(defun haskell-insert-doc ()
  "Insert the documentation syntax."
  (interactive)
  (insert "-- | "))

(defun haskell-insert-undefined ()
  "Insert undefined."
  (interactive)
  (if (and (boundp 'structured-haskell-mode)
           structured-haskell-mode)
      (shm-insert-string "undefined")
    (insert "undefined")))

(defun haskell-who-calls (&optional prompt)
  "Grep the codebase to see who uses the symbol at point."
  (interactive "P")
  (let ((sym (if prompt
                 (read-from-minibuffer "Look for: ")
               (haskell-ident-at-point))))
    (let ((existing (get-buffer "*who-calls*")))
      (when existing
        (kill-buffer existing)))
    (let ((buffer
           (grep-find (format "cd %s && find . -name '*.hs' -exec grep -inH -e %s {} +"
                              (haskell-session-current-dir (haskell-session))
                              sym))))
      (with-current-buffer buffer
        (rename-buffer "*who-calls*")
        (switch-to-buffer-other-window buffer)))))

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

;; keybindings

(define-key haskell-mode-map (kbd "C-c c") 'haskell-compile)
(define-key haskell-mode-map (kbd "C-c C-d") 'haskell-insert-doc)
(define-key haskell-mode-map (kbd "C-c C-u") 'haskell-insert-undefined)
(define-key haskell-mode-map (kbd "C-c [") 'haskell-move-nested-left)
(define-key haskell-mode-map (kbd "C-c ]") 'haskell-move-nested-right)
(define-key haskell-mode-map (kbd "M-,") 'haskell-who-calls)
(define-key haskell-mode-map (kbd "C-c C-m") 'haskell-auto-insert-module-template)

(global-set-key (kbd "C-c C-e") 'haskell-indent-insert-equal)
(global-set-key (kbd "C-c |") 'haskell-indent-insert-guard)
(global-set-key (kbd "C-c C-f") 'haskell-mode-format-imports)

(define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-or-reload)
(setq haskell-process-type 'stack-ghci)
(setq haskell-compile-cabal-build-command "stack build")
;; (setq haskell-process-path-ghci "stack")
;; (setq haskell-process-args-ghci "ghci")

;; (define-key haskell-mode-map (kbd "C-c `") 'haskell-interactive-bring)
;; (define-key haskell-mode-map (kbd "C-x C-d") nil)
;; (define-key haskell-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
;; (define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-file)
;; (define-key haskell-mode-map (kbd "C-c C-b") 'haskell-interactive-switch)
(define-key haskell-mode-map (kbd "C-c C-t") 'haskell-process-do-type)
;; (define-key haskell-mode-map (kbd "C-c C-i") 'haskell-process-do-info)
;; (define-key haskell-mode-map (kbd "C-c C-a") 'haskell-indent-align-guards-and-rhs)
;; (define-key haskell-mode-map (kbd "C-c M-.") nil)

;; hook

(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
