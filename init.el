(require 'package)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" .
                                 "https://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)
(package-initialize)

;; Find executables
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

;; ### AUTO-GENERATED -- DO NOT HAND ALTER ###
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(custom-enabled-themes (quote (wombat)))
 '(display-time-mode nil)
 '(indicate-buffer-boundaries (quote ((top . left) (bottom . right))))
 '(indicate-empty-lines t)
 '(inhibit-startup-screen t)
 '(org-agenda-files
   (quote
    ("~/Nextcloud/orgs/designops_tea.org" "~/Nextcloud/orgs/ops.org" "~/Nextcloud/orgs/ux_summit-2019_Q1.org" "~/Nextcloud/orgs/reading_list.org" "~/Nextcloud/orgs/inbox.org" "~/Nextcloud/orgs/design_club.org" "~/Nextcloud/orgs/coffee_talk.org" "~/Nextcloud/orgs/brian_1on1.org" "~/Nextcloud/orgs/framerx.org" "~/Nextcloud/orgs/savi.org" "~/Nextcloud/orgs/cdl.org" "~/Nextcloud/orgs/designops_tea-2019-04.org" "~/Nextcloud/orgs/it.org" "~/Nextcloud/orgs/goals_2019.org" "~/Nextcloud/orgs/aaron_1on1.org" "~/Nextcloud/orgs/work.org" "~/Nextcloud/orgs/home.org" "~/Nextcloud/orgs/ministry.org")))
 '(package-selected-packages
   (quote
    (evil-org evil-mu4e evil-magit magit evil-collection evil-tutor evil-matchit sentence-navigation evil-surround web-mode exec-path-from-shell flycheck markdown-mode quelpa-use-package use-package evil)))
 '(save-place t)
 '(scroll-bar-mode nil)
 '(sentence-end-double-space nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(visible-bell t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;; End ### AUTO-GENERATED -- DO NOT HAND ALTER ###

;; Vim emulation, please
(setq evil-shift-width 2)
(setq evil-find-skip-newlines t)
(use-package evil
  :init
  (setq evil-want-keybinding nil) ;;Necessary for using evil-collection
  :config (evil-mode 1))
(require 'evil)
;; Evil search mode
(setq evil-magic 'very-magic)
(evil-select-search-module 'evil-search-module 'evil-search)
;; Evil collection for widespread evil
(use-package evil-collection
  :ensure t
  :after evil
  :init (evil-collection-init))

;; mu4e for email
(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu/mu4e")
(require 'mu4e)
(setq mu4e-mu-binary "/usr/local/bin/mu")


;; check code syntax
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

;; Turn off button bar in GUI Emacs
(tool-bar-mode -1)

;; Spaces, not tabs
(setq indent-tabs-mode nil)

;; Show line numbers for vim `{ line number } G` convenience
(when (version<= "26.0.50" emacs-version )
  (global-display-line-numbers-mode))

;; Set base font
(add-to-list 'default-frame-alist
                       '(font . "Input Mono-18"))
;; Force UTF-8
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

;; Org mode settings ;;
; file locations and todo keywords
(setq org-directory "~/Nextcloud/orgs/")
(setq org-default-notes-file (concat org-directory "/inbox.org"))
(setq org-todo-keywords
      '((sequence "TODO(t)" "NEXT(n)" "WAITING(w)" "|"
		  "DONE(d)" "DELEGATED(l)" "CANCELLED(c)")))
; refile targets
(setq org-refile-targets '(
			   (nil :maxlevel . 2)
			   (org-agenda-files :maxlevel . 2)
			   ))
(setq org-export-with-toc nil)
; org keys
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)

; Capture templates
(setq org-capture-templates
      (quote (("t" "todo" entry (file org-default-notes-file)
	       "* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t)
	      ("n" "note" entry (file org-default-notes-file)
	       "* %? :NOTE:\n%U\n%a\n" :clock-in t :clock-resume t)
	      ("m" "Meeting" entry (file org-default-notes-file)
               "* MEETING with %? :MEETING:\n%U" :clock-in t :clock-resume t)
              ("p" "Phone call" entry (file org-default-notes-file)
               "* PHONE %? :PHONE:\n%U" :clock-in t :clock-resume t)
              ;; For Slack and Email captures copy url to item first
              ("s" "Slack" entry (file org-default-notes-file)
               "* SLACK %? :SLACK:\n%c\n%U" :clock-in t :clock-resume t)
              ("e" "Email" entry (file org-default-notes-file)
               "* EMAIL %? :EMAIL:\n%c\n%U" :clock-in t :clock-resume t)
              ;; Make sure you've got that link in the clipboard
              ("l" "link" entry (file org-default-notes-file)
               "* TODO Review %c\n%U\n" :immediate-finish t)
              ;("r" "respond" entry (file org-default-notes-file)
	      ; "* NEXT Respond to %:from on %:subject\nSCHEDULED: %t\n%U\n%a\n" :clock-in t :clock-resume t)
              ;; Can't get :from or :subject from Gmail
	      )))
; Export formats from Org mode
(require 'ox-md) ;; Markdown
;; Evil Org mode
(use-package evil-org
  :ensure t
  :after org
  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook
            (lambda ()
              (evil-org-set-key-theme)))
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))
;; Org mode hooks
(add-hook 'org-mode-hook 'turn-on-auto-fill)
;(add-hook 'org-mode-hook 'visual-line-mode)
(add-hook 'org-mode-hook 'flyspell-mode)
(add-hook 'org-mode-hook (lambda ()
			   (make-local-variable 'evil-auto-indent)
			   (setq evil-auto-indent nil)))
;; Markdown mode hooks
;(add-hook 'markdown-mode-hook 'turn-on-auto-fill)
(add-hook 'markdown-mode-hook 'visual-line-mode)
(add-hook 'markdown-mode-hook 'flyspell-mode)

;; Magit keys
(use-package magit
  :config
  (global-set-key (kbd "C-c g") 'magit-status))

;; optional: this is the evil state that evil-magit will use
;; (setq evil-magit-state 'normal)
;; optional: disable additional bindings for yanking text
;; (setq evil-magit-use-y-for-yank nil)
(require 'evil-magit)

;; Place backup files in a backup folder
(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
  backup-by-copying t    ; Don't delink hardlinks
  version-control t      ; Use version numbers on backups
  delete-old-versions t  ; Automatically delete excess backups
  kept-new-versions 20   ; how many of the newest versions to keep
  kept-old-versions 5    ; and how many of the old
  )
(setq markdown-command "/usr/local/bin/pandoc")
