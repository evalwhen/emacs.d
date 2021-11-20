(autoload 'gerbil-mode "gerbil-mode" "Gerbil editing mode." t)
(add-hook 'inferior-scheme-mode-hook 'gambit-inferior-mode)

(defvar gerbil-program-name
  (expand-file-name "~/gerbil/bin/gxi")) ; Set this for your GERBIL_HOME
(setq scheme-program-name gerbil-program-name)

(visit-tags-table "/Users/melp/Downloads/gerbil-0.16/src/TAGS")

(provide 'init-gerbil)