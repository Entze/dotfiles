
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
  :diminish
  ;; Some additional weasel words.
  :config
  (--map (push it writegood-weasel-words)
         '("some" "simple" "simply" "easy" "often" "easily" "probably"
           "clearly"               ;; Is the premise undeniably true?
           "experience shows"      ;; Whose? What kind? How does it do so?
           "may have"              ;; It may also have not!
           "it turns out that")))  ;; How does it turn out so?
           ;; ↯ What is the evidence of highighted phrase? ↯
