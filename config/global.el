;; ido mode
(ido-mode t)
(setq ido-enable-flex-matching t)

;; remove menu bar
(menu-bar-mode -1)

;; always truncate long lines
(set-default 'truncate-lines t)

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

;; return n lines as a string
(defun n-lines (lines)
  (save-excursion
    (buffer-substring (progn (beginning-of-line 1) (point))
                      (progn (next-line (- lines 1)) (end-of-line 1) (point)))))

;; find/replacing
(defun replace-string-same-line (&optional lines)
  (interactive "P")
  (push-mark (point))
  (let* ((special (or (typep lines 'cons) (and (typep lines 'integer) (< lines 0))))
         (lines (cond
                 ((typep lines 'symbol) 0)
                 ((typep lines 'cons) 0)
                 ((< lines 0) (abs lines))
                 (t lines)))
         (src (if special
                  (ido-completing-read "replace: "
                                   (split-string
                                    (n-lines (+ 1 lines))))
                (read-from-minibuffer "replace: ")))
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

;; grapple left/right
(defun grapple-left (char)
  (interactive "cGrapple left: ")
  (push-mark (point))
  (search-backward (char-to-string char))
  (forward-char))
(defun grapple-right (char)
  (interactive "cGrapple right: ")
  (push-mark (point))
  (search-forward (char-to-string char))
  (backward-char))
(defun grapple-out ()
  (interactive)
  (call-interactively 'grapple-left)
  (call-interactively 'grapple-right))
(defun grapple-smart (char)
  (interactive "cGrapple out: ")
  (let* ((left char)
         (right
          (cond
           ((= ?\" left) ?\")
           ((= ?\' left) ?\')
           ((= ?\( left) ?\))
           ((= ?\[ left) ?\])
           ((= ?\{ left) ?\})
	   (t left))))
    (grapple-left left)
    (grapple-right right)))
(global-set-key (kbd "C-c ,") 'grapple-left)
(global-set-key (kbd "C-c C-,") 'grapple-left)
(global-set-key (kbd "C-c .") 'grapple-right)
(global-set-key (kbd "C-c C-.") 'grapple-right)
(global-set-key (kbd "C-c =") 'grapple-out)
(global-set-key (kbd "C-c C-=") 'grapple-out)
(global-set-key (kbd "C-c -") 'grapple-smart)
(global-set-key (kbd "C-c C--") 'grapple-out)

;; move lines up/down
(defun move-line-up ()
  (interactive)
  (let ((col (current-column)))
    (beginning-of-line)
    (kill-line 1)
    (previous-line)
    (yank)
    (previous-line)
    (forward-char col)))
(defun move-line-down ()
  (interactive)
  (let ((col (current-column)))
    (beginning-of-line)
    (kill-line 1)
    (next-line)
    (yank)
    (previous-line)
    (forward-char col)))
(global-set-key (kbd "M-P") 'move-line-up)
(global-set-key (kbd "M-N") 'move-line-down)


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

;; global key bindings

(define-key global-map (kbd "C-c C-s") 'ace-jump-mode)
