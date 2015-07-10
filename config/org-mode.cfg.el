;;======================================================================
;; ORG-MODE

(add-hook 'org-mode-hook 'turn-on-auto-fill)
;; (add-to-list 'load-path "/usr/share/emacs/25.0.50/lisp/")
(require 'org-mouse)

;; TODO: org -mode image zoom
;; (setq org-image-actual-width 800)

(add-hook 'org-mode-hook
          '(lambda ()
             (setq org-file-apps
                   '((auto-mode . emacs)
                     ("\\.jpg\\'" . "eog %s")
                     ("\\.png\\'" . "eog %s")
                     ("\\.mkv\\'" . "vlc %s")
                     ("\\.mp4\\'" . "vlc %s")
                     ("\\.pdf\\'" . "evince %s")))))

;; removing the C-j bind for goto-last-change, of el-get
(add-hook 'org-mode-hook
          '(lambda ()
             (define-key org-mode-map (kbd "C-j") nil)))

;;----------------------------------------------------------------------
;; Sort list by checkbox type
;; http://orgmode.org/worg/org-hacks.html

(defun org-sort-list-by-checkbox-type ()
  "Sort list items according to Checkbox state."
  (interactive)
  (org-sort-list
   nil ?f
   (lambda ()
     (if (looking-at org-list-full-item-re)
         (cdr (assoc (match-string 3)
                     '(("[X]" . 1) ("[-]" . 2) ("[ ]" . 3) (nil . 4))))
       4))))

;;----------------------------------------------------------------------
;; org put checkbox if previous is checkbox

(defun org-i-need-checkbox ()
  (interactive)
  (previous-line)
  (setq previous_line
        (buffer-substring
         (line-beginning-position) (line-end-position)))
  (next-line)
  (when (string-match "- \\[" previous_line)
    (insert "[ ] "))
  (insert "haoeush")
  )

;; (add-hook 'org-meta-return 'org-i-need-checkbox)


;;----------------------------------------------------------------------
;; Add dot after headline
;; https://yoo2080.wordpress.com/2013/08/24/changing-the-number-format-for-section-headings-in-org-mode-html-export/
(defun my-html-filter-headline-yesdot (text backend info)
  "Ensure dots in headlines."
  (when (org-export-derived-backend-p backend 'html)
    (save-match-data
      (when (let ((case-fold-search t))
              (string-match (rx (group "<span class=\"section-number-" (+ (char digit)) "\">"
                                       (+ (char digit ".")))
                                (group "</span>"))
                            text))
        (replace-match "\\1.\\2"
                       t nil text)))))

(eval-after-load 'ox
  '(progn
     (add-to-list 'org-export-filter-headline-functions
                  'my-html-filter-headline-yesdot)))

;; (add-to-list 'load-path "~/.emacs.d/el-get/00testing/org-mode/contrib/lisp")
;; (load-file "~/.emacs.d/00testing/org-mode/contrib/lisp/org-export.el")
;; (load-file "/home/rho/.emacs.d/00testing/org-mode/contrib/lisp/org-export-generic.el")
;; (load-file "~/.emacs.d/00testing/org-mode/contrib/lisp/org-e-man.el")
;; (org-install)
;; (require 'org-export)
;; (require 'org-e-man)

;; org-capture
(setq org-capture-templates
      (quote (("t" "todo" entry (file (concat org-directory "/todos.org"))
               "* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t)
              ("n" "note" entry (file (concat org-directory "/notes.org"))
               "* %? :NOTE:\n%U\n%a\n" :clock-in t :clock-resume t)
              ("j" "Journal" entry (file+datetree (concat org-directory "/diary.org"))
               "* %?\n%U\n" :clock-in t :clock-resume t)
			  ("y" "youtube-me" entry (file (concat org-directory "/youtube-dl.org"))  "* %?")
			  ("c" "CloudFactory" entry (file+datetree (concat org-directory "/cloudfactory.org"))
			   "* %?\n%U\n" :clock-in t :clock-resume t)
			  ("d" "CloudFactory Docs " entry (file (concat org-directory "/cloudfactory-docs.org"))
			   "* %?")
			  ("p" "Hisab Kitab " entry (file (concat org-directory "/Hisab-kitab.org"))
			   "* %?")
			  ("g" "awesome tools " entry (file (concat org-directory "/awesome_tools.org"))
			   "* %?")
              )))
