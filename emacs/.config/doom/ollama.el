;;; ollama.el --- Description -*- lexical-binding: t; -*-

(use-package! ellama
  :init
  (setopt ellama-language "English")
  (require 'llm-ollama)
  (setopt ellama-provider
          (make-llm-ollama
           :chat-model "dolphin-llama3:8b" :embedding-model "dolphin-llama3:8b"))
  (shell-command-to-string "systemctl --user restart ollama"))

(map! :leader
      :prefix "e"
      :desc "Ellama"
      "c c" #'ellama-complete-code
      "c a" #'ellama-add-code
      "c e" #'ellama-edit-code
      "c i" #'ellama-enhance-code
      "c r" #'ellama-code-review
      "s s" #'ellama-summarize
      "s w" #'ellama-summarize-webpage
      "i w" #'ellama-enhance-wording
      "i g" #'ellama-enhance-grammar-spelling
      "m c" #'ellama-make-concise
      "m l" #'ellama-make-list
      "m t" #'ellama-make-table
      "m f" #'ellama-render
      "a a" #'ellama-ask-about
      "a i" #'ellama-chat
      "t t" #'ellama-translate
      "t c" #'ellama-change
      "d w" #'ellama-define-word)
