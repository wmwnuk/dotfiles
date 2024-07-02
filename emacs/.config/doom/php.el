;;; php.el --- Description -*- lexical-binding: t; -*-

(add-to-list 'auto-mode-alist '("\\.php\\'" . php-mode))
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . php-mode))

(defun +php/is-magento ()
  "Is this Magento 2 project"
  (file-exists-p (format "%s/bin/magento" (current-project-dir))))

(defun +php/is-warden-running ()
  "Is warden running"
  (not (shell-command-to-string "warden shell -c 'ls'; echo $?")))

(defun +php/is-warden-project ()
  "Is it warden project"
  (file-exists-p (format "%s/.env" (current-project-dir))))

(defun +warden/get-command-prefix ()
  "Get command prefix"
  (if (+php/is-warden-project) "warden shell -c" "bash -c"))

(defun +warden/up ()
  "Start warden env"
  (interactive)
  (if (not (+php/is-warden-running)) (async-shell-command "warden env up" "*warden*") nil))

(defun +warden/--up ()
  "Start warden env synchronously"
  (if (not (+php/is-warden-running)) (save-window-excursion (shell-command "warden env up" "*warden*")) nil))

(defun +warden/down ()
  "Stop warden env"
  (interactive)
  (if (+php/is-warden-running) (async-shell-command "warden env down" "*warden*") nil))

(defun +warden/restart ()
  "Restart warden env"
  (interactive)
  (if (+php/is-warden-running) (async-shell-command "warden env restart" "*warden*") (+warden/up)))

(defun +php/run-command-in-project (command)
  "Run command in project"
  (let ((command-prefix (+warden/get-command-prefix)))
    (if (not (+php/is-warden-running)) (+warden/--up) nil)
    (save-window-excursion (async-shell-command (format "%s '%s'" command-prefix command) (format "*%s*" command)))))

(defun +php/composer-install ()
  "Run composer install in project"
  (interactive)
  (+php/run-command-in-project "composer install"))

(defun +magento/setup-upgrade ()
  "Run setup:upgrade in project"
  (interactive)
  (+php/run-command-in-project "bin/magento setup:upgrade"))

(defun +magento/setup-di-compile ()
  "Run setup:di:compile in project"
  (interactive)
  (+php/run-command-in-project "bin/magento setup:di:compile"))

(defun +magento/developer-mode ()
  "Run deploy:mode:set developer in project"
  (interactive)
  (+php/run-command-in-project "bin/magento deploy:mode:set developer"))

(defun +magento/production-mode ()
  "Run deploy:mode:set production in project"
  (interactive)
  (+php/run-command-in-project "bin/magento deploy:mode:set production"))

(defun +magento/cache-flush ()
  "Run cache:flush in project"
  (interactive)
  (+php/run-command-in-project "bin/magento cache:flush"))

(defun +magento/cache-clean ()
  "Run cache:clean in project"
  (interactive)
  (+php/run-command-in-project "bin/magento cache:clean"))

(defun +magento/invalidate-indexes ()
  "Invalidate indexes"
  (interactive)
  (+php/run-command-in-project "bin/magento indexer:reset"))

(defun +magento/indexer-reindex ()
  "Run indexer:reindex in project"
  (interactive)
  (+php/run-command-in-project "bin/magento indexer:reindex"))

(defun +magento/indexer-reindex-force ()
  "Run indexer:reindex in project"
  (interactive)
  (+magento/invalidate-indexes)
  (+magento/indexer-reindex))

(defun +magento/remove-generated ()
  "Remove generated files"
  (interactive)
  (+php/run-command-in-project "rm -rf generated/*"))

(defun +magento/clear ()
  "Clear cache, remove generated files and run setup:upgrade"
  (interactive)
  (+magento/developer-mode)
  (+magento/remove-generated)
  (+magento/setup-upgrade))

(defun +php/is-command-available (command)
  "Check if command is available"
  (file-exists-p (format "%s/vendor/bin/%s" (current-project-dir) command)))

(defun +php/php-cs-fixer ()
  "Run php-cs-fixer on current buffer."
  (interactive)
  (save-buffer)
  (let ((command (if (+php/is-magento) "vendor/bin/php-cs-fixer" "php-cs-fixer")))
    (let ((output (shell-command-to-string
                   (format "%s '%s fix %s'" (+warden/get-command-prefix) command (file-path-in-project)))))
      (revert-buffer t t)
      (if (= (length output) 0) (message output) (message "Php-cs-fixer ran successfully.")))))

(defun +php/rector ()
  "Run rector on current buffer."
  (interactive)
  (save-buffer)
  (let ((command (if (+php/is-magento) "vendor/bin/rector" "rector")))
    (if (file-exists-p (format "%s/rector.php" (current-project-dir)))
        nil
      (shell-command-to-string
       (format "cp ~/.config/doom/rector.php %s" (current-project-dir))))
    (let ((output (shell-command-to-string
                   (format "%s '%s process %s'" (+warden/get-command-prefix) command (file-path-in-project))))) (revert-buffer t t)
                   (if (= (length output) 0) (message output) (message "Rector ran successfully.")))))

(defun +php/phpcbf ()
  "Run phpcbf in current buffer."
  (interactive)
  (save-buffer)
  (let ((command (if (+php/is-magento) "vendor/bin/phpcbf" "phpcbf")))
    (let ((output (shell-command-to-string
                   (format "%s '%s --standard=Magento2 %s'" (+warden/get-command-prefix) command (file-path-in-project)))))
      (revert-buffer t t)
      (if (= (length output) 0) (message output) (message "Code Sniffer beautified your code!")))))

(defun +php/phpcs ()
  "Run phpcs in current buffer."
  (interactive)
  (save-buffer)
  (let ((command (if (+php/is-magento) "vendor/bin/phpcs" "phpcs")))
    (shell-command
     (format "%s '%s --standard=Magento2 %s'" (+warden/get-command-prefix) command (file-path-in-project)) "*phpcs*")))

(defun +php/phpmd ()
  "Run phpmd in current buffer."
  (interactive)
  (save-buffer)
  (let ((command (if (+php/is-magento) "vendor/bin/phpmd" "phpmd")))
    (shell-command
     (format "%s '%s %s text dev/tests/static/testsuite/Magento/Test/Php/_files/phpmd/ruleset.xml'"
             (+warden/get-command-prefix) command (file-path-in-project)) "*phpmd*")))

(map! :map php-mode-map
      :leader
      (:prefix "c"
               "N" #'+php/phpcs
               "B" #'+php/phpcbf
               "M" #'+php/phpmd
               "F" #'+php/php-cs-fixer
               "R" #'+php/rector))
