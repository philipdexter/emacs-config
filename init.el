(require 'cl)

;; locally installed packages
(defvar packages
  '(haskell-mode
    cycle-buffer
    god-mode
    ace-jump-mode
    undo-tree
    smex
    color-theme
    color-theme-solarized))

;; local config files
(defvar configs
  '("global"
    "haskell"
    "cycle-buffer"
    "god"
    "latex"
    "smex"
    "color-theme"))

(loop for name in packages
      do (progn (unless (fboundp name)
                  (add-to-list 'load-path
                               (concat (file-name-directory (or load-file-name
                                                                (buffer-file-name)))
                                       "packages/"
                                       (symbol-name name)))
                  (require name))))

(add-to-list 'load-path
             (concat (file-name-directory load-file-name)
                     "packages/"))

(loop for name in configs
      do (load (concat (file-name-directory load-file-name)
                       "config/"
                       name ".el")))

(turn-on-haskell-indent)
(load "haskell-mode-autoloads.el")
