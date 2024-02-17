
(setq inferior-lisp-program "/usr/bin/sbcl")

(evil-declare-key 'normal lisp-mode-map
                  "gd" 'sly-edit-definition
                  "gr" 'sly-who-references
                  "gc" 'sly-who-calls
                  "gm" 'sly-who-macroexpands
                  "gf" 'sly-compile-defun
                  "gb" 'sly-pop-find-definition-stack
                  ;; "ds" 'sly-stickers-dwim
                  ;; "dr" 'sly-stickers-replay
                  ;; "dt" 'sly-stickers-toggle-break-on-stickers
                  ;; "df" 'sly-stickers-fetch
                  )
;; (my-local-leader-def 'normal lisp-mode-map
;;                      "sf" 'paredit-forward-slurp-sexp
;;                      "sb" 'paredit-backward-slurp-sexp
;;                      "bf" 'paredit-forward-barf-sexp
;;                      "bb" 'paredit-backward-barf-sexp
;;                      "r" 'paredit-raise-sexp
;;                      "w" 'paredit-wrap-sexp)



;; (evil-declare-key 'normal sly-mrepl-mode-map
;;                   "sb" 'isearch-backward
;;                   )

;; (load "~/common-lisp/nyxt/build-scripts/nyxt-guix.el" )
;; (load "~/common-lisp/nyxt/build-scripts/nyxt-guix.el" :noerror)

;; (setq sly-lisp-implementations
;;         '((nyxt-sbcl
;;            (lambda () (nyxt-make-guix-cl-for-nyxt
;;                   "~/common-lisp/nyxt"
;;                   :force t
;;                   :cl-implementation "sbcl"
;;                   :cl-system "nyxt/gi-gtk"
;;                   :no-grafts t
;;                   :preserve '("GDK_SCALE GDK_DPI_SCALE")
;;                   :ad-hoc '("emacs" "xdg-utils" "git"))))))

;; intent code
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
;; (setq indent-line-function 'insert-tab)

(provide 'common-lisp-config)
