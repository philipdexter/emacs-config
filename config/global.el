;; ido mode
(ido-mode t)
(setq ido-enable-flex-matching t)

;; require final newline
(setq-default require-final-newline t)

;; remove menu bar
(menu-bar-mode -1)

;; turn off electric-indent-mode
(set-default 'electric-indent-mode nil)

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


(defun zap-to-char-backwards (char)
  (interactive "cZap to char: ")
  (zap-to-char -1 char))
(global-set-key (kbd "C-M-z") 'zap-to-char-backwards)

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
    (propertize (format my-linum-format-string
			(if (= 0 offset)
			    line-number
			    (abs offset))
			) 'face (if (= 0 offset)
				    'outline-7
				    'idris-semantic-bound-face))))

(defadvice linum-update (around my-linum-update)
  (let ((my-linum-current-line-number (line-number-at-pos)))
    ad-do-it))
(ad-activate 'linum-update)

;; increment numbers
(defun increment-number-decimal (&optional arg)
  "Increment the number forward from point by 'arg'."
  (interactive "p*")
  (save-excursion
    (save-match-data
      (let (inc-by field-width answer)
        (setq inc-by (if arg arg 1))
        (skip-chars-backward "0123456789")
        (when (re-search-forward "[0-9]+" nil t)
          (setq field-width (- (match-end 0) (match-beginning 0)))
          (setq answer (+ (string-to-number (match-string 0) 10) inc-by))
          (when (< answer 0)
            (setq answer (+ (expt 10 field-width) answer)))
          (replace-match (format (concat "%0" (int-to-string field-width) "d")
                                 answer)))))))
(global-set-key (kbd "C-c +") 'increment-number-decimal)

;; recenter horizontally
(defun my-horizontal-recenter ()
  "make the point horizontally centered in the window"
  (interactive)
  (let ((mid (/ (window-width) 2))
	(line-len (save-excursion (end-of-line) (current-column)))
	(cur (current-column)))
    (if (< mid cur)
	(set-window-hscroll (selected-window)
			    (- cur mid)))))
(global-set-key (kbd "C-x l") 'my-horizontal-recenter)

;; global key bindings

(define-key global-map (kbd "C-c C-s") 'ace-jump-mode)

;; change mode line
(defun plist (list)
  (while list
    (print (car list))
    (setq list (cdr list))))

(setq-default mode-line-format
  (list
   "%e"

   '(:eval (when (buffer-modified-p)
	     (propertize "*" 'face 'font-lock-type-face)))

   '(:eval (when buffer-read-only
	     "%%"))

   '(:eval (propertize "%b " 'face 'font-lock-keyword-face))

   '(:eval (when god-local-mode
	     (propertize "G " 'face 'font-lock-warning-face)))

   (propertize "%02l" 'face 'font-lock-type-face) (propertize "," 'face 'font-lock-type-face)
   (propertize "%02c" 'face 'font-lock-type-face)

   (propertize " " 'face 'font-lock-type-face)
   (propertize "%p" 'face 'font-lock-type-face)

   (propertize " <" 'face 'font-lock-type-face)
   '(:eval (propertize "%m" 'face 'font-lock-string-face))
   (propertize "> " 'face 'font-lock-type-face)

   '(:eval (propertize (format-time-string "%H:%M") 'face 'font-lock-doc-face))

   (propertize " --" 'face 'font-lock-type-face)

   ;;'minor-mode-alist

   (propertize "%-" 'face 'font-lock-type-face)))
