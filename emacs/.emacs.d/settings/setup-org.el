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
                             "/gtd.org"
                             "/media.org"
                             "/kalender.org"
                             "/kontakte.org"]))
    (setq org-default-notes-file (concat org-directory "/inbox.org"))
    (setq org-archive-location (concat org-directory "/archiv.org::* From %s"))
    (setq org-capture-templates `(
                                  ("i" "Inbox" entry
                                   (file ,(concat org-directory "/inbox.org"))
                                   "* %i%?")))
    (setq org-refile-targets `((nil :maxlevel . 1)
                               (,(concat org-directory "/gtd.org") :maxlevel . 1)
                               (,(concat org-directory "/media.org") :maxlevel . 1)
                               (,(concat org-directory "/kalender.org") :maxlevel . 2)
                               (,(concat org-directory "/irgendwann.org") :maxlevel . 1)
                               (,(concat org-directory "/referenz.org") :maxlevel . 1)
                               ))
    (setq org-todo-keywords '((sequence "TODO(t)" "WARTENAUF(w)" "|" "FERTIG(f)" "ABGEBROCHEN(a)")))
    (setq org-todo-keyword-faces
          '(("TODO" . (:foreground "#EF5350" :weight bold))
            ("WARTENAUF" . (:foreground "#42A5F5" :weight bold))
            ("FERTIG" . (:foreground "#388E3C" :weight bold))
            ("ABGEBROCHEN" . (:foreground "#4A148C" :weight bold))
            ("PROJEKT" . (:foreground "#FF8F00"))
            ("BEENDET" . (:foreground "#D4E157"))))
    (global-set-key (kbd "C-c l") 'org-store-link)
    (global-set-key (kbd "C-c a") 'org-agenda)
    (global-set-key (kbd "C-c c") 'org-capture)
    (setq org-agenda-custom-commands
          '(("k" . "Kalender")
            ("kh" agenda "Agenda heute"
             ((org-agenda-span 'day)))
            ("kw" agenda "Agenda Woche"
             ((org-agenda-span 'week)))
            ("kz" agenda "Agenda zwei Wochen"
             ((org-agenda-span 'fortnight)))
            ("r" . "R??ckblick")
            ("rw" agenda "Wochenr??ckblick"
               ((org-agenda-start-day "-14d")
                (org-agenda-span 14)
                (org-agenda-start-on-weekday 1)
                (org-agenda-start-with-log-mode '(closed))
                (org-agenda-skip-function nil)))
            ("l" . "Listen")
            ("lt" todo "TODO")
            ("lp" todo "PROJEKT")
            ("lw" todo "WARTENAUF")
            ))
    (setq org-stuck-projects
      '("/PROJEKT-BEENDET" ("TODO" "WARTENAUF") nil ""))
    (unless (boundp 'org-latex-packages-alist)
      (setq org-latex-packages-alist nil))
    (add-to-list 'org-latex-packages-alist
             '("AUTO" "babel" t ("pdflatex")))
    (add-to-list 'org-latex-packages-alist
             '("AUTO" "polyglossia" t ("xelatex" "lualatex")))
    (unless (boundp 'org-latex-classes)
      (setq org-latex-classes nil))
    (add-to-list 'org-latex-classes
                 '("article"
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
    (add-to-list 'org-latex-classes
                 '("scrartcl-crimson"
                   "\\documentclass[paper=a4,fontsize=11pt,BCOR=0mm,DIV=calc]{scrartcl}
                    \\usepackage{
                    amsmath,
                    amssymb,
                    microtype,
                    iftex,
                    }
                        [PACKAGES]
                        [EXTRA]
                    \\newif\\ifxetexorluatex
                    \\ifxetex
                       \\xetexorluatextrue
                       \\message{Detected XeLaTeX}
                    \\else
                      \\ifluatex
                        \\xetexorluatextrue
                        \\message{Detected LuaLaTeX}
                      \\else
                        \\xetexorluatexfalse
                        \\message{Detected pdfLaTeX}
                       \\fi
                    \\fi

                    \\ifxetexorluatex
                      \\usepackage{fontspec}
                      \\usepackage{polyglossia}
                      \\ifluatex
                        \\setsansfont{TeX Gyre Heros}
                        \\setmainfont[Ligatures=TeX]{Crimson}
                        \\setmonofont[
                          UprightFont = *-Light,
                          BoldFont = *-Regular,
                          ItalicFont = *-LightItalic,
                          %BoldItalicFont = *-Italic,
                          Extension = .ttf,
                          Scale = 1.0
                        ]{JetBrains Mono}
                      \\else
                        \\setsansfont[
                          UprightFont = *-regular,
                          BoldFont = *-bold,
                          ItalicFont = *-italic,
                          BoldItalicFont = *-bolditalic,
                          Extension = .otf, % chktex 26
                          Scale = 1.0
                        ]{texgyreheros}
                        \\setmainfont[
                          Ligatures = TeX,
                          UprightFont = *-Roman,
                          BoldFont = *-Bold,
                          ItalicFont = *-Italic,
                          BoldItalicFont = *-BoldItalic,
                          Extension = .otf, % chktex 26
                          Scale = 1.0
                        ]{Crimson}
                        \\setmonofont[
                          UprightFont = *-Light,
                          BoldFont = *-Regular,
                          ItalicFont = *-LightItalic,
                          BoldItalicFont = *-Italic,
                          Extension = .ttf, % chktex 26
                          Scale = 1.0
                        ]{JetBrainsMono}
                      \\fi
                      \\ifxetex
                        \\XeTeXinputnormalization=1
                      \\fi
                    \\else
                      \\usepackage[utf8]{inputenc}
                      \\usepackage[T1]{fontenc}
                      \\usepackage{tgheros}
                      \\usepackage{crimson}
                      \\usepackage{babel}
                    \\fi"
                   ("\\section{%s}" . "\\section*{%s}")
                   ("\\subsection{%s}" . "\\subsection*{%s}")
                   ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                   ("\\paragraph{%s}" . "\\paragraph*{%s}")))
    (setq org-agenda-skip-deadline-prewarning-if-scheduled t)
    (calendar-set-date-style :iso)
    (setq calendar-week-start-day 1
          calendar-day-name-array ["Sonntag" "Montag" "Dienstag" "Mittwoch"
                                   "Donnerstag" "Freitag" "Samstag"]
          calendar-month-name-array ["J??nner" "Feber" "M??rz" "April" "Mai"
                                     "Juni" "Juli" "August" "September"
                                     "Oktober" "November" "Dezember"])
    ))


;; htmlize for exporting the agenda to html

(use-package htmlize
  :config
  (progn
    (setq htmlize-html-charset "utf-8"))
  )

(use-package org-vcard
  :pin "melpa-unstable"
  :after org)

(provide 'setup-org)
