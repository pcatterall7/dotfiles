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
 '(package-selected-packages
   '(doom-themes markdown-mode org-appear
     evil evil-collection which-key
     vertico orderless marginalia consult general)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; ========================================
;; PACKAGE SETUP
;; ========================================

;; Add Melpa to package list https://melpa.org/#/getting-started
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Ensure use-package is installed
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; ========================================
;; EVIL MODE (Vim Keybindings)
;; ========================================

;; Evil mode provides vim keybindings in Emacs
(use-package evil
  :ensure t
  :init
  ;; These settings must be set before evil loads
  (setq evil-want-integration t)        ; Enable evil integration with other packages
  (setq evil-want-keybinding nil)       ; Let evil-collection handle keybindings
  (setq evil-undo-system 'undo-redo)    ; Use Emacs 28+ undo system
  (setq evil-want-C-u-scroll t)         ; Ctrl-u scrolls up (vim behavior)
  :config
  (evil-mode 1))

;; Evil-collection provides evil keybindings for many Emacs modes
(use-package evil-collection
  :ensure t
  :after evil
  :config
  (evil-collection-init))

;; ========================================
;; WHICH-KEY (Command Discovery)
;; ========================================

;; Which-key shows available keybindings in a popup
(use-package which-key
  :ensure t
  :init
  (setq which-key-idle-delay 0.2)       ; Show popup after 0.2 seconds
  (setq which-key-popup-type 'minibuffer) ; Show in minibuffer
  :config
  (which-key-mode 1))

;; ========================================
;; COMPLETION SYSTEM (Vertico + Friends)
;; ========================================

;; Vertico provides a vertical completion UI
(use-package vertico
  :ensure t
  :init
  (vertico-mode 1)
  :config
  ;; Cycle through completion options
  (setq vertico-cycle t))

;; Orderless allows flexible/fuzzy matching (space-separated terms)
(use-package orderless
  :ensure t
  :custom
  ;; Configure completion styles
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion)))))

;; Marginalia adds helpful annotations to completion candidates
(use-package marginalia
  :ensure t
  :init
  (marginalia-mode 1))

;; Consult provides enhanced versions of common commands
(use-package consult
  :ensure t
  :bind (;; Replace default commands with consult versions
         ("C-x b" . consult-buffer)     ; Better buffer switching
         ("C-x 4 b" . consult-buffer-other-window)
         ("M-y" . consult-yank-pop)))   ; Better yank (paste) history

;; ========================================
;; LEADER KEY SETUP (Space as Leader)
;; ========================================

;; General provides easy leader key configuration
(use-package general
  :ensure t
  :config
  ;; Set Space as the global leader key
  (general-create-definer my-leader-def
    :states '(normal visual emacs)
    :keymaps 'override
    :prefix "SPC")

  ;; Define leader key bindings
  (my-leader-def
    ;; File operations
    "f" '(:ignore t :which-key "files")
    "ff" '(find-file :which-key "find file")
    "fr" '(consult-recent-file :which-key "recent files")
    "fs" '(save-buffer :which-key "save file")
    "fS" '(write-file :which-key "save as")

    ;; Buffer operations
    "b" '(:ignore t :which-key "buffers")
    "bb" '(consult-buffer :which-key "switch buffer")
    "bd" '(kill-current-buffer :which-key "kill buffer")
    "bn" '(next-buffer :which-key "next buffer")
    "bp" '(previous-buffer :which-key "previous buffer")

    ;; Window operations
    "w" '(:ignore t :which-key "windows")
    "ww" '(other-window :which-key "other window")
    "wd" '(delete-window :which-key "delete window")
    "ws" '(split-window-below :which-key "split horizontal")
    "wv" '(split-window-right :which-key "split vertical")

    ;; Search operations
    "s" '(:ignore t :which-key "search")
    "ss" '(consult-line :which-key "search line")
    "sg" '(consult-grep :which-key "grep")

    ;; Org mode
    "o" '(:ignore t :which-key "org")
    "oo" '(org-goto :which-key "go to")
    "on" '(org-narrow-to-subtree :which-key "narrow to subtree")
    "ow" '(widen :which-key "widen")

    ;; Utility
    "SPC" '(execute-extended-command :which-key "M-x")
    "q" '(:ignore t :which-key "quit")
    "qq" '(save-buffers-kill-terminal :which-key "quit emacs")
    "h" '(:ignore t :which-key "help")
    "hf" '(describe-function :which-key "describe function")
    "hv" '(describe-variable :which-key "describe variable")
    "hk" '(describe-key :which-key "describe key")))

;; ============================
;; THEMES
;; ============================

;; load themes
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
;; automatically adjust theme based on my mac's appearance
(defun adjust-light-dark-theme ()
  (let ((appearance (shell-command-to-string "defaults read -g AppleInterfaceStyle")))
    (if (string-match-p "Dark" appearance)
	(load-theme 'doom-tokyo-night t)
      (load-theme 'doom-tomorrow-day t))))

;; Create alias for easy theme syncing (call with M-x theme-sync)
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


;; rebind en and em-dashes
(global-set-key (kbd "M-_") (lambda () (interactive) (insert "—")))
(global-set-key (kbd "M--") (lambda () (interactive) (insert "–")))

;; ===========================
;; UI STUFF
;; =========================== 

;; default to visual line wrapping at word boundaries
(global-visual-line-mode 1)

;; ===========================
;; ORG
;; ===========================

;; disable having to confirm every code eval in org
(setq org-confirm-babel-evaluate nil)
;; hide emphasis markers
(setq org-hide-emphasis-markers t)
;; Show hidden emphasis markers
(use-package org-appear
  :hook (org-mode . org-appear-mode))
