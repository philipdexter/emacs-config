(setq user-mail-address "philip.dexter@gmail.com"
      user-full-name "Philip Dexter"
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 587
      send-mail-function 'smtpmail-send-it)

(setq gnus-select-method
      '(nnimap "gmail"
	       (nnimap-address "imap.gmail.com")
	       (nnimap-server-port "imaps")
	       (nnimap-stream ssl)))

(setq gnus-secondary-select-methods
      '((nnimap "runbox"
		(nnimap-address "mail.runbox.com")
		(nnimap-server-port 993)
		(nnimap-stream ssl))))

;; (setq gnus-ignored-newsgroups "^to\\.\\|^[0-9. ]+\\( \\|$\\)\\|^[\"]\"[#'()]")

(require 'bbdb-loaddefs "~/.emacs.d/packages/bbdb/lisp/bbdb-loaddefs.el")
(bbdb-initialize 'gnus 'message)

(setq fill-flowed-display-column nil)
(add-hook 'gnus-article-mode-hook
	  (lambda ()
	    (setq
	     truncate-lines t
	     word-wrap nil)))

(setq gnus-treat-display-smileys nil)

;(set-face-attribute 'gnus-summary-selected nil :background "white")

(defun my/mail-demon ()
  (interactive)
  (gnus-demon-init)
  (setq gnus-demon-timestep 60)
  (gnus-demon-add-handler 'gnus-demon-scan-news 2 1))

(defun my/all-mail ()
  (interactive)
  (gnus)
  (my/mail-demon))
