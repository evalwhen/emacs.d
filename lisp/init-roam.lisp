(setq org-roam-directory (file-truename "~/org-roam"))
(org-roam-db-autosync-mode)
(setq org-roam-completion-everywhere t)

(setq org-roam-mode-section-functions
      (list #'org-roam-backlinks-section
            #'org-roam-reflinks-section
            ;; #'org-roam-unlinked-references-section
            ))
(setq org-id-link-to-org-use-id 'create-if-interactive)
(setq org-roam-v2-ack t)
;;(define-key evil-normal-state-map "" 'beginning-of-defun)

(provide 'init-roam)