;;; init.el --- Emacs initialization file
;;; Commentary:
;; This file bootstraps the literate configuration from configuration.org

;;; Code:

;; Load the literate configuration
(org-babel-load-file
 (expand-file-name "configuration.org" user-emacs-directory))

(provide 'init)
;;; init.el ends here
