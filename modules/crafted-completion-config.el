;;; crafted-completion-config.el --- Crafted Completion Configuration -*- lexical-binding: t; -*-

;; Copyright (C) 2023
;; SPDX-License-Identifier: MIT

;; Author: System Crafters Community

;;; Commentary:

;; Setup completion packages. Completion in this sense is more like
;; narrowing, allowing the user to find matches based on minimal
;; inputs and "complete" the commands, variables, etc from the
;; narrowed list of possible choices.

;;; Code:

;;; ivy

(when (require 'ivy nil :noerror)
(ivy-mode 1)

;; (define-key ivy-minibuffer-map (kbd "C-j") 'ivy-next-line)
(define-key ivy-mode-map (kbd "C-j") 'ivy-next-line)
(define-key ivy-minibuffer-map (kbd "C-k") 'ivy-previous-line)
)

(when (require 'ivy-rich nil :noerror)
(ivy-rich-mode 1)
)

(when (require 'counsel nil :noerror)
(counsel-mode 1)
)

(ivy-prescient-mode 1)


(provide 'crafted-completion-config)
;;; crafted-completion.el ends here

