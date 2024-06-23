;;; emenu.el --- Description -*- lexical-binding: t; -*-

(defun emenu/run ()
  "Run command"
  (interactive)
  (call-process-shell-command (completing-read "run: "
                                               (split-string
                                                (shell-command-to-string "(for pdir in $(echo \"$PATH\" | tr \":\" \"\\n\")
do
\\find \"$pdir\" -maxdepth 1 -executable -type f,l -printf \"%f\\n\" 2>/dev/null
done)|sort")
                                                "\n" t)
                                               nil nil)
                              nil 0))

(defun emenu/run-frame ()
  "Yoinked from DT"
  (interactive)
  (with-selected-frame
    (make-frame '((name . "emacs-run-launcher")
                  (minibuffer . only)
                  (fullscreen . 0) ; no fullscreen
                  (undecorated . t) ; remove title bar
                  (auto-raise . t) ; focus on this frame
                  ;;(tool-bar-lines . 0)
                  ;;(menu-bar-lines . 0)
                  (internal-border-width . 10)
                  (width . 80)
                  (height . 11)))
                  (unwind-protect
                    (emenu/run)
                    (delete-frame))))
