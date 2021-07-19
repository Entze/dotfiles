;(use-package dashboard
; :ensure t
; :after (evil)
; :delight
; :config
; (dashboard-setup-startup-hook)
; ;; Content is not centered by default. To center, set
; (setq dashboard-center-content t)
; )

;; No startup  screen
(setq inhibit-startup-screen t)

;; No startup message
(setq inhibit-startup-message t)
(setq inhibit-startup-echo-area-message t)

;; No message in scratch buffer
(setq initial-scratch-message nil)

;; Initial buffer
;(setq initial-buffer-choice nil)



(provide 'setup-dashboard)
