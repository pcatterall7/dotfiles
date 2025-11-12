(set-frame-font "Fira Mono-15" nil t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
     "4594d6b9753691142f02e67b8eb0fda7d12f6cc9f1299a49b819312d6addad1d"
     "f4bef5a6d77ac9c9ab34382f380aba922dd91901d0d43886a5f99106041bb8e0"
     default))
 '(package-selected-packages '(doom-themes markdown-mode org-appear)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; rebind en and em-dashes
(global-set-key (kbd "M-_") (lambda () (interactive) (insert "—")))
(global-set-key (kbd "M--") (lambda () (interactive) (insert "–")))

;; UI STUFF

;; default to visual line wrapping at word boundaries
(global-visual-line-mode 1)

;; ORG

;; disable having to confirm every code eval in org
(setq org-confirm-babel-evaluate nil)
;; hide emphasis markers
(setq org-hide-emphasis-markers t)
;; Show hidden emphasis markers
(use-package org-appear
  :hook (org-mode . org-appear-mode))

;; KEYBINDINGS

(global-set-key (kbd "C-;") 'execute-extended-command)
(global-set-key (kbd "M-o") 'other-window)
;; Add Melpa to package list https://melpa.org/#/getting-started
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

;; THEMES

;; load themes
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
;; automatically adjust theme based on my mac's appearance
(defun adjust-light-dark-theme ()
  (let ((appearance (shell-command-to-string "defaults read -g AppleInterfaceStyle")))
    (if (string-match-p "Dark" appearance)
	(load-theme 'doom-tokyo-night t)
      (load-theme 'doom-tomorrow-day t))))

(adjust-light-dark-theme)
(defalias 'theme-sync 'adjust-light-dark-theme)

;; https://github.com/doomemacs/themes
(use-package doom-themes
  :ensure t
  :custom
  ;; Global settings (defaults)
  (doom-themes-enable-bold t)   ; if nil, bold is universally disabled
  (doom-themes-enable-italic t) ; if nil, italics is universally disabled
  ;; for treemacs users
  (doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
  :config
  (adjust-light-dark-theme)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (nerd-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))
