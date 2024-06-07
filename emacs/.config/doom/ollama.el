;;; ollama.el --- Description -*- lexical-binding: t; -*-

(use-package! ellama
  :init
  (setopt ellama-language "en")
  (require 'llm-ollama)
  (setopt ellama-provider
          (make-llm-ollama
           :chat-model "dolphin-llama3:8b" :embedding-model "dolphin-llama3:8b"))
  (shell-command-to-string "systemctl --user restart ollama"))

(map! :leader
      :prefix "A"
      "a" #'ellama-ask
      "f" #'ellama-render
      "C" #'ellama-change
      "c" #'ellama-change-code
      "d" #'ellama-define-word
      "p" #'ellama-complete-code
      "e" #'ellama-enhance-code
      "E" #'ellama-enhance-wording
      "g" #'ellama-enhance-grammar-spelling
      "l" #'ellama-make-list
      "t" #'ellama-make-table
      "T" #'ellama-translate
      "s" #'ellama-summarize
      "S" #'ellama-summarize-webpage
      "r" #'ellama-code-review)
