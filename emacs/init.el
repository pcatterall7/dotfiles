(set-frame-font "Fira Mono-15" nil t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("f4bef5a6d77ac9c9ab34382f380aba922dd91901d0d43886a5f99106041bb8e0"
     default))
 '(package-selected-packages '(markdown-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; rebind en and em-dashes
(global-set-key (kbd "M-_") (lambda () (interactive) (insert "—")))
(global-set-key (kbd "M--") (lambda () (interactive) (insert "–")))

;; default to visual line wrapping at word boundaries
(global-visual-line-mode 1)

;; load themes
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
;; automatically adjust theme based on my mac's appearance
(defun adjust-light-dark-theme ()
  (let ((appearance (shell-command-to-string "defaults read -g AppleInterfaceStyle")))
    (if (string-match-p "Dark" appearance)
	(load-theme 'zenburn t)
      (load-theme 'adwaita t))))

(adjust-light-dark-theme)
(defalias 'theme-sync 'adjust-light-dark-theme)

;; KEYBINDINGS

(global-set-key (kbd "C-;") 'execute-extended-command)
