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
   '("3613617b9953c22fe46ef2b593a2e5bc79ef3cc88770602e7e569bbd71de113b"
     "87fa3605a6501f9b90d337ed4d832213155e3a2e36a512984f83e847102a42f4"
     "e1df746a4fa8ab920aafb96c39cd0ab0f1bac558eff34532f453bd32c687b9d6"
     "2f8af2a3a2fae6b6ea254e7aab6f3a8b5c936428b67869cef647c5f8e7985877"
     "f253a920e076213277eb4cbbdf3ef2062e018016018a941df6931b995c6ff6f6"
     "e4a702e262c3e3501dfe25091621fe12cd63c7845221687e36a79e17cf3a67e0"
     "1f8bd4db8280d5e7c5e6a12786685a7e0c6733b0e3cf99f839fb211236fb4529"
     "f053f92735d6d238461da8512b9c071a5ce3b9d972501f7a5e6682a90bf29725"
     "02d422e5b99f54bd4516d4157060b874d14552fe613ea7047c4a5cfa1288cf4f"
     "0f1341c0096825b1e5d8f2ed90996025a0d013a0978677956a9e61408fcd2c77"
     "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
     "4594d6b9753691142f02e67b8eb0fda7d12f6cc9f1299a49b819312d6addad1d"
     "f4bef5a6d77ac9c9ab34382f380aba922dd91901d0d43886a5f99106041bb8e0"
     default))
 '(package-selected-packages
   '(doom-themes markdown-mode org-appear evil evil-collection which-key
		 vertico orderless marginalia consult general)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
