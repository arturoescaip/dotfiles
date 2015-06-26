; Add .emacs.d to load path
(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "~/.emacs.d/my")

(setq mac-command-modifier 'meta)

(cd "~")
(defun last-shell-buffer ()
  (interactive)
  (let ((bl (buffer-list))
        found)
    (while bl
      (if (string-match "\*shell\*" (buffer-name (car bl)))
          (progn
            (setq found t)
            (switch-to-buffer (car bl))
            (setq bl nil))
        (setq bl (cdr bl))))
    (unless found (shell))))

(global-set-key (kbd "C-\\") 'last-shell-buffer)

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)
(global-set-key (kbd "M-]") 'er/expand-region)

(require 'deft)
(setq deft-extension "org")
(setq deft-text-mode 'org-mode)
(setq deft-directory "~/Dropbox/notes")

(setq inhibit-startup-message t)
(setq source-directory "~/tmp/emacs/emacs-24.3/src/")

;; haskell
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
;; (add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)

(eval-after-load "haskell-mode"
  '(progn
     (define-key haskell-mode-map (kbd "C-,") 'haskell-move-nested-left)
     (define-key haskell-mode-map (kbd "C-.") 'haskell-move-nested-right)))

;; show-paren
 (show-paren-mode 1)

(when (display-graphic-p)
  (load-theme 'misterioso))

; Fix shift up
(define-key input-decode-map "\e[1;10A" [M-S-up])
(define-key input-decode-map "\e[1;10B" [M-S-down])
(define-key input-decode-map "\e[1;10C" [M-S-right])
(define-key input-decode-map "\e[1;10D" [M-S-left])

(define-key input-decode-map "\e[1;9A" [M-up])
(define-key input-decode-map "\e[1;9B" [M-down])
(define-key input-decode-map "\e[1;9C" [M-right])
(define-key input-decode-map "\e[1;9D" [M-left])

(defun my-etags-elect-init ()
  (add-hook 'etags-select-mode-hook
            (lambda () (local-set-key (kbd "RET")
                                      'etags-select-goto-tag))))
(add-hook 'after-init-hook 'my-etags-elect-init)

(global-set-key (kbd "M-o") 'other-window)
(global-set-key (kbd "M-5") 'query-replace-regexp)

; paredit
(require 'paredit)
(dolist (hook '(clojure-mode-hook
                lisp-interaction-mode-hook
                emacs-lisp-mode-hook))
  (add-hook hook 'paredit-mode))

; Move through windows
(windmove-default-keybindings)

(setq column-number-mode t)
(menu-bar-mode -1)

(setq-default indent-tabs-mode nil) ; always replace tabs with spaces
(setq-default tab-width 3) ; set tab width to 4 for all buffers

(defun join-next-line (arg)
  (interactive "p")
  (message "Arg is %d" arg)
  (save-excursion
    (dotimes (i (abs arg))
      (when (> arg 0)
        (next-line))
      (join-line))))
(global-set-key (kbd "M-j") 'join-next-line)

;; Indent on newline
(define-key global-map (kbd "RET") 'newline-and-indent)

; Turn on which func mode
(which-func-mode 1)

; org-mode stuff
(defun org-summary-todo (n-done n-not-done)
  "Switch entry to DONE when all subentries are done, to TODO otherwise."
  (let (org-log-done org-log-states)   ; turn off logging
    (org-todo (if (= n-not-done 0) "DONE" "TODO"))))

(add-hook 'org-after-todo-statistics-hook 'org-summary-todo)

(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse

;; Disable these to use M-<digit> as prefix arg
;; (global-set-key "\e0" 'delete-window)
;; (global-set-key "\e1" 'delete-other-windows)
;; (global-set-key "\e2" 'split-window)
;; (global-set-key "\e3" 'split-window-horizontally)

;; CUA
;; (cua-mode t)
;; (setq cua-auto-tabify-rectangles nil) ;; Don't tabify after rectangle commands
;; (transient-mark-mode 1) ;; No region when it is not highlighted
;; (cua-selection-mode t) 

(setq transient-mark-mode t)
; (require 'smooth-scrolling)

;; Turn off beeping when scrolling past EOF
(defun my-bell-function ()
  (unless (memq this-command
    	'(isearch-abort abort-recursive-edit exit-minibuffer
              keyboard-quit mwheel-scroll down up next-line previous-line
              backward-char forward-char))
    (ding)))
(setq ring-bell-function 'my-bell-function)

;; Move through paragraphs
(global-set-key (kbd "M-n") 'forward-paragraph)
(global-set-key (kbd "M-p") 'backward-paragraph)

;; Calculator
(global-set-key (kbd "M-#") 'calc)

;; ido
(require 'ido)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;; helm
;;(helm-mode 1)

;; auto-complete
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d//ac-dict")
(ac-config-default)

;; linum.el
(require 'linum)
(global-linum-mode 1)
(setq linum-format "%3d ")
(setq linum-disabled-modes-list
      '(eshell-mode wl-summary-mode compilation-mode shell-mode))
(defun linum-on ()
  (unless (or (minibufferp) (member major-mode linum-disabled-modes-list))
    (linum-mode 1)))

;; etags-table
;; configure emacs to find local TAGS file automatically
(require 'etags-table)
(setq etags-table-search-up-depth 15)

;; org-mode
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(setq org-agenda-files '("~/Dropbox/notes/"
                         "~/org/"))
(setq org-clock-persist 'history)
(org-clock-persistence-insinuate)
(setq org-default-notes-file (concat org-directory "/notes.org"))
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/org/todo.org" "Tasks")
             "* TODO %?\n  %i\n  %a")))

;; Python subword mode
(add-hook 'python-mode-hook 
  (lambda ()
    (define-key python-mode-map (kbd "C-c C-w") 'subword-mode)))

;; Hide menu bar
(if (boundp 'tool-bar-mode)
    (tool-bar-mode 0))

(setq ispell-program-name "/usr/local/bin/ispell")

;; pdb
(setq pdb-path '/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/pdb.py
      gud-pdb-command-name (symbol-name pdb-path))
(defadvice pdb (before gud-query-cmdline activate)
  "Provide a better default command line when called interactively."
  (interactive
   (list (gud-query-cmdline pdb-path
                            (file-name-nondirectory buffer-file-name)))))

;; Display Navigable Structure of Classes/Functions
(defun occur-python-defs ()
  (interactive)
  (occur "^\\s-*\\(class\\|def\\)\\s-"))

(add-hook 'python-mode-hook 
          (lambda ()
            (local-set-key (kbd "C-c d") 'occur-python-defs)))

;; Python: add forward/backward paragraph and set indent to three
(add-hook 'python-mode-hook
          (lambda ()
            (local-set-key (kbd "M-n") 'forward-paragraph)
            (local-set-key (kbd "M-p") 'backward-paragraph)
            (setq python-indent 3)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("11d069fbfb0510e2b32a5787e26b762898c7e480364cbc0779fe841662e4cf5d" "bf7ed640479049f1d74319ed004a9821072c1d9331bc1147e01d22748c18ebdf" default)))
 '(global-reveal-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'narrow-to-region 'disabled nil)
