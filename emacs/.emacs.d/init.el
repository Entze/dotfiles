;; My personal init.el

;; The config is delegated into
;; .
;; └── init.el

;; Turn off mouse interface early in startup to avoid momentary display
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

(setq gc-cons-threshold most-positive-fixnum)

;; Keep emacs Custom-settings in separate file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror)

(setq settings-dir
  (expand-file-name "settings" user-emacs-directory))


;; Set up load path
(add-to-list 'load-path settings-dir)

(require 'setup-colors)      ; settings/setup-colors.el
(require 'setup-packages)    ; settings/setup-packages.el
(require 'setup-theme)       ; settings/setup-theme.el
(require 'setup-dashboard)   ; settings/setup-dashboard.el
(require 'setup-files)       ; settings/setup-files.el
(require 'setup-treemacs)    ; settings/setup-treemacs.el
(require 'setup-centaurtabs) ; settings/setup-centaurtabs.el
(require 'setup-org)         ; settings/setup-org.el
(require 'setup-evil)        ; settings/setup-evil.el
(require 'setup-editor)      ; settings/setup-editor.el
(require 'setup-modeline)    ; settings/setup-modeline.el
(require 'setup-programming) ; settings/setup-programming.el

(add-hook 'after-init-hook (lambda () (setq gc-cons-threshold 1073741824)))
