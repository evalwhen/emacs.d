;;; crafted-evil-config.el --- Evil mode configuration -*- lexical-binding: t; -*-

;; Copyright (C) 2023
;; SPDX-License-Identifier: MIT

;; Author: System Crafters Community

;;; Commentary:

;; Evil mode configuration, for those who prefer `Vim' keybindings.

;;; Code:

;; Turn on undo-tree globally for version older than 28.  Use
;; undo-redo for Emacs 28+
(when (and (version< emacs-version "28")
           (locate-library "undo-tree"))
  (global-undo-tree-mode))

;; Set some variables that must be configured before loading the package
(customize-set-variable 'evil-want-integration t)
(customize-set-variable 'evil-want-keybinding nil)
(customize-set-variable 'evil-want-C-i-jump nil)
(customize-set-variable 'evil-respect-visual-line-mode t)
;; C-h is backspace in insert state
(customize-set-variable 'evil-want-C-h-delete t)
(if (version< emacs-version "28")
  (customize-set-variable 'evil-undo-system 'undo-tree)
  (customize-set-variable 'evil-undo-system 'undo-redo))

(defun crafted-evil-vim-muscle-memory ()
  "Make a more familiar Vim experience.

Take some of the default keybindings for evil mode."
    (customize-set-variable 'evil-want-C-i-jump t)
    (customize-set-variable 'evil-want-Y-yank-to-eol t)
    (customize-set-variable 'evil-want-fine-undo t))

;; Load Evil and enable it globally
(require 'evil)
(evil-mode 1)

;; Make evil search more like vim
(evil-select-search-module 'evil-search-module 'evil-search)

;; Turn on Evil Nerd Commenter
(evilnc-default-hotkeys)

;; Make C-g revert to normal state
(keymap-set evil-insert-state-map "C-g" 'evil-normal-state)

;; Rebind `universal-argument' to 'C-M-u' since 'C-u' now scrolls the buffer
(keymap-global-set "C-M-u" 'universal-argument)

;; Use visual line motions even outside of visual-line-mode buffers
(evil-global-set-key 'motion "j" 'evil-next-visual-line)
(evil-global-set-key 'motion "k" 'evil-previous-visual-line)

(defun crafted-evil-discourage-arrow-keys ()
  "Turn on a message to discourage use of arrow keys.

Rebinds the arrow keys to display a message instead."

  (defun crafted-evil-discourage-arrow-keys ()
    (message "Use HJKL keys instead!"))

  ;; Disable arrow keys in normal and visual modes
  (keymap-set evil-normal-state-map "<left>"  #'crafted-evil-discourage-arrow-keys)
  (keymap-set evil-normal-state-map "<right>" #'crafted-evil-discourage-arrow-keys)
  (keymap-set evil-normal-state-map "<down>"  #'crafted-evil-discourage-arrow-keys)
  (keymap-set evil-normal-state-map "<up>"    #'crafted-evil-discourage-arrow-keys)
  (evil-global-set-key 'motion      (kbd "<left>")  #'crafted-evil-discourage-arrow-keys)
  (evil-global-set-key 'motion      (kbd "<right>") #'crafted-evil-discourage-arrow-keys)
  (evil-global-set-key 'motion      (kbd "<down>")  #'crafted-evil-discourage-arrow-keys)
  (evil-global-set-key 'motion      (kbd "<up>")    #'crafted-evil-discourage-arrow-keys))

;; Make sure some modes start in Emacs state
;; TODO: Split this out to other configuration modules?
(dolist (mode '(custom-mode
                eshell-mode
                term-mode))
  (add-to-list 'evil-emacs-state-modes mode))

;;; Evil Collection or some sparse defaults
(if (locate-library "evil-collection")
    ;; If the user has `evil-collection' installed, initialize it.
    (evil-collection-init)
  )

;; from emacs from scratch
;; which-key

(which-key-mode 1)
(general-create-definer efs/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")

;; paredit global keys
;; WARNING: check this before add leader-keys
(efs/leader-keys
  "r" 'paredit-raise-sexp
  "s" 'paredit-forward-slurp-sexp
  "be" 'paredit-forward-barf-sexpr
  ;;"ss" 'paredit-back-slurp-expr
  )

(efs/leader-keys
    "SPC" 'execute-extended-command
    "t" '(:ignore t :which-key "toggles")
    "tt" '(counsel-load-theme :which-key "choose theme")
    "f" '(:ignore t :which-key "files")
    "ff" 'find-file
    "fr" 'consult-recent-file
    "b" '(:ignore t :which-key "buffers")
    "bs" 'consult-buffer
    "bd" 'evil-delete-buffer
    "bb" '(lambda () (interactive) (switch-to-buffer nil)) ; to previous buffer
    "w" '(:ignore t :which-key "windows")
    "wd" 'delete-window
    "wo" 'delete-other-windows
    "w1" 'split-window-vertically
    "w2" 'split-window-horizontally
    "c" '(:ignore t :which-key "comment")
    "cl" 'evilnc-comment-or-uncomment-lines)

(efs/leader-keys
  "g"   '(:ignore t :which-key "git and xref")
  "gs"  'magit-status
  "gd"  'magit-diff-unstaged
  "gc"  'magit-branch-or-checkout
  "gl"   '(:ignore t :which-key "log")
  "glc" 'magit-log-current
  "glf" 'magit-log-buffer-file
  "gb"  'magit-branch
  "gP"  'magit-push-current
  "gp"  'magit-pull-branch
  "gf"  'magit-fetch
  "gF"  'magit-fetch-all
  "gr"  'magit-rebase
  "gg" 'xref-find-definitions
  )

(efs/leader-keys
  ;; "pf" 'project-find-file
  "pf" 'consult-find
  ;; "ps" 'projectile-switch-project
  ;; "pF" 'consult-ripgrep
  "pq" 'project-query-replace-regexp
  ;; "pc" 'projectile-compile-project
  ;; "pk" 'projectile-kill-buffers
  ;; "pb" 'projectile-switch-to-buffer
  ;; "pd" 'projectile-dired
  ;; "pa" 'project-find-regexp
  "pa" 'consult-grep
  ;; "pa" 'projectile-ag
  )

;; winum package
(winum-mode 1)
(efs/leader-keys
  "0" 'winum-select-window-0
  "1" 'winum-select-window-1
  "2" 'winum-select-window-2
  "3" 'winum-select-window-3
  "4" 'winum-select-window-4)


;; denote notes
(efs/leader-keys
  "nn" 'denote
  "nf" 'consult-notes
  "nr" 'denote-region
  )

;; org and gtd
(efs/leader-keys
  "o" '(:ignore t :which-key "org")
  "og" 'org-agenda
  "os" 'org-schedule
  "ot" 'org-todo
  )


;; (evil-define-key 'state 'global (kbd "g b") 'xref-go-back)
(define-key evil-normal-state-map (kbd "g b") 'xref-go-back)


(provide 'crafted-evil-config)
;;; crafted-evil-config.el ends here
