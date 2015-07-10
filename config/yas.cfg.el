(add-to-list 'load-path "~/.emacs.d/el-get/yasnippet/yasnippet.el")
(require 'yasnippet)

(setq yas-snippet-dirs
      '("~/.emacs.d/snippets"                 ;; personal snippets
        ))
(yas-global-mode 1)
