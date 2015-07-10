(load "~/.emacs.d/plugins-core/chruby.el")
;; chruby
;; (unless (require 'chruby nil t)
;;  (download-get "https://raw.githubusercontent.com/plexus/chruby.el/master/chruby.el")) ;;(require 'chruby))

;; Usage
(require 'chruby)
(chruby "ruby-2.1.4")
