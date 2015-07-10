;; projectile kungufu
(require 'grizzl)
 (projectile-global-mode)
 (setq projectile-enable-caching t)
 (setq projectile-completion-system 'grizzl)
 ;; Press Command-p for fuzzy find in project
 (global-set-key (kbd "C-x f") 'projectile-find-file)
 ;; ;; Press Command-b for fuzzy switch buffer
 (global-set-key (kbd "C-x b") 'projectile-switch-to-buffer)


;; notree config
(require 'neotree)
(global-set-key [f12] 'neotree-toggle)
(setq neo-window-width 35)

;;When running ‘projectile-switch-project’ (C-c p p), ‘neotree’ will change root automatically.
;; (setq projectile-switch-project-action 'neotree-projectile-action)
