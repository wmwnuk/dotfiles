;;; ollama.el --- Description -*- lexical-binding: t; -*-

(use-package! ellama
  :init
  (setopt ellama-keymap-prefix "C-c e")
  (setopt ellama-language "English"))

(map! :leader
      (:prefix-map ("e" . "Ellama")
       (:prefix ("c" . "code")
              "c" #'ellama-code-complete
              "a" #'ellama-code-add
              "e" #'ellama-code-edit
              "i" #'ellama-code-improve
              "r" #'ellama-code-review)
        (:prefix ("s" . "summarize/session")
              "s" #'ellama-summarize
              "w" #'ellama-summarize-webpage
              "c" #'ellama-summarize-killring
              "l" #'ellama-load-session
              "r" #'ellama-session-rename
              "d" #'ellama-session-remove
              "a" #'ellama-session-switch)
        (:prefix ("i" . "improve")
              "w" #'ellama-improve-wording
              "g" #'ellama-improve-grammar
              "c" #'ellama-improve-conciseness)
        (:prefix ("m" . "make")
              "l" #'ellama-make-list
              "t" #'ellama-make-table
              "f" #'ellama-make-format)
        (:prefix ("a" . "ask")
              "a" #'ellama-ask-about
              "i" #'ellama-chat
              "l" #'ellama-ask-line
              "s" #'ellama-ask-selection)
        (:prefix ("t" . "text")
              "t" #'ellama-translate
              "b" #'ellama-translate-buffer
              "c" #'ellama-complete
              "e" #'ellama-chat-translation-enable
              "d" #'ellama-chat-translation-disable)
        (:prefix ("d" . "define")
              "w" #'ellama-define-word)
        (:prefix ("x" . "context")
              "b" #'ellama-context-add-buffer
              "f" #'ellama-context-add-file
              "s" #'ellama-context-add-selection
              "i" #'ellama-context-add-info-node)
        (:prefix ("p" . "provider")
              "s" #'ellama-provider-select)))
