
(use-package flyspell
  :diminish
  :hook (
           (prog-mode . flyspell-prog-mode)
           (text-mode . flyspell-mode)))

(setq ispell-program-name "/usr/bin/hunspell")
(setq ispell-dictionary "en_GB-large")

(use-package synosaurus
  :diminish synosaurus-mode
  )

;; TODO: langtool
(use-package langtool
 :config
  (setq langtool-language-tool-jar
     "~/Apps/.bin/languagetool-commandline.jar"))

(use-package writegood-mode
  ;; Load this whenver I'm composing prose.
  :hook (text-mode org-mode)
  ;; Don't show me the “Wg” marker in the mode line
  :diminish)

(use-package wc-mode)
