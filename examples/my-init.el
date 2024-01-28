(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (and custom-file
           (file-exists-p custom-file))
  (load custom-file nil :nomessage))

(load "~/crafted-emacs/modules/crafted-init-config")

(set-default-coding-systems 'utf-8)

;; completions module
(require 'crafted-completion-packages)
(package-install-selected-packages t)
(require 'crafted-completion-config)

;; evil module
(require 'crafted-evil-packages)
(package-install-selected-packages t)
(require 'crafted-evil-config)


;; Load crafted-startup configuration
(require 'crafted-startup-config)

;; ui modules
(require 'crafted-ui-packages)
;; install the packages
(package-install-selected-packages t)
;; Load crafted-ui configuration
(require 'crafted-ui-config)

;; better defaults
;; install the packages
(package-install-selected-packages t)
;; Load crafted-updates configuration
(require 'crafted-defaults-config)

;; version control module 
(require 'version-control-packages)
(package-install-selected-packages t)
(require 'version-control-config)

;; lisp module
(require 'crafted-lisp-packages)
(package-install-selected-packages t)
(require 'crafted-lisp-config)

;; org mode
(require 'crafted-org-packages)
(package-install-selected-packages t)
(require 'crafted-org-config)

;; gtd
(require 'gtd-packages)
(package-install-selected-packages t)
(require 'gtd-config)

