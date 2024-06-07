;;; server-sync.el --- Description -*- lexical-binding: t; -*-

(defun sync-to-server ()
  "Sync to server with external script."
  (interactive)
  (let ((current-dir (current-project-dir)) (current-file (file-path-in-project)))
  (if (file-exists-p (format "%s.sync" current-dir))
      (save-window-excursion
      (async-shell-command
       (format "%s.sync upload $(dirname %s) $(basename %s)" current-dir current-file current-file)) nil))))

(defun sync-from-server ()
  "Sync from server with external script."
  (interactive)
  (let ((current-dir (current-project-dir)) (current-file (file-path-in-project)))
  (if (file-exists-p (format "%s.sync" current-dir))
      (shell-command-to-string
       (format "%s.sync download $(dirname %s) $(basename %s)" current-dir current-file current-file)) nil)))

(add-hook 'after-save-hook #'sync-to-server)

(map! :leader
      (:prefix "S"
               "u" #'sync-to-server
               "d" #'sync-from-server))
