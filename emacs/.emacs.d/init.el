
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(org-babel-load-file "~/.emacs.d/configuration.org")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (gradle-mode evil-paredit paredit relative-line-numbers flycheck-ledger ledger-mode flycheck-package auctex smex yasnippet ox-twbs graphviz-dot-mode ox-mediawiki golden-ratio web-mode flycheck-color-mode-line flycheck magit-gitflow magit typescript-mode coffee-mode haskell-mode sass-mode helm rainbow-delimiters rainbow-mode diff-hl htmlize json-mode evil-surround solarized-theme evil pallet))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
