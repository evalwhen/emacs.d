(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (and custom-file
           (file-exists-p custom-file))
  (load custom-file nil :nomessage))

(load "~/crafted-emacs/modules/crafted-init-config")


(set-default-coding-systems 'utf-8)

(require 'crafted-package-config)

;; completions module
(require 'crafted-completion-packages)
(crafted-package-install-selected-packages)
(require 'crafted-completion-config)

;; company
(require 'completion-inbuffer-packages)
(crafted-package-install-selected-packages)
(require 'completion-inbuffer-config)


;; evil module
(require 'crafted-evil-packages)
(crafted-package-install-selected-packages)
(require 'crafted-evil-config)


;; Load crafted-startup configuration
(require 'crafted-startup-config)

;; ui modules
(require 'crafted-ui-packages)
;; install the packages
(crafted-package-install-selected-packages)
;; Load crafted-ui configuration
(require 'crafted-ui-config)

;; better defaults
;; install the packages
(crafted-package-install-selected-packages)
;; Load crafted-updates configuration
(require 'crafted-defaults-config)

;; version control module 
(require 'version-control-packages)
(crafted-package-install-selected-packages)
(require 'version-control-config)

;; lisp module
(require 'crafted-lisp-packages)
(crafted-package-install-selected-packages)
(require 'crafted-lisp-config)

;; denote
(require 'crafted-org-packages)
(crafted-package-install-selected-packages)
(require 'crafted-org-config)

;; gtd
(require 'gtd-packages)
(crafted-package-install-selected-packages)
(require 'gtd-config)

(require 'common-lisp-packages)
(crafted-package-install-selected-packages)
(require 'common-lisp-config)

(require 'haskell-packages)
(crafted-package-install-selected-packages)
(require 'haskell-config)

(require 'racket-packages)
(crafted-package-install-selected-packages)
(require 'racket-config)

;; gerbil
(require 'gerbil-config)

;; golang
(require 'golang-packages)
(crafted-package-install-selected-packages)
(require 'golang-config)

;; notes
(require 'note-packages)
(crafted-package-install-selected-packages)
(require 'note-config)

;; clojure
(require 'clojure-packages)
(crafted-package-install-selected-packages)
(require 'clojure-config)


;; nice debug method
;; (setq debug-on-error t)

;; (defun force-debug (func &rest args)
;;   (condition-case e
;;       (apply func args)
;;     ((debug error) (signal (car e) (cdr e)))))

;; (advice-add #'corfu--post-command :around #'force-debug)


;; use straight.el
