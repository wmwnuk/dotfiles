;;; lazygit.el --- Description -*- lexical-binding: t; -*-

(defun open-lazygit ()
  "Open lazygit in new window or pane in tmux"
  (interactive)
  (if window-system
      (progn (+evil/window-vsplit-and-follow) (if (get-buffer "*lazygit*") (switch-to-buffer "*lazygit*") (run-in-vterm-and-exit "lazygit")))
    (shell-command-to-string "tmux split-window -h lazygit")))

(map! :leader
      (:prefix "g"
               "g" #'open-lazygit))
