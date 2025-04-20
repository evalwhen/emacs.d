
(setq howm-directory "~/Documents/Howm")
(setq howm-home-directory howm-directory)

;; 使用 md 的意图是，之后可以迁移笔记到其他 markdown 平台
(setq howm-file-name-format "%Y/%m/%Y-%m-%d-%H%M%S.org")

(require 'howm)
(provide 'note-config)
