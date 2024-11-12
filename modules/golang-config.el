(require 'go-mode)

(add-hook 'go-mode-hook 'subword-mode)
(add-hook 'go-mode-hook 'smartparens-mode)
(add-hook 'before-save-hook 'gofmt-before-save)

(add-hook 'go-mode-hook (lambda ()
                          (setq tab-width 4)
                          ))

(provide 'golang-config)
