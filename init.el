;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

(package-initialize)

;;======================================================================
;; emacs config file for 25.0
;; fork of github:rhoit/dot-emacs

(setq user-full-name    "Milan"
      user-mail-address "oemilan@gmail.com")

;;======================================================================

(set-language-environment "UTF-8")

(require 'server)
(unless (server-running-p)
  (server-start))

(column-number-mode 1) ; show column no in modline

;; highlight entire bracket expression
(setq show-paren-style 'expression)
(show-paren-mode 1)

;; backup configuration
(setq backup-directory-alist (quote ((".*" . "~/.cache/emacs_backup/"))))
(setq make-backup-files nil)

;; switch-window configurations
(global-set-key (kbd "C-x o") 'switch-window)


;; switching window buffers
(global-set-key [s-left] 'windmove-left)
(global-set-key [s-right] 'windmove-right)
(global-set-key [s-up] 'windmove-up)
(global-set-key [s-down] 'windmove-down)

;; (setq auto-save-default nil)
(delete-selection-mode 1)

(setq browse-url-browser-function 'browse-url-firefox)
(recentf-mode 0) ;; no recent files

;; debug on C-g; to point broken modules
;; (setq debug-on-quit t)

;; avoid typing complete 'yes' and 'no
(fset 'yes-or-no-p 'y-or-n-p)
;;(defalias 'yes-or-no-p 'y-or-n-p)

;; mode set
(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)

;;----------------------------------------------------------------------
;; watch-words
(defun watch-words ()
  (interactive)
  (font-lock-add-keywords
   nil '(("\\<\\(FIX ?-?\\(ME\\)?\\|TODO\\|BUGS?\\|TIPS?\\|TESTING\\|WARN\\(ING\\)?S?\\|WISH\\|IMP\\|NOTE\\)"
          1 font-lock-warning-face t))))

(add-hook 'prog-mode-hook 'watch-words)
(add-hook 'org-mode 'watch-words)

;;----------------------------------------------------------------------
;; clean up trailing whitespaces
(defun nuke_traling ()
  (add-hook 'write-file-hooks 'delete-trailing-whitespace)
  (add-hook 'before-save-hooks 'whitespace-cleanup))

(add-hook 'prog-mode-hook 'nuke_traling)

;;======================================================================
;; PROGRAMMING MODES

(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq-default py-indent-offset 2)
(add-hook 'prog-mode-hook 'which-function-mode)
(add-hook 'prog-mode-hook 'toggle-truncate-lines)

;;----------------------------------------------------------------------
;; CC-mode indentation
;; http://www.gnu.org/software/emacs/manual/html_mono/ccmode.html

(add-hook 'c-mode-common-hook '(lambda () (c-toggle-hungry-state 1)))
(require 'cc-mode)
(define-key c-mode-base-map (kbd "RET") 'newline-and-indent)

;;======================================================================
;; PLUGINS
(add-to-list 'load-path  "~/.emacs.d/plug-ins/")

;;----------------------------------------------------------------------
;; line-number
;; http://www.emacswiki.org/LineNumbers
;; http://elpa.gnu.org/packages/nlinum-1.1.el
;; (require 'nlinum)
;; (add-hook 'find-file-hook (lambda () (nlinum-mode 1)))

;;----------------------------------------------------------------------
;; hideshowvis mode
;; http://www.emacswiki.org/emacs/download/hideshowvis.el
(autoload 'hideshowvis-enable "hideshowvis" "Highlight foldable regions")
(autoload 'hideshowvis-minor-mode
  "hideshowvis"
  "Will indicate regions foldable with hideshow in the fringe."
  'interactive)

(add-hook 'python-mode-hook 'hideshowvis-enable)
;; (dolist (hook (list 'emacs-lisp-mode-hook
;;                     'c++-mode-hook
;; 					'python-mode-hook
;; 					)
;; 			  )
;;   (add-hook hook 'hideshowvis-enable))
;; (add-hook 'hideshowvis-minor-mode-hook 'hideshowvis-symbols)

;;======================================================================
;; SUB-MODULES PLUGINS

;;----------------------------------------------------------------------
;; Arch pkgbuild-mode
(add-to-list 'load-path "~/.emacs.d/repo/pkgbuild-mode")
(autoload 'pkgbuild-mode "pkgbuild-mode.el" "PKGBUILD mode." t)
(setq auto-mode-alist
      (append '(("/PKGBUILD.*" . pkgbuild-mode)) auto-mode-alist))

;;----------------------------------------------------------------------
;; el-get
;; https://github.com/dimitri/el-get
(add-to-list 'load-path "~/.emacs.d/el-get")
(require 'el-get)
(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
(el-get 'sync)

;;----------------------------------------------------------------------
;; melpha: Milkypostman's Emacs Lisp Package Archieve
;; https://github.com/milkypostman/melpa
(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)

;; ;;======================================================================
;; ;; CONFIGS
(add-to-list 'load-path "~/.emacs.d/config/")
(load "babel.cfg.el")
(load "compile.cfg.el")
;; (load "currentline.cfg.el")
;; (load "el-get.cfg.el")
;; (load "etag.cfg.el")
(load "html.cfg.el")
(load "ido.cfg.el")
(load "org-mode.cfg.el")
(load "py-exec.cfg.el")
(load "python.cfg.el")
(load "ui.cfg.el")
(load "wordplay.el")
(load "yas.cfg.el")


;;======================================================================
;; CUSTOM CONFIGS
;;----------------------------------------------------------------------
(add-to-list 'load-path "~/.emacs.d/config/custom/")

(load-library "projectile.cfg")
(load-library "powerline.cfg")
(load-library "beauty.cfg.el")

;; add ruby-rails config
(load "ruby-rails.cfg.el")
(load "flx.ido.el")
(load "chruby.cfg.el")

;;======================================================================
;; BROKEN PLUGINS
;;----------------------------------------------------------------------
;; sed-mode
;; https://github.com/emacsfodder/sed-mode.git
;; (add-to-list 'load-path "~/.emacs.d/sed-mode")
;; (autoload 'sed-mode "sed-mode.el" "PKGBUILD mode." t)
;; (setq auto-mode-alist
;;       (append '((".sed$" . sed-mode)) auto-mode-alist))

;;======================================================================
;; TESTING PLUGINS

;;----------------------------------------------------------------------
;; indent-hint
;; (load "~/.emacs.d/plug-ins/indent-hint.el")
;; (indent-hint t)

;;----------------------------------------------------------------------
;; highlight indentation
;; other color: "#aaeeba"
;; ver1
;; (load "~/.emacs.d/00testing/hdent-antonj/highlight-indentation.el")
;; (add-hook 'prog-mode-hook 'highlight-indentation-mode)
;; ver2
;; (add-to-list 'load-path "~/.emacs.d/00testing/hdent-mgalgs/")
;; (require 'indent-hints)
;; (indent-hints-global-mode)

;;----------------------------------------------------------------------
;; isend-mode
;; (add-to-list 'load-path "~/.emacs.d/00testing/isend-mode/")
;; (require 'isend)

;;----------------------------------------------------------------------
;; auto-dim-buffer
;; (when window-system
;;   (add-to-list 'load-path "~/.emacs.d/00testing/auto-dim-other-buffers.el")
;;   (require 'auto-dim-other-buffers)
;;   (add-hook 'after-init-hook (lambda ()
;;                                (when (fboundp 'auto-dim-other-buffers-mode)
;;                                  (auto-dim-other-buffers-mode t)))))

;;----------------------------------------------------------------------
;; ansi-color sequence for complitaion mode
;; (add-to-list 'load-path "~/.emacs.d/00testing/colors")
;; (require 'ansi-color)
;; (defun colorize-compilation-buffer ()
;;   (toggle-read-only)
;;   (ansi-color-apply-on-region (point-min) (point-max))
;;   (toggle-read-only))
;; (add-hook 'compilation-filter-hook 'colorize-compilation-buffer)

;;----------------------------------------------------------------------
;; smart-cursor-color-mode
;; (add-to-list 'load-path "~/.emacs.d/smart-cursor-color-mode")
;; (require 'smart-cursor-color-mode)
;; (setq smart-cursor-color-mode t)

;;----------------------------------------------------------------------
;; LFG mode
;; (setq xle-buffer-process-coding-system 'utf-8)
;; (load-library "/opt/xle/emacs/lfg-mode")


;;======================================================================
;; EMACS AUTO GEN-STUFFS

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(android-mode-sdk-dir "/opt/android")
 '(coffee-tab-width 2)
 '(custom-safe-themes
   (quote
    ("74278d14b7d5cf691c4d846a4bbf6e62d32104986f104c1e61f718f9669ec04b" "d7088a7105aa09cc68e3d058f89917e07e0505e0f4ab522a6045ec8092d67c44" "87bee8dd980504d41c043e83c24abbbdb780ce5afb9c312f6915ed0aad2630ee" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" default)))
 '(el-get-git-shallow-clone t)
 '(grep-command "grep --color -nH -r -e ")
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
    (minimap inflections rainbow-mode ansible-doc ansible)))
 '(safe-local-variable-values (quote ((eval server-force-delete))))
 '(web-mode-code-indent-offset 2)
 '(web-mode-css-indent-offset 2)
 '(web-mode-markup-indent-offset 2))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#242424" :foreground "#f6f3e8" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 145 :width normal :foundry "unknown" :family "DejaVu Sans Mono"))))
 '(font-lock-comment-face ((t (:slant oblique))))
 '(font-lock-function-name-face ((t (:foreground "#cae682" :slant oblique :weight bold))))
 '(font-lock-keyword-face ((t (:foreground "cyan" :weight bold))))
 '(font-lock-string-face ((t (:foreground "gold2" :weight semi-light :family "Source Code Pro"))))
 '(font-lock-variable-name-face ((t (:foreground "sandy brown"))))
 '(font-lock-warning-face ((t (:background "yellow1" :foreground "red1" :weight bold))))
 '(highlight-indentation-face ((t (:background "olive drab"))))
 '(linum ((t (:inherit (shadow default) :height 108))))
 '(markdown-header-delimiter-face ((t (:inherit font-lock-function-name-face :weight bold))) t)
 '(markdown-header-face-1 ((t (:height 1.8))) t)
 '(markdown-header-face-2 ((t (:height 1.6))) t)
 '(markdown-header-face-3 ((t (:height 1.4))) t)
 '(markdown-header-face-4 ((t (:height 1.2))) t)
 '(markdown-header-face-5 ((t (:height 1.1 :weight bold))) t)
 '(markdown-header-face-6 ((t (:weight bold))) t)
 '(mode-line ((t (:foreground "#030303" :background "#bdbdbd" :box nil))))
 '(mode-line-inactive ((t (:foreground "#f9f9f9" :background "#666666" :box nil))))
 '(show-paren-match ((t (:inverse-video t))))
 '(which-func ((t (:inherit mode-line)))))

;;------------------------------------------------
;; Shalil Function
;; For downloading sublimity
;;-----------------------------------------------------------
(defun download-get(url)
  (let ((download-buffer (url-retrieve-synchronously url)))
    (save-excursion
      (set-buffer download-buffer)
      ;; we may have to trim the http response
      (goto-char (point-min))
      (re-search-forward "^$" nil 'move)
      (forward-char)
      (delete-region (point-min) (point))
      (write-file (concat "~/.emacs.d/plug-ins/"
			      (car (last (split-string url "/" t)))))
      (kill-buffer download-buffer)))
  (byte-recompile-directory (expand-file-name "~/.emacs.d/plug-ins") 0))

(add-to-list 'load-path "~/.emacs.d/plug-ins")

(add-to-list 'load-path "~/.emacs.d/config/misc")
(load "make-dir-default.cfg.el")
(add-to-list 'find-file-not-found-functions 'my-create-non-existent-directory)
