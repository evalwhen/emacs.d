;;;; crafted-lisp-config.el --- Lisp development configuration  -*- lexical-binding: t; -*-

;; Copyright (C) 2022
;; SPDX-License-Identifier: MIT

;; Author: System Crafters Community

;;; Code:

;; Global defaults
(require 'eldoc)

;; aggressive-indent-mode for all lisp modes
(when (locate-library "aggressive-indent")
  (add-hook 'lisp-mode-hook #'aggressive-indent-mode)
  (add-hook 'clojure-mode-hook #'aggressive-indent-mode)
  (add-hook 'scheme-mode-hook #'aggressive-indent-mode))

;;; Scheme and Racket
;; The default is "scheme" which is used by cmuscheme, xscheme and
;; chez (at least). We are configuring guile, so use the apporpriate
;; command for that implementation.
(customize-set-variable 'scheme-program-name "scheme")
(add-hook 'scheme-mode-hook #'evil-cleverparens-mode)

;; (autoload 'enable-paredit-mode "paredit"
;;   "Turn on pseudo-structural editing of Lisp code."
;;   t)
(add-hook 'emacs-lisp-mode-hook       'enable-paredit-mode)
(add-hook 'lisp-mode-hook             'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)
(add-hook 'scheme-mode-hook           'enable-paredit-mode)

;; prism
(add-hook 'emacs-lisp-mode-hook       'prism-mode)
(add-hook 'lisp-mode-hook             'prism-mode)
(add-hook 'lisp-interaction-mode-hook 'prism-mode)
(add-hook 'scheme-mode-hook           'prism-mode)

(customize-set-variable 'prism-parens t)
(show-paren-mode 1)



(provide 'crafted-lisp-config)
;;; crafted-lisp-config.el ends here
