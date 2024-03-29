;;; crafted-evil-packages.el --- Evil mode packages -*- lexical-binding: t; -*-

;; Copyright (C) 2022
;; SPDX-License-Identifier: MIT

;; Author: System Crafters Community

;;; Commentary:

;; Packages for Evil mode, for those who prefer `Vim' keybindings.

;;; Code:

(add-to-list 'package-selected-packages 'evil)
(add-to-list 'package-selected-packages 'evil-collection)
(add-to-list 'package-selected-packages 'evil-nerd-commenter)
(add-to-list 'package-selected-packages 'general)
(add-to-list 'package-selected-packages 'which-key)
(add-to-list 'package-selected-packages 'winum)


;; Emacs 28+ prefer the built-in undo-redo facility, but for older
;; versions, undo-tree is a nice option.
(when (version< emacs-version "28")
  (add-to-list 'package-selected-packages 'undo-tree))

(provide 'crafted-evil-packages)
;;; crafted-evil-packages.el ends here
