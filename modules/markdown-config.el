(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)

(add-to-list 'auto-mode-alist
             '("\\.\\(?:md\\|markdown\\|mkd\\|mdown\\|mkdn\\|mdwn\\)\\'" . markdown-mode))

(provide 'markdown-config)
