;; The following setting is different from the document so that you
;; can override the document path by setting your path in the variable
;; org-mode-user-lisp-path
;;
;;; packages.el --- gtd Layer packages File for Spacemacs
;;
;; Copyright (c) 2012-2014 Sylvain Benner
;; Copyright (c) 2014-2015 Sylvain Benner & Contributors
;;
;; Author: Sylvain Benner <sylvain.benner@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(setq org-agenda-files (quote ("~/Nutstore Files/org/"
                               )))

(require 'org)

;; set evil-org-gtd keys
(defun evil-org-agenda-set-keys ()
  "Set motion state keys for `org-agenda'."
  (evil-set-initial-state 'org-agenda-mode 'motion)

  ;; Horizontal movements have little use, thus we can override "f" and "t".
  ;; "w", "b", "e", "ge" and their upcase counterparts are preserved.
  (evil-define-key 'motion org-agenda-mode-map
    ;; Unused keys: D, X

    ;; open
    (kbd "<tab>") 'org-agenda-goto
    (kbd "S-<return>") 'org-agenda-goto
    (kbd "g TAB") 'org-agenda-goto
    (kbd "RET") 'org-agenda-switch-to
    (kbd "M-RET") 'org-agenda-recenter

    (kbd "SPC") 'org-agenda-show-and-scroll-up
    (kbd "<delete>") 'org-agenda-show-scroll-down
    (kbd "<backspace>") 'org-agenda-show-scroll-down

    ;; motion
    "j" 'org-agenda-next-line
    "k" 'org-agenda-previous-line
    "gj" 'org-agenda-next-item
    "gk" 'org-agenda-previous-item
    "gH" 'evil-window-top
    "gM" 'evil-window-middle
    "gL" 'evil-window-bottom
    (kbd "C-j") 'org-agenda-next-item
    (kbd "C-k") 'org-agenda-previous-item
    (kbd "[[") 'org-agenda-earlier
    (kbd "]]") 'org-agenda-later

    ;; manipulation
    ;; We follow standard org-mode bindings (not org-agenda bindings):
    ;; <HJKL> change todo items and priorities.
    ;; M-<jk> drag lines.
    ;; M-<hl> cannot demote/promote, we use it for "do-date".
    "J" 'org-agenda-priority-down
    "K" 'org-agenda-priority-up
    "H" 'org-agenda-do-date-earlier
    "L" 'org-agenda-do-date-later
    "t" 'org-agenda-todo
    (kbd "M-j") 'org-agenda-drag-line-forward
    (kbd "M-k") 'org-agenda-drag-line-backward
    (kbd "C-S-h") 'org-agenda-todo-previousset ; Original binding "C-S-<left>"
    (kbd "C-S-l") 'org-agenda-todo-nextset ; Original binding "C-S-<right>"

    ;; undo
    "u" 'org-agenda-undo

    ;; actions
    "dd" 'org-agenda-kill
    "dA" 'org-agenda-archive
    "da" 'org-agenda-archive-default-with-confirmation
    "ct" 'org-agenda-set-tags
    "ce" 'org-agenda-set-effort
    "cT" 'org-timer-set-timer
    "i" 'org-agenda-diary-entry
    "a" 'org-agenda-add-note
    "A" 'org-agenda-append-agenda
    "C" 'org-agenda-capture

    ;; mark
    "m" 'org-agenda-bulk-toggle
    "~" 'org-agenda-bulk-toggle-all
    "*" 'org-agenda-bulk-mark-all
    "%" 'org-agenda-bulk-mark-regexp
    "M" 'org-agenda-bulk-unmark-all
    "x" 'org-agenda-bulk-action

    ;; refresh
    "gr" 'org-agenda-redo
    "gR" 'org-agenda-redo-all

    ;; quit
    "ZQ" 'org-agenda-exit
    "ZZ" 'org-agenda-quit

    ;; display
    ;; "Dispatch" can prefix the following:
    ;; 'org-agenda-toggle-deadlines
    ;; 'org-agenda-toggle-diary
    ;; 'org-agenda-follow-mode
    ;; 'org-agenda-log-mode
    ;; 'org-agenda-entry-text-mode
    ;; 'org-agenda-toggle-time-grid
    ;; 'org-agenda-day-view
    ;; 'org-agenda-week-view
    ;; 'org-agenda-year-view
    "gD" 'org-agenda-view-mode-dispatch
    "ZD" 'org-agenda-dim-blocked-tasks

    ;; filter
    "sc" 'org-agenda-filter-by-category
    "sr" 'org-agenda-filter-by-regexp
    "se" 'org-agenda-filter-by-effort
    "st" 'org-agenda-filter-by-tag
    "s^" 'org-agenda-filter-by-top-headline
    "ss" 'org-agenda-limit-interactively
    "S" 'org-agenda-filter-remove-all

    ;; clock
    "I" 'org-agenda-clock-in ; Original binding
    "O" 'org-agenda-clock-out ; Original binding
    "cg" 'org-agenda-clock-goto
    "cc" 'org-agenda-clock-cancel
    "cr" 'org-agenda-clockreport-mode

    ;; go and show
    "." 'org-agenda-goto-today ; TODO: What about evil-repeat?
    "gc" 'org-agenda-goto-calendar
    "gC" 'org-agenda-convert-date
    "gd" 'org-agenda-goto-date
    "gh" 'org-agenda-holidays
    "gm" 'org-agenda-phases-of-moon
    "gs" 'org-agenda-sunrise-sunset
    "gt" 'org-agenda-show-tags

    "p" 'org-agenda-date-prompt
    "P" 'org-agenda-show-the-flagging-note

    ;; 'org-save-all-org-buffers ; Original binding "C-x C-s"

    ;; Others
    "+" 'org-agenda-manipulate-query-add
    "-" 'org-agenda-manipulate-query-subtract))

(evil-org-agenda-set-keys)

;;==============================
;; todo keywords
(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
              (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)" "PHONE" "MEETING"))))

(setq org-todo-keyword-faces
      (quote (("TODO" :foreground "red" :weight bold)
              ("NEXT" :foreground "blue" :weight bold)
              ("DONE" :foreground "forest green" :weight bold)
              ("WAITING" :foreground "orange" :weight bold)
              ("HOLD" :foreground "magenta" :weight bold)
              ("CANCELLED" :foreground "forest green" :weight bold)
              ("MEETING" :foreground "forest green" :weight bold)
              ("PHONE" :foreground "forest green" :weight bold))))

;; TODO State Triggers
;; The triggers break down to the following rules:

;; Moving a task to CANCELLED adds a CANCELLED tag
;; Moving a task to WAITING adds a WAITING tag
;; Moving a task to HOLD adds WAITING and HOLD tags
;; Moving a task to a done state removes WAITING and HOLD tags
;; Moving a task to TODO removes WAITING, CANCELLED, and HOLD tags
;; Moving a task to NEXT removes WAITING, CANCELLED, and HOLD tags
;; Moving a task to DONE removes WAITING, CANCELLED, and HOLD tags

(setq org-todo-state-tags-triggers
      (quote (("CANCELLED" ("CANCELLED" . t))
              ("WAITING" ("WAITING" . t))
              ("HOLD" ("WAITING") ("HOLD" . t))
              (done ("WAITING") ("HOLD"))
              ("TODO" ("WAITING") ("CANCELLED") ("HOLD"))
              ("NEXT" ("WAITING") ("CANCELLED") ("HOLD"))
              ("DONE" ("WAITING") ("CANCELLED") ("HOLD")))))

;;========================================
;; org-capture

(defvar base-org-directory "~/Nutstore Files/org/")
(setq org-directory base-org-directory)
(setq org-default-notes-file (concat base-org-directory "refile.org"))

;; I use C-c c to start capture mode
(global-set-key (kbd "C-c c") 'org-capture)

;; Capture templates for: TODO tasks, Notes, appointments, phone calls, meetings, and org-protocol
(setq org-capture-templates
      (quote (("t" "todo" entry (file org-default-notes-file)
               "* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t)
              ("r" "respond" entry (file org-default-notes-file)
               "* NEXT Respond to %:from on %:subject\nSCHEDULED: %t\n%U\n%a\n" :clock-in t :clock-resume t :immediate-finish t)
              ("n" "note" entry (file org-default-notes-file)
               "* %? :NOTE:\n%U\n%a\n" :clock-in t :clock-resume t)
              ("j" "Journal" entry (file+datetree (concat base-org-directory "journal.org"))
               "* %?\n%U\n" :clock-in t :clock-resume t)
              ("w" "org-protocol" entry (file org-default-notes-file)
               "* TODO Review %c\n%U\n" :immediate-finish t)
              ("m" "Meeting" entry (file org-default-notes-file)
               "* MEETING with %? :MEETING:\n%U" :clock-in t :clock-resume t)
              ("p" "Phone call" entry (file org-default-notes-file)
               "* PHONE %? :PHONE:\n%U" :clock-in t :clock-resume t)
              ("h" "Habit" entry (file org-default-notes-file)
               "* NEXT %?\n%U\n%a\nSCHEDULED: %(format-time-string \"%<<%Y-%m-%d %a .+1d/3d>>\")\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: NEXT\n:END:\n"))))

;; Remove empty LOGBOOK drawers on clock out
(defun bh/remove-empty-drawer-on-clock-out ()
  (interactive)
  (save-excursion
    (beginning-of-line 0)
    (org-remove-empty-drawer-at "LOGBOOK" (point))))

(add-hook 'org-clock-out-hook 'bh/remove-empty-drawer-on-clock-out 'append)

;;===============================
;; refile setup
; Targets include this file and any file contributing to the agenda - up to 9 levels deep
(setq org-refile-targets (quote ((nil :maxlevel . 9)

                                 (org-agenda-files :maxlevel . 9))))
; Use full outline paths for refile targets - we file directly with IDO
(setq org-refile-use-outline-path t)
; Targets complete directly with IDO
(setq org-outline-path-complete-in-steps nil)
; Allow refile to create parent tasks with confirmation
(setq org-refile-allow-creating-parent-nodes (quote confirm))

;; Save the corresponding buffers after refile
(defun gtd-save-org-buffers ()
  "Save `org-agenda-files' buffers without user confirmation.
See also `org-save-all-org-buffers'"
  (interactive)
  (message "Saving org-agenda-files buffers...")
  (save-some-buffers t (lambda () 
			 (when (member (buffer-file-name) org-agenda-files) 
			   t)))
  (message "Saving org-agenda-files buffers... done"))

;; Add it after refile
(advice-add 'org-refile :after
	    (lambda (&rest _)
	      (org-save-all-org-buffers)))

;;=====================================
;; Customize agenda view
;; Do not dim blocked tasks
(setq org-agenda-dim-blocked-tasks nil)
;; auto save after agenda quit
(advice-add 'org-agenda-quit :before 'org-save-all-org-buffers)

;; Compact the block agenda view
(setq org-agenda-compact-blocks t)

;; Custom agenda command definitions
;; todo


(provide 'gtd-config)
