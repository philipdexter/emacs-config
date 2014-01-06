;; cool buffer switching
(iswitchb-mode 1)

;; remove menu bar
(menu-bar-mode -1)

;; don't show startup messages
(setq inhibit-startup-message t)
(setq inhibit-startup-echo-area-message t)

;; show columns
(column-number-mode t)

;; remove region highlighting
(transient-mark-mode -1)

;; backup to home directory
(setq
 backup-by-copying t
 backup-directory-alist '(("." . "~/.emacs.d/bak/"))
 auto-save-file-name-transforms `((".*" ,"~/.emacs.d/autosaves/" t)))

;; whitespace
(setq-default show-trailing-whitespace t)

;; find/replacing
(defun replace-string-same-line (&optional lines)
  (interactive "P")
  (push-mark (point))
  (let ((src (read-from-minibuffer "replace: "))
        (dst (read-from-minibuffer "with: "))
        (end (progn
	       (forward-line lines) (end-of-line) (point))))
    (pop-to-mark-command)
    (push-mark (point))
    (beginning-of-line)
    (while (search-forward-regexp src end t)
      (replace-match dst))
    (pop-to-mark-command)))
(global-set-key (kbd "C-c C-_") 'replace-string-same-line)
(global-set-key (kbd "C-c C-/") 'replace-string-same-line)

;; relative line numbers
(defvar my-linum-format-string "%3d")

(add-hook 'linum-before-numbering-hook 'my-linum-get-format-string)

(defun my-linum-get-format-string ()
  (let* ((width (1+ (length (number-to-string
                             (count-lines (point-min) (point-max))))))
         (format (concat "%" (number-to-string width) "d")))
    (setq my-linum-format-string format)))

(defvar my-linum-current-line-number 0)

(setq linum-format 'my-linum-relative-line-numbers)

(defun my-linum-relative-line-numbers (line-number)
  (let ((offset (- line-number my-linum-current-line-number)))
    (propertize (format my-linum-format-string (abs offset)) 'face 'linum)))

(defadvice linum-update (around my-linum-update)
  (let ((my-linum-current-line-number (line-number-at-pos)))
    ad-do-it))
(ad-activate 'linum-update)
