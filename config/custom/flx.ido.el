(add-to-list 'load-path "~/.emacs.d/plug-ins")
;; replace default ido with flx-ido
(unless (require 'flx-ido nil t)
  (download-get "https://raw.githubusercontent.com/lewang/flx/master/flx.el")
  (download-get "https://raw.githubusercontent.com/lewang/flx/master/flx-ido.el")
  (require 'flx-ido))
(flx-ido-mode 1)
