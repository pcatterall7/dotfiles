;;; init.el --- Emacs initialization file
;;; Commentary:
;; This file bootstraps the literate configuration from configuration.org

;;; Code:

;; Load the literate configuration
(org-babel-load-file
 (expand-file-name "configuration.org" user-emacs-directory))

(provide 'init)
;;; init.el ends here
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
   '(consult doom-themes evil evil-collection general gptel marginalia
	     markdown-mode orderless org-appear vertico which-key)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(link ((t (:weight normal))))
 '(org-level-1 ((t (:inherit outline-1 :weight bold))))
 '(org-level-2 ((t (:inherit outline-2 :weight bold))))
 '(org-level-3 ((t (:inherit outline-3 :weight normal))))
 '(org-level-4 ((t (:inherit outline-4 :weight normal))))
 '(org-level-5 ((t (:inherit outline-5 :weight normal))))
 '(org-level-6 ((t (:inherit outline-6 :weight normal))))
 '(org-level-7 ((t (:inherit outline-7 :weight normal))))
 '(org-level-8 ((t (:inherit outline-8 :weight normal)))))
