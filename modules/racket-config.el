;;; racket-config.el ---                             -*- lexical-binding: t; -*-

;; Copyright (C) 2023  hujianfeng

;; Author: hujianfeng <melp@localhost>
;; Keywords: c, c, 

(require 'racket-xp)
(add-hook 'racket-mode-hook #'racket-xp-mode)

(provide 'racket-config)
