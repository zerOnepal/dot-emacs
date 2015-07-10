;; now set our own packages
(setq
 my:el-get-packages
 '(el-get				; el-get is self-hosting
   switch-window			; takes over C-x o
   auto-complete			; complete as you type with overlays
   yasnippet 				; powerful snippet mode
   emmet-mode                           ; zencode + others
   ;;color-theme		                ; nice looking emacs
   color-theme-solarized	        ; check out color-theme-solarize
   ;; color-theme-zenburn		        ; check out color-theme-zenburn
   evil					; vi mode
;;   helm					; powerful completion and selection narrowing framework
   minimap				; sublimetext-style minimap sidebar
   neotree				; emacs tree plugin like NERD tree
   highlight-symbol			; highlight the same symbols in code, navigate in them, or replace string
   tabbar-ruler				;
   highlight-indentation		; hightlight the indentations
   highlight-parentheses		; hightlight the parantheses
   multiple-cursors			; use multiple cursors to type
   web-mode				; smart html library supporting template engines
   ;; powerline				; emacs-powerline
   git-gutter                           ;highlight git changes
   projectile                           ;project interaction library
   smooth-scroll  ; smooth scroll

   ;; python special packages

   ;; ruby special package
   emacs-rails-reloaded			; rails plugin for emacs
   flymake-ruby
   rvm
   inf-ruby
   projectile-rails
   robe-mode
   flymake-easy				; required for flymake-css
   flymake-css				; for css validation
   flymake-sass
   flymake-coffee
   flymake-haml
   flymake-html-validator
   haml-mode
   yaml-mode
   slim-mode
   sass-mode
   coffee-mode

   ;; java + android special packages
))

;;
;; Some recipes require extra tools to be installed
;;
;; Note: el-get-install requires git, so we know we have at least that.
;;

(setq my:el-get-packages
      (append
       my:el-get-packages
       (loop for src in el-get-sources collect (el-get-source-name src))))

;; install new packages and init already installed packages
(el-get 'sync my:el-get-packages)
