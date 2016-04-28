;; save history
(savehist-mode 1)
(setq savehist-file "~/.emacs.d/savehist")
(if (file-exists-p "~/.emacs.d/savehist")
    (load-file "~/.emacs.d/savehist"))

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

;; disable cursor blinking
(setq visible-cursor nil)

;; backup to home directory
(setq
 backup-by-copying t
 backup-directory-alist '(("." . "~/.emacs.d/bak/"))
 auto-save-file-name-transforms `((".*" ,"~/.emacs.d/autosaves/" t)))

;; whitespace
(setq-default show-trailing-whitespace t)
(define-key global-map (kbd "M-F") 'forward-whitespace)
(defun backward-whitespace (arg)
  (interactive "^p")
  (forward-whitespace (- 0 arg)))
(define-key global-map (kbd "M-B") 'backward-whitespace)

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
(define-key global-map (kbd "C-x r t") 'string-insert-rectangle)

;; change mode line
(setq-default mode-line-format
  (list
   "%e"

   '(:eval (when (buffer-modified-p)
	     (propertize "*" 'face 'font-lock-type-face)))

   '(:eval (when buffer-read-only
	     "%%"))

   '(:eval (propertize "%b " 'face 'font-lock-keyword-face))

   (propertize "%02l" 'face 'font-lock-type-face) (propertize "," 'face 'font-lock-type-face)
   (propertize "%02c" 'face 'font-lock-type-face)

   (propertize " " 'face 'font-lock-type-face)
   (propertize "%p" 'face 'font-lock-type-face)

   (propertize " <" 'face 'font-lock-type-face)
   '(:eval (propertize "%m" 'face 'font-lock-string-face))
   (propertize "> " 'face 'font-lock-type-face)

   (propertize "--" 'face 'font-lock-type-face)

   `(:propertize ("" minor-mode-alist) face font-lock-type-face)

   (propertize "%-" 'face 'font-lock-type-face)))



;; C-,
(define-key input-decode-map "\e[49~" [(f35)])
(define-key key-translation-map (kbd "C-<f3>") (kbd "C-,"))
(define-key key-translation-map (kbd "<f35>") (kbd "C-,"))

;; C-RET
(define-key input-decode-map "\e[50~" [(f36)])
(define-key key-translation-map (kbd "C-<f4>") (kbd "C-RET"))
(define-key key-translation-map (kbd "<f36>") (kbd "C-RET"))

;; M-S-RET
(define-key input-decode-map "\e[51~" [(f37)])
(define-key key-translation-map (kbd "C-<f5>") (kbd "M-S-RET"))
(define-key key-translation-map (kbd "<f37>") (kbd "M-S-RET"))

;; C-M-%
(define-key input-decode-map "\e[52~" [(f38)])
(define-key key-translation-map (kbd "C-<f6>") (kbd "C-M-%"))
(define-key key-translation-map (kbd "<f38>") (kbd "C-M-%"))
