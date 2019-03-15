
(setq inhibit-splash-screen t)
(tool-bar-mode -1)
(global-linum-mode 1)
(setq column-number-mode t)
(setq ispell-program-name "/usr/local/bin/aspell")
(setq explicit-shell-file-name "/usr/local/bin/bash")
(show-paren-mode)

;; (require 'monokai-theme)
(require 'dracula-theme)

; Key bindings
(global-set-key (kbd "M-o") 'other-window)
(global-set-key (kbd "M-0") 'delete-window)
(global-set-key (kbd "M-1") 'delete-other-windows)
(global-set-key (kbd "M-3") 'split-window-right)
(global-set-key (kbd "M-2") 'split-window-below)

(setq mac-command-modifier 'control)
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

(require 'deft)
(setq deft-extensions '("org"))
(setq deft-directory "~/Dropbox/notes")
(setq deft-default-extension "org")
(setq deft-text-mode 'org-mode)
(setq deft-use-filename-as-title t)
(setq deft-use-filter-string-for-filename t)
(setq deft-auto-save-interval 0)
;;key to launch deft
(global-set-key (kbd "C-c d") 'deft)

;; ; Helm config 
;; (global-set-key (kbd "M-y") 'helm-show-kill-ring)
;; (define-key global-map [remap find-file] 'helm-find-files)
;; (define-key global-map [remap occur] 'helm-occur)
;; (define-key global-map [remap list-buffers] 'helm-buffers-list)
;; (define-key global-map [remap dabbrev-expand] 'helm-dabbrev)
;; (define-key global-map [remap execute-extended-command] 'helm-M-x)
;; (unless (boundp 'completion-in-region-function)
;;   (define-key lisp-interaction-mode-map [remap completion-at-point] 'helm-lisp-completion-at-point)
;;   (define-key emacs-lisp-mode-map       [remap completion-at-point] 'helm-lisp-completion-at-point))
(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") #'helm-find-files)
(helm-mode 1)
(require 'helm-config)

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/Dropbox/notes/tasks.org" "other")
         "* TODO %?\n%i\n")
      ("a" "Areview feedback" plain
       (file+function "~/Dropbox/notes/areview.org" areview-ask-location)
       "   - %?"
       :empty-lines 0)
      ))

(defun areview-current-period-string ()
  "Return Areview period for current month"
  (let* ((year (calendar-extract-year (calendar-current-date)))
         (month (calendar-extract-month (calendar-current-date))))
    (case month
      ((4 5 6 7 8 9) (format "%d-Apr-01 -- %d-Sept-30" year year))
      ((1 2 3) (format "%d-Oct-01 -- %d-Mar-31" (- year 1) year))
      ((10 11 12) (format "%d-Oct-01 -- %d-Mar-31" year (+ year 1))))))

(defun areview-ask-location ()
  "Ask location to insert an areview item"
  (goto-char (point-min))
  (let* ((areview-period (areview-current-period-string)))
    ;; find current areview period heading
    (unless (re-search-forward
             (format org-complex-heading-regexp-format (regexp-quote (areview-current-period-string)))
             nil t)
      (goto-char (point-min))
      (or (bolp) (insert "\n"))
      (insert "* " areview-period "\n")))
  (let* ((org-refile-targets '((nil :maxlevel . 9)))
         (hd (condition-case nil
                 (car (org-refile-get-location "Name" nil t))
               (error (car org-refile-history)))))
    (unless (re-search-forward
             (format org-complex-heading-regexp-format (regexp-quote hd))
             nil t)
      (insert "\n")
      (insert "** " hd "\n"))))

(setq org-directory "~/Dropbox/notes")
(setq org-mobile-directory "~/Dropbox/Apps/MobileOrg")
(setq org-mobile-inbox-for-pull "~/Dropbox/notes/inbox.org")
(setq org-agenda-files (list "~/Dropbox/notes"))
(define-key global-map "\C-ca" 'org-agenda)
(setq org-default-notes-file (concat org-directory "/notes.org"))
(define-key global-map "\C-cc" 'org-capture)
(setq org-log-done t)
(setq org-use-speed-commands t)
;; (setq org-refile-targets '((org-agenda-files :maxlevel . 3)))
(setq org-refile-targets '((nil :maxlevel . 9)
                           (org-agenda-files :maxlevel . 9)))
(setq org-outline-path-complete-in-steps nil)         ; Refile in a single go
(setq org-refile-use-outline-path t)  
(setq org-todo-keywords
      '((sequence "TODO" "REVIEW" "|" "DONE")))

(defun my/org-mode-hook ()
  "Stop the org-level headers from increasing in height relative to the other text."
  (dolist (face '(org-level-1
                  org-level-2
                  org-level-3
                  org-level-4
                  org-level-5))
    (set-face-attribute face nil :weight 'semi-bold :height 1.0)))

(add-hook 'org-mode-hook 'my/org-mode-hook)

(defun make-bug-links ()
   (interactive)
   (let ((case-fold-search t)
         (regex "bug\\([0-9]+\\)")
         (replace "[[http://bug/\\1][\\&]]"))
     (if mark-active
         (replace-regexp regex replace nil (region-beginning) (region-end))
       (replace-regexp regex replace)
       )
     ))

(defun unfill-paragraph (&optional region)
     "Takes a multi-line paragraph and makes it into a single line of text."
     (interactive (progn (barf-if-buffer-read-only) '(t)))
     (let ((fill-column (point-max))
           ;; This would override `fill-column' if it's an integer.
           (emacs-lisp-docstring-fill-column t))
       (fill-paragraph nil region)))

(defun my/edit-config ()
  (interactive)
  (find-file "~/.emacs.d/config.org"))
