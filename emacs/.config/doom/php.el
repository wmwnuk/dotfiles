;;; php.el --- Description -*- lexical-binding: t; -*-

(add-to-list 'auto-mode-alist '("\\.php\\'" . php-mode))
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . php-mode))

(defun +php/php-cs-fixer ()
  "Run php-cs-fixer on current buffer."
  (interactive)
  (save-buffer)
  (let ((current-dir (current-project-dir)) (current-file (file-path-in-project)) (command "vendor/bin/php-cs-fixer"))
    (if (file-exists-p (format "%s/vendor/bin/php-cs-fixer" current-dir))
        (progn
          (let ((output (shell-command-to-string
                         (format "warden shell -c '%s fix %s'" command current-file))))
            (revert-buffer t t)
            (if (= (length output) 0) (message output) (message "Php-cs-fixer ran successfully.")))))
    nil))

(defun +php/rector ()
  "Run rector on current buffer."
  (interactive)
  (save-buffer)
  (let ((current-dir (current-project-dir)) (current-file (file-path-in-project)) (command "vendor/bin/rector"))
    (if (file-exists-p (format "%s/vendor/bin/rector" current-dir))
        (progn
          (if (file-exists-p (format "%s/rector.php" current-dir))
              nil
            (shell-command-to-string
             (format "cp ~/.config/doom/rector.php %s" current-dir)))
          (let ((output (shell-command-to-string
                    (format "warden shell -c '%s process %s'" command current-file)))) (revert-buffer t t)
                    (if (= (length output) 0) (message output) (message "Rector ran successfully.")))) nil)))


(map! :after php-mode
      :leader
      (:prefix "c"
      "F" #'+php/php-cs-fixer
      "R" #'+php/rector))
