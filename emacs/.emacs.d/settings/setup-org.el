(defun my/prepend-org-directory (f) (concat org-directory f))


(use-package org
  :ensure t
  :after (evil)
  :mode ("\\.org$" . org-mode)
  :pin "elpa"
  :hook (org-capture-mode . evil-insert-state)
  :config
  (progn
    (setq org-directory "~/Org")
    (setq org-agenda-files (mapcar 'my/prepend-org-directory [
                             "/inbox.org"
                             "/projects.org"
                             "/media.org"
                             "/calendar.org"
                             "/contacts.org"]))
    (setq org-default-notes-file (concat org-directory "/inbox.org"))
    (setq org-archive-location (concat org-directory "/archive.org::* From %s"))
    (setq org-capture-templates `(
                                  ("t" "Todo [inbox]" entry
                                   (file ,(concat org-directory "/inbox.org"))
                                   "* TODO %i%?")
                                  ("c" "Calendar" entry
                                   (file ,(concat org-directory "/calendar.org"))
                                   "* %i%? \n %U")
                                  ("r" "Reference" entry
                                   (file ,(concat org-directory "/reference.org"))
                                   "* %i%? \n %U")))
    (setq org-refile-targets '((nil :maxlevel . 9)
                               (org-agenda-files :maxlevel . 3)))
    (setq org-todo-keywords '((sequence "TODO(t)" "WAITING(w)" "NEXT(n)" "|" "DONE(d)" "CANCELLED(c)")))
    (setq org-todo-keyword-faces
          '(("TODO" . (:foreground "#EF5350" :weight bold))
            ("NEXT" . (:foreground "#AB47BC" :weight bold))
            ("WAITING" . (:foreground "#42A5F5" :weight bold))
            ("DONE" . (:foreground "#388E3C" :weight bold))
            ("CANCELED" . (:foreground "#26C6DA" :weight bold))))
    (global-set-key (kbd "C-c l") 'org-store-link)
    (global-set-key (kbd "C-c a") 'org-agenda)
    (global-set-key (kbd "C-c c") 'org-capture)
    (unless (boundp 'org-latex-packages-alist)
      (setq org-latex-packages-alist nil))
    (add-to-list 'org-latex-packages-alist
             '("AUTO" "babel" t ("pdflatex")))
    (add-to-list 'org-latex-packages-alist
             '("AUTO" "polyglossia" t ("xelatex" "lualatex")))
    (unless (boundp 'org-latex-classes)
      (setq org-latex-classes nil))
    (add-to-list 'org-latex-classes
                 '("scrartcl"
                   "\\documentclass[paper=a4,fontsize=11pt,BCOR=0mm,DIV=calc]{scrartcl}
                    \\usepackage{
                    amsmath,
                    amssymb,
                    microtype,
                    }
                        [PACKAGES]
                        [EXTRA]"
                   ("\\section{%s}" . "\\section*{%s}")
                   ("\\subsection{%s}" . "\\subsection*{%s}")
                   ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                   ("\\paragraph{%s}" . "\\paragraph*{%s}")))
    (setq org-agenda-skip-deadline-prewarning-if-scheduled t)
    ))

(provide 'setup-org)
