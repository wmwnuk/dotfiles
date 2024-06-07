;;; obsidian.el --- Description -*- lexical-binding: t; -*-

(use-package! obsidian
        :config
        (obsidian-specify-path "/mnt/c/Users/Lanius/Sync/Obsidian")
        (global-obsidian-mode t)
        :custom
        (obsidian-daily-notes-directory "Dziennik")
        (obsidian-inbox-directory "Notatki"))


(map! :after obsidian
      :leader
      (:prefix "n"
               "f" #'obsidian-search
               "a" #'obsidian-daily-note
               "i" #'obsidian-capture
               "n" #'obsidian-jump
               ))

;; beautify markdown
(custom-set-faces!
'(markdown-header-delimiter-face :foreground "#565f89" :height 0.9)
'(markdown-header-face-1 :height 1.8 :foreground "#f7768e" :weight extra-bold :inherit markdown-header-face)
'(markdown-header-face-2 :height 1.4 :foreground "#e0af68" :weight extra-bold :inherit markdown-header-face)
'(markdown-header-face-3 :height 1.2 :foreground "#7dcfff" :weight extra-bold :inherit markdown-header-face)
'(markdown-header-face-4 :height 1.15 :foreground "#bb9af7" :weight bold :inherit markdown-header-face)
'(markdown-header-face-5 :height 1.1 :foreground "#7aa2f7" :weight bold :inherit markdown-header-face)
'(markdown-header-face-6 :height 1.05 :foreground "#b4f9f8" :weight semi-bold :inherit markdown-header-face))

;; unhighlight markdown
(defvar nb/current-line '(0 . 0)
  "(start . end) of current line in current buffer")
(make-variable-buffer-local 'nb/current-line)

(defun nb/unhide-current-line (limit)
  "Font-lock function"
  (let ((start (max (point) (car nb/current-line)))
        (end (min limit (cdr nb/current-line))))
    (when (< start end)
      (remove-text-properties start end
                              '(invisible t display "" composition ""))
      (goto-char limit)
      t)))

(defun nb/refontify-on-linemove ()
  "Post-command-hook"
  (let* ((start (line-beginning-position))
         (end (line-beginning-position 2))
         (needs-update (not (equal start (car nb/current-line)))))
    (setq nb/current-line (cons start end))
    (when needs-update
      (font-lock-fontify-block 3))))

(defun nb/markdown-unhighlight ()
  "Enable markdown concealling"
  (interactive)
  (markdown-toggle-markup-hiding 'toggle)
  (font-lock-add-keywords nil '((nb/unhide-current-line)) t)
  (add-hook 'post-command-hook #'nb/refontify-on-linemove nil t))

(add-hook 'markdown-mode-hook #'nb/markdown-unhighlight)
