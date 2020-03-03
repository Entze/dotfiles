

(setq org-directory (expand-file-name "~/Org"))
(setq org-default-notes-file (concat org-directory "/main.org"))
(setq org-agenda-files '("~/Org"))


(setq org-todo-keywords
      '(
        (sequence "TODO(t)" "WAITING(w)" "|" "DONE(d)")
        (sequence "|" "CANCELLED(c)" "DELEGATED(l)")
        ))

(setq org-todo-keyword-faces
      '(("WAITING" . (:foreground "coral" :weight bold))
        ("CANCELLED" . (:foreground "LimeGreen" :weight bold))
        ("DELEGATED" . (:foreground "LimeGreen" :weight bold))))
