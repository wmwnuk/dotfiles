;;; vterm.el --- Description -*- lexical-binding: t; -*-

;; Vterm settings and functions
(after! vterm
  (setq vterm-shell "/bin/zsh")
  (setq vterm-kill-buffer-on-exit t))

(defun vterm-ssh-to-server ()
  "Open SSH session in vterm"
  (interactive)
  (run-in-vterm-and-exit (format "ssh %s -A" (completing-read
                                              "Ssh: "
                                              (split-string (shell-command-to-string "grep 'Host ' ~/.ssh/config | cut -b 6- | grep -v '\*'") "\n" t)
                                              nil t))))

(defun run-in-vterm-kill (process event)
  "A process sentinel. Kills PROCESS's buffer if it is alive."
  (let ((b (process-buffer process)))
    (and (buffer-live-p b)
         (kill-buffer b))))

(defun run-in-vterm (command)
  "Execute string COMMAND in a new vterm.

Interactively, prompt for COMMAND with the current buffer's file
name supplied. When called from Dired, supply the name of the
file at point."
  (interactive
   (list
    (let* ((f (cond (buffer-file-name)
                    ((eq major-mode 'dired-mode)
                     (dired-get-filename nil t))))
           (filename (concat " " (shell-quote-argument (and f (file-relative-name f))))))
      (read-shell-command "Terminal command: "
                          (cons filename 0)
                          (cons 'shell-command-history 1)
                          (list filename)))))
  (with-current-buffer (vterm (concat "*" command "*"))
    (set-process-sentinel vterm--process #'run-in-vterm-kill)
    (vterm-send-string command)
    (vterm-send-return)))

(defun run-in-vterm-and-exit (command)
  "Execute string COMMAND in a new vterm and exit."
  (interactive
   (list
      (read-shell-command "Terminal command: "
                          nil
                          (cons 'shell-command-history 1))))
  (with-current-buffer (vterm (concat "*" command "*"))
    (set-process-sentinel vterm--process #'run-in-vterm-kill)
    (vterm-send-string (concat command ";exit"))
    (vterm-send-return)))

(defun open-vterm ()
  "Open Vterm terminal"
  (interactive)
  (if (get-buffer "*vterm*") (switch-to-buffer "*vterm*") (+vterm/here nil)))

(map! :leader
      (:prefix "o"
               "c" #'run-in-vterm-and-exit
               "C" #'run-in-vterm))

(map! :leader
      (:prefix "o"
       "\\" #'vterm-ssh-to-server))

(map! :prefix "C-x"
       "C-\\" #'vterm-ssh-to-server)

(map! :after vterm
      :map vterm-mode-map
      :prefix "C-c"
      "ESC" #'vterm-send-escape
      "C-x" #'vterm--self-insert)
