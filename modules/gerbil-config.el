;;; gerbil-mode.el --- support gerbil -*- lexical-binding: t; -*-

(setf gambit (getenv "GAMBIT_HOME"))
(setf gerbil (getenv "GERBIL_HOME"))

(autoload 'gerbil-mode
  "~/gerbil/etc/gerbil-mode.el" "Gerbil editing mode." t)
(require 'gambit
         "~/gambit/misc/gambit.el")

(setf scheme-program-name (concat gerbil "/bin/gxi"))

;; ((inferior-scheme-mode-hook . gambit-inferior-mode))

(provide 'gerbil-config)