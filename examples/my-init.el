(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (and custom-file
           (file-exists-p custom-file))
  (load custom-file nil :nomessage))

(load "~/crafted-emacs/modules/crafted-init-config")

(set-default-coding-systems 'utf-8)

;; completions module
(require 'crafted-completion-packages)
(package-install-selected-packages)

;; Load crafted-completion configuration
(require 'crafted-completion-config)

;; evil module
(require 'crafted-evil-packages)

;; install the packages
(package-install-selected-packages)

;; Load crafted-evil configuration
(require 'crafted-evil-config)


;; Load crafted-startup configuration
(require 'crafted-startup-config)

;; ui modules
(require 'crafted-ui-packages)
;; install the packages
(package-install-selected-packages)
;; Load crafted-ui configuration
(require 'crafted-ui-config)

;; better defaults
;; install the packages
(package-install-selected-packages)
;; Load crafted-updates configuration
(require 'crafted-defaults-config)

;; version control module 
(require 'version-control-packages)
(package-install-selected-packages)
(require 'version-control-config)

;; lisp module
(require 'crafted-lisp-packages)
(package-install-selected-packages)
(require 'crafted-lisp-config)

;; company module
(require 'completion-inbuffer-packages)
(package-install-selected-packages)
(require 'completion-inbuffer-config)
