;;; tgpt.el --- Description -*- lexical-binding: t; -*-

(defun get-or-create-buffer (buffer-name)
  (let ((tgpt (get-buffer buffer-name)))
    (if tgpt
        tgpt
      (generate-new-buffer buffer-name))))

(defun tgpt-buffer ()
  (interactive)
  (let ((tgpt (get-or-create-buffer "*TGPT*")))
    (switch-to-buffer tgpt)
    (funcall 'markdown-mode)))

(defun tgpt-prompt ()
  (interactive)
  (let ((prompt (read-string "tgpt: ")))
    (tgpt-buffer)
    (insert (format "### %s" prompt))
    (insert "\n\n")
    (insert (shell-command-to-string (format "tgpt -q -w '%s' " prompt)))
    (insert "\n\n")))
