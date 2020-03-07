

(defun org-get-agenda-files-recursively (dir)
  "Get org agenda files from root DIR."
  (directory-files-recursively dir "\.org$"))

(defun org-set-agenda-files-recursively (dir)
 "Set org-agenda files from root DIR."
 (setq org-agenda-files
   (org-get-agenda-files-recursively dir)))

(defun org-add-agenda-files-recursively (dir)
  "Add org-agenda files from root DIR."
  (nconc org-agenda-files
   (org-get-agenda-files-recursively dir)))


(setq org-directory (expand-file-name "~/Org"))
(setq org-default-notes-file (concat org-directory "/main.org"))
(setq org-archive-location "~/Org/archive.org::* From %s")
(setq org-agenda-files '("~/Org"))

(org-add-agenda-files-recursively "~/Uni")

(setq org-todo-keywords
      '(
        (sequence "TODO(t)" "WAITING(w)" "|" "DONE(d)")
        (sequence "|" "CANCELLED(c)" "DELEGATED(l)")
        ))

(setq org-todo-keyword-faces
      '(("WAITING" . (:foreground "coral" :weight bold))
        ("CANCELLED" . (:foreground "LimeGreen" :weight bold))
        ("DELEGATED" . (:foreground "LimeGreen" :weight bold))))
