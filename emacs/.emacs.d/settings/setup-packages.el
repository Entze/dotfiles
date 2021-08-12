(require 'gnutls)
(when (and (string= "26" (substring emacs-version 0 2))
           (null gnutls-algorithm-priority))
  ;; This appears to be a bug in emacs 26 that prevents the gnu archive from being downloaded.
  ;; This solution is from https://www.reddit.com/r/emacs/comments/cdf48c/failed_to_download_gnu_archive/
  (setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3"))

;; Bootstrap `use-package'
(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives
      '(("elpa" . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://stable.melpa.org/packages/")
        ("melpa-unstable" . "https://melpa.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")))


(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(defun package-menu-find-marks ()
  "Find packages marked for action in *Packages*."
  (interactive)
  (occur "^[A-Z]"))

;; Only in Emacs 25.1+
(defun package-menu-filter-by-status (status)
  "Filter the *Packages* buffer by STATUS."
  (interactive
   (list (completing-read
          "Status: " '("new" "installed" "dependency" "obsolete"))))
  (package-menu-filter-by-keyword (concat "status:" status)))

(define-key package-menu-mode-map "s" #'package-menu-filter-by-status)
(define-key package-menu-mode-map "a" #'package-menu-find-marks)

(eval-when-compile
  (require 'use-package))
(require 'bind-key)

(setq use-package-always-pin "melpa-unstable")
(setq use-package-always-ensure t)
(setq use-package-always-diminish t)

(provide 'setup-packages)

;;; setup-packages.el ends here
