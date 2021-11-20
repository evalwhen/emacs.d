;; -*- coding: utf-8; lexical-binding: t; -*-

;; some cool org tricks
;; @see http://emacs.stackexchange.com/questions/13820/inline-verbatim-and-code-with-quotes-in-org-mode

(with-eval-after-load 'org-clock
  ;; Change task state to STARTED when clocking in
  (setq org-clock-in-switch-to-state "STARTED")
  ;; Save clock data and notes in the LOGBOOK drawer
  (setq org-clock-into-drawer t)
  ;; Removes clocked tasks with 0:00 duration
  (setq org-clock-out-remove-zero-time-clocks t)

  ;; Show the clocked-in task - if any - in the header line
  (defun my-show-org-clock-in-header-line ()
    (setq-default header-line-format '((" " org-mode-line-string " "))))

  (defun my-hide-org-clock-from-header-line ()
    (setq-default header-line-format nil))

  (add-hook 'org-clock-in-hook 'my-show-org-clock-in-header-line)
  (add-hook 'org-clock-out-hook 'my-hide-org-clock-from-header-line)
  (add-hook 'org-clock-cancel-hook 'my-hide-org-clock-from-header-line)

  (define-key org-clock-mode-line-map [header-line mouse-2] 'org-clock-goto)
  (define-key org-clock-mode-line-map [header-line mouse-1] 'org-clock-menu))

;; {{ org2nikola set up
(setq org2nikola-output-root-directory "~/.config/nikola")
;; }}

(defun org-demote-or-promote (&optional is-promote)
  "Demote or promote current org tree."
  (interactive "P")
  (save-excursion
    (beginning-of-line)
    (unless (or (region-active-p)
                (let ((line (thing-at-point 'line t)))
                  (and (string-match-p "^\\*+ $" line) ;; is node only one spaced
                       (= (point) (- (point-max) (length line))) ;; is line at EOF
                       )))
      (org-mark-subtree)))
  (if is-promote (org-do-promote) (org-do-demote)))

;; {{ @see http://orgmode.org/worg/org-contrib/org-mime.html
(with-eval-after-load 'org-mime
  (setq org-mime-export-options '(:section-numbers nil :with-author nil :with-toc nil))
  (defun org-mime-html-hook-setup ()
    (org-mime-change-element-style "pre"
                                   "color:#E6E1DC; background-color:#232323; padding:0.5em;")
    (org-mime-change-element-style "blockquote"
                                   "border-left: 2px solid gray; padding-left: 4px;"))
  (add-hook 'org-mime-html-hook 'org-mime-html-hook-setup))
;; }}

(defun my-imenu-create-index-function-no-org-link ()
  "Imenu index function which returns items without org link."
  (let (rlt label marker)
    (dolist (elem (imenu-default-create-index-function))
      (cond
       ((and (setq label (car elem)) (setq marker (cdr elem)))
        (push (cons (replace-regexp-in-string "\\[\\[[^ ]+\\]\\[\\|\\]\\]" "" label) marker) rlt))
       (t
        (push elem rlt))))
    (nreverse rlt)))

(defun org-mode-hook-setup ()
  (unless (is-buffer-file-temp)
    (setq evil-auto-indent nil)

    ;; org-mime setup, run this command in org-file, than yank in `message-mode'
    (local-set-key (kbd "C-c M-o") 'org-mime-org-buffer-htmlize)

    ;; don't spell check double words
    (setq-local wucuo-flyspell-check-doublon nil)

    ;; create updated table of contents of org file
    ;; @see https://github.com/snosov1/toc-org
    (toc-org-enable)

    ;; default `org-indent-line' inserts extra spaces at the beginning of lines
    (setq-local indent-line-function 'indent-relative)

    ;; `imenu-create-index-function' is automatically buffer local
    (setq imenu-create-index-function 'my-imenu-create-index-function-no-org-link)

    ;; display wrapped lines instead of truncated lines
    (setq truncate-lines nil)
    (setq word-wrap t)))
(add-hook 'org-mode-hook 'org-mode-hook-setup)

(defvar my-pdf-view-from-history nil
  "PDF view FROM history which is List of (pdf-path . page-number).")

(defvar my-pdf-view-to-history nil
  "PDF view TO history which is List of (pdf-path . page-number).")

(with-eval-after-load 'org
  ;; {{
  (defvar my-org-src--saved-temp-window-config nil
    "Window layout before edit special element.")
  (defun my-org-edit-special (&optional arg)
    "Save current window layout before `org-edit' buffer is open.
ARG is ignored."
    (setq my-org-src--saved-temp-window-config (current-window-configuration)))

  (defun my-org-edit-src-exit ()
    "Restore the window layout that was saved before `org-edit-special' is called."
    (when my-org-src--saved-temp-window-config
      (set-window-configuration my-org-src--saved-temp-window-config)
      (setq my-org-src--saved-temp-window-config nil)))


  ;; org 9.3 do not restore windows layout when editing special element
  (advice-add 'org-edit-special :before 'my-org-edit-special)
  (advice-add 'org-edit-src-exit :after 'my-org-edit-src-exit)
  ;; }}

  (my-ensure 'org-clock)

  ;; org-re-reveal requires org 8.3
  (my-ensure 'org-re-reveal)

  ;; odt export
  (add-to-list 'org-export-backends 'odt)

  ;; markdown export
  (my-ensure 'ox-md)
  (add-to-list 'org-export-backends 'md)

  (defun org-agenda-show-agenda-and-todo (&optional arg)
    "Better org-mode agenda view."
    (interactive "P")
    (org-agenda arg "n"))


  (defun my-org-open-at-point-hack (orig-func &rest args)
    "\"C-u M-x org-open-at-point\" to open link with `browse-url-generic-program'.
It's value could be customized liked \"/usr/bin/firefox\".
\"M-x org-open-at-point\" to open the url with embedded emacs-w3m."
    (let* ((arg (nth 0 args))
           (reference-buffer (nth 1 args))
           (browse-url-browser-function
            (cond
             ;; open with `browse-url-generic-program'
             ((equal arg '(4)) 'browse-url-generic)
             ;; open with w3m
             (t 'w3m-browse-url))))
      (apply orig-func args)))
  (advice-add 'org-open-at-point :around #'my-org-open-at-point-hack)

  ;; {{ org pdf link
  (defun my-org-docview-open-hack (orig-func &rest args)
    (let* ((link (car args)) path page)
      (string-match "\\(.*?\\)\\(?:::\\([0-9]+\\)\\)?$" link)
      (setq path (match-string 1 link))
      (setq page (and (match-beginning 2)
                      (string-to-number (match-string 2 link))))

      ;; record FROM
      (my-focus-on-pdf-window-then-back
       (lambda (pdf-file)
         (when (and page (string= (file-name-base pdf-file) (file-name-base path)))
           ;; select pdf-window
           (when (and (memq major-mode '(doc-view-mode pdf-view-mode))
                      (setq pdf-from-page
                            (if (eq major-mode 'pdf-view-mode) (pdf-view-current-page) (doc-view-current-page)))
                      (> (abs (- page pdf-from-page)) 2))
             (my-push-if-uniq (format "%s:::%s" pdf-file pdf-from-page) my-pdf-view-from-history)))))
      ;; open pdf file
      (org-open-file path 1)
      (when page
        ;; record TO
        (my-push-if-uniq (format "%s:::%s" path page) my-pdf-view-to-history)
        ;; goto page
        (my-pdf-view-goto-page page))))
  (advice-add 'org-docview-open :around #'my-org-docview-open-hack)
  ;; }}

  (defun my-org-publish-hack (orig-func &rest args)
    "Stop running `major-mode' hook when `org-publish'."
    (let* ((my-load-user-customized-major-mode-hook nil))
      (apply orig-func args)))
  (advice-add 'org-publish :around #'my-org-publish-hack)

  ;; {{ convert to odt
  (defun my-setup-odt-org-convert-process ()
    (interactive)
    (let* ((cmd "/Applications/LibreOffice.app/Contents/MacOS/soffice"))
      (when (and *is-a-mac* (file-exists-p cmd))
        ;; org v8
        (setq org-odt-convert-processes
              '(("LibreOffice" "/Applications/LibreOffice.app/Contents/MacOS/soffice --headless --convert-to %f%x --outdir %d %i"))))))
  (my-setup-odt-org-convert-process)
  ;; }}

  (defun my-org-refile-hack (orig-func &rest args)
    "When `org-refile' scans org files, skip user's own code in `org-mode-hook'."
    (let* ((my-force-buffer-file-temp-p t))
      (apply orig-func args)))
  (advice-add 'org-refile :around #'my-org-refile-hack)

  ;; {{ export org-mode in Chinese into PDF
  ;; @see http://freizl.github.io/posts/tech/2012-04-06-export-orgmode-file-in-Chinese.html
  ;; and you need install texlive-xetex on different platforms
  ;; To install texlive-xetex:
  ;;    `sudo USE="cjk" emerge texlive-xetex` on Gentoo Linux
  (setq org-latex-pdf-process
        '("xelatex -interaction nonstopmode -output-directory %o %f"
          "xelatex -interaction nonstopmode -output-directory %o %f"
          "xelatex -interaction nonstopmode -output-directory %o %f")) ;; org v8
  ;; }}

  ;; misc
  (setq org-log-done t
        org-completion-use-ido t
        org-edit-src-content-indentation 0
        org-edit-timestamp-down-means-later t
        org-agenda-start-on-weekday nil
        org-agenda-span 14
        org-agenda-include-diary t
        org-agenda-window-setup 'current-window
        org-fast-tag-selection-single-key 'expert
        org-export-kill-product-buffer-when-displayed t
        ;; org-startup-indented t
        ;; {{ org 8.2.6 has some performance issue. Here is the workaround.
        ;; @see http://punchagan.muse-amuse.in/posts/how-i-learnt-to-use-emacs-profiler.html
        org-agenda-inhibit-startup t ;; ~50x speedup
        org-agenda-use-tag-inheritance nil ;; 3-4x speedup
        ;; }}
        ;; org v8
        org-odt-preferred-output-format "doc"
        org-tags-column 80

        org-refile-targets '((nil :maxlevel . 5) (org-agenda-files :maxlevel . 5))
        org-refile-use-outline-path 'file
        org-outline-path-complete-in-steps nil
        org-imenu-depth 9
        ;; @see http://irreal.org/blog/1
        ;; org-src-fontify-natively t))
        org-src-fontify-natively t))

;; GTDCONFIG
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


(if (boundp 'org-user-agenda-files)
    (setq org-agenda-files org-user-agenda-files)
  (setq org-agenda-files (quote ("~/git/org"
                               "~/git/org/client1"
                               "~/git/client2"))))


;; my-custom template
(setq org-directory "~/git/org")
(setq org-default-notes-file "~/git/org/refile.org")
(setq org-capture-templates
      (quote (("t" "todo" entry (file "~/git/org/refile.org")
               "* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t)
              ("r" "respond" entry (file "~/git/org/refile.org")
               "* NEXT Respond to %:from on %:subject\nSCHEDULED: %t\n%U\n%a\n" :clock-in t :clock-resume t :immediate-finish t)
              ("n" "note" entry (file "~/git/org/refile.org")
               "* %? :NOTE:\n%U\n%a\n" :clock-in t :clock-resume t)
              ("j" "Journal" entry (file+datetree "~/git/org/diary.org")
               "* %?\n%U\n" :clock-in t :clock-resume t)
              ("w" "org-protocol" entry (file "~/git/org/refile.org")
               "* TODO Review %c\n%U\n" :immediate-finish t)
              ("m" "Meeting" entry (file "~/git/org/refile.org")
               "* MEETING with %? :MEETING:\n%U" :clock-in t :clock-resume t)
              ("p" "Phone call" entry (file "~/git/org/refile.org")
               "* PHONE %? :PHONE:\n%U" :clock-in t :clock-resume t)
              ("h" "Habit" entry (file "~/git/org/refile.org")
               "* NEXT %?\n%U\n%a\nSCHEDULED: %(format-time-string \"%<<%Y-%m-%d %a .+1d/3d>>\")\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: NEXT\n:END:\n"))))

;; Refile
; Targets include this file and any file contributing to the agenda - up to 9 levels deep
(setq org-refile-targets (quote ((nil :maxlevel . 9)
                                 (org-agenda-files :maxlevel . 9))))

; Use full outline paths for refile targets - we file directly with IDO
(setq org-refile-use-outline-path t)

; Targets complete directly with IDO
(setq org-outline-path-complete-in-steps nil)

; Allow refile to create parent tasks with confirmation
(setq org-refile-allow-creating-parent-nodes (quote confirm))

; Use IDO for both buffer and file completion and ido-everywhere to t
(setq org-completion-use-ido t)
(setq ido-everywhere t)
(setq ido-max-directory-size 100000)
(ido-mode (quote both))
; Use the current window when visiting files and buffers with ido
(setq ido-default-file-method 'selected-window)
(setq ido-default-buffer-method 'selected-window)
; Use the current window for indirect buffer display
(setq org-indirect-buffer-display 'current-window)

;;;; Refile settings
; Exclude DONE state tasks from refile targets
(defun bh/verify-refile-target ()
  "Exclude todo keywords with a done state from refile targets"
  (not (member (nth 2 (org-heading-components)) org-done-keywords)))

(setq org-refile-target-verify-function 'bh/verify-refile-target)

;; Custom agenda command definitions
;; (setq org-agenda-custom-commands
;; Do not dim blocked tasks
(setq org-agenda-dim-blocked-tasks nil)

;; Compact the block agenda view
(setq org-agenda-compact-blocks t)

;; Custom agenda command definitions
(setq org-agenda-custom-commands
      (quote (("N" "Notes" tags "NOTE"
               ((org-agenda-overriding-header "Notes")
                (org-tags-match-list-sublevels t)))
              ("h" "Habits" tags-todo "STYLE=\"habit\""
               ((org-agenda-overriding-header "Habits")
                (org-agenda-sorting-strategy
                 '(todo-state-down effort-up category-keep))))
              (" " "Agenda"
               ((agenda "" nil)
                (tags "REFILE"
                      ((org-agenda-overriding-header "Tasks to Refile")
                       (org-tags-match-list-sublevels nil))))
               nil))))

(provide 'init-org)
