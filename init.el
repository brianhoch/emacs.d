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
 '(global-display-line-numbers-mode t)
 '(org-agenda-files
   (quote
    ("~/Documents/orgs/work.org" "~/Documents/orgs/ministry.org")))
 '(package-selected-packages
   (quote
    (magit evil-matchit sentence-navigation evil-surround web-mode exec-path-from-shell flycheck markdown-mode org-make-toc quelpa-use-package use-package evil)))
 '(save-place t)
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
(require 'evil)
(evil-mode 1)

;; check code syntax
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

;; Turn off button bar in GUI Emacs
(tool-bar-mode -1)

;; Show line numbers for vim `{ line number } G` convenience
(when (version<= "26.0.50" emacs-version )
  (global-display-line-numbers-mode))

;; Export formats from Org mode
(require 'ox-md) ;; Markdown

;; Set base font
(add-to-list 'default-frame-alist
                       '(font . "Input Mono-16"))
;; Force UTF-8
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

;; Remap org-mode meta keys for convenience
(mapcar (lambda (state)
    (evil-declare-key state org-mode-map
      (kbd "M-l") 'org-metaright
      (kbd "M-h") 'org-metaleft
      (kbd "M-k") 'org-metaup
      (kbd "M-j") 'org-metadown
      (kbd "M-L") 'org-shiftmetaright
      (kbd "M-H") 'org-shiftmetaleft
      (kbd "M-K") 'org-shiftmetaup
      (kbd "M-J") 'org-shiftmetadown))
  '(normal insert))

;; Magit keys
(use-package magit
  :config
  (global-set-key (kbd "C-c g") 'magit-status))
