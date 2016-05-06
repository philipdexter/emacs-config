(setq user-mail-address "philip.dexter@gmail.com"
      user-full-name "Philip Dexter"
      smtpmail-smtp-server "smtp.gmail.com")

(setq gnus-select-method
      '(nnimap "gmail"
	       (nnimap-address "imap.gmail.com")
	       (nnimap-server-port "imaps")
	       (nnimap-stream ssl)))

(setq gnus-secondary-select-methods
      '((nnimap "phfilip"
		(nnimap-address "mail.phfilip.com")
		(nnimap-server-port 143)
		(nnimap-stream starttls))))

(setq smtpmail-smtp-service 587
      gnus-ignored-newsgroups "^to\\.\\|^[0-9. ]+\\( \\|$\\)\\|^[\"]\"[#'()]")

(setq send-mail-function 'smtpmail-send-it)

(require 'bbdb-loaddefs "~/.emacs.d/packages/bbdb/lisp/bbdb-loaddefs.el")
(bbdb-initialize 'gnus 'message)

(setq fill-flowed-display-column nil)
(add-hook 'gnus-article-mode-hook
	  (lambda ()
	    (setq
	     truncate-lines t
	     word-wrap nil)))

(setq gnus-treat-display-smileys nil)
