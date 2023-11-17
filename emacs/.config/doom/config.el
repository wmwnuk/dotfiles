;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Wojciech M. Wnuk"
      user-mail-address "laniusone@pm.me")

(setq doom-font "Source Code Pro:pixelsize=14")
(setq doom-unicode-font "SauceCodePro Nerd Font:pixelsize=14")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-tokyo-night)

(set-frame-parameter nil 'alpha-background 98)
(add-to-list 'default-frame-alist '(alpha-background . 98))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "/mnt/c/Users/Lanius/Proton\ Drive/laniusone/My\ files/Org")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(setq-default tab-width 4)

(after! consult
  (setq consult-ripgrep-args "rg --hidden --no-ignore --null --line-buffered --color=never --max-columns=1000 --path-separator /\
   --smart-case --no-heading --with-filename --line-number --search-zip"))

(after! vertico
  (setq +vertico-consult-fd-args "fd --color=never -i -u -E .git --regex "))

(after! lsp-mode
  (setq lsp-enable-file-watchers nil))

;; (add-to-list 'auto-mode-alist '("\\.phtml\\'" . php-mode))

(after! vterm
  (setq vterm-shell "/bin/zsh")
  (setq vterm-kill-buffer-on-exit t))

(after! centaur-tabs
  (setq centaur-tabs-set-bar 'right))

(defun current-project-dir ()
  "Get current project directory"
  (interactive)
  (cdr (project-projectile (file-name-directory buffer-file-name))))

(defun file-path-in-project ()
  "Return file path in current project"
  (interactive)
  (let ((dir (current-project-dir))) (if dir (s-replace (current-project-dir) "" buffer-file-name) buffer-file-name)))

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

(defun vterm-ssh-to-server ()
  "Open SSH session in vterm"
  (interactive)
  (run-in-vterm-and-exit (format "ssh %s -A" (completing-read
                                              "Ssh: "
                                              (split-string (shell-command-to-string "grep 'Host ' ~/.ssh/config | cut -b 6- | grep -v '\*'") "\n" t)
                                              nil t))))

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
                  ;;(auto-raise . t) ; focus on this frame
                  ;;(tool-bar-lines . 0)
                  ;;(menu-bar-lines . 0)
                  (internal-border-width . 10)
                  (width . 80)
                  (height . 11)))
                  (unwind-protect
                    (emenu/run)
                    (delete-frame))))

(use-package! beacon
  :config
  (beacon-mode 1))

(global-visual-line-mode t)

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

(defun open-lazygit ()
  "Open lazygit in new window or pane in tmux"
  (interactive)
  (if window-system
      (progn (+evil/window-vsplit-and-follow) (if (get-buffer "*lazygit*") (switch-to-buffer "*lazygit*") (run-in-vterm-and-exit "lazygit")))
    (shell-command-to-string "tmux split-window -h lazygit")))

(defun open-vterm ()
  "Open Vterm terminal"
  (interactive)
  (if (get-buffer "*vterm*") (switch-to-buffer "*vterm*") (+vterm/here nil)))

(map! :leader
      (:prefix "r"
               "g" #'consult-ripgrep)
      )

(map! :leader
      (:prefix "g"
               "d" #'lsp-find-definition
               "i" #'lsp-find-implementation
               "r" #'lsp-find-references
               "D" #'lsp-find-declaration
               "K" #'lsp-find-type-definition)
      )

(map! :leader
      (:prefix "S"
               "u" #'sync-to-server
               "d" #'sync-from-server))

(map! :leader
      (:prefix "g"
               "g" #'open-lazygit))

(map! :leader
      (:prefix "o"
               "c" #'run-in-vterm-and-exit
               "C" #'run-in-vterm))

(map! :leader
      (:prefix "f"
               "f" #'+vertico/consult-fd
               "b" #'project-dired))

(map! :leader
      :prefix "y"
      "y" #'consult-yank-from-kill-ring)

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

(map! :after docker
      :prefix "C-c"
      "d" #'docker)

(map! "C-," 'embark-dwim)

(map! "M-[" 'centaur-tabs-backward-tab)
(map! "M-]" 'centaur-tabs-forward-tab)

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

(add-hook 'minibuffer-setup-hook
          (lambda ()
            (local-set-key (kbd "M-p") 'embark-export)))

;; clear projectile cache
(add-hook 'projectile-after-switch-project-hook (lambda ()
      (projectile-invalidate-cache nil)))

;;(add-hook 'after-init-hook (lambda ()
;;    (mapc (lambda (project-root)
;;	(remhash project-root projectile-project-type-cache)
;;	(remhash project-root projectile-projects-cache)
;;	(remhash project-root projectile-projects-cache-time)
;;	(when projectile-verbose
;;	    (message "Invalidated Projectile cache for %s."
;;		(propertize project-root 'face 'font-lock-keyword-face)))
;;	(when (fboundp 'recentf-cleanup)
;;	    (recentf-cleanup)))
;;	(projectile-hash-keys projectile-projects-cache))
;;    (projectile-serialize-cache)))

;; (add-hook! vterm-mode-hook #'turn-off-evil-mode)
;; (add-hook! eshell-mode-hook #'turn-off-evil-mode)

;; needed only for Emacs without X support
;; (global-set-key [mouse-4] (lambda () (interactive) (scroll-down 5)))
;; (global-set-key [mouse-5] (lambda () (interactive) (scroll-up 5)))

(load! "iph.el")
;; (load! "c3po.el")

;; ellama

;; (use-package! ellama
;;   :init
;;   (setopt ellama-language "en")
;;   (require 'llm-ollama)
;;   (setopt ellama-provider
;;           (make-llm-ollama
;;            :chat-model "zephyr" :embedding-model "zephyr")))

;; WSL specific stuff

(defun wsl/frame-maximize ()
  (interactive)
  (set-frame-position nil 5 5)
  (set-frame-size nil 425 75))

(defun wsl/frame-half ()
  (interactive)
  (set-frame-position nil 5 5)
  (set-frame-size nil 212 75))

(defun wsl/frame-2-col ()
  (interactive)
  (set-frame-position nil 5 5)
  (set-frame-size nil 280 75))

(defun wsl/frame-1-col ()
  (interactive)
  (set-frame-position nil 5 5)
  (set-frame-size nil 140 75))

(map! "M-<f11>" 'wsl/frame-maximize)
(map! "M-<f9>" 'wsl/frame-2-col)
(map! "M-<f8>" 'wsl/frame-1-col)
(map! "M-<f7>" 'wsl/frame-half)

(after! prettier-js
  (add-hook 'typescript-mode-hook 'prettier-js-mode)
  (add-hook 'typescript-tsx-mode-hook 'prettier-js-mode)
  (add-hook 'rjsx-mode-hook 'prettier-js-mode)
  (add-hook 'js-mode-hook 'prettier-js-mode)
  (add-hook 'js2-mode-hook 'prettier-js-mode))

(after! typescript-mode
  (add-hook 'typescript-mode-hook #'add-node-modules-path))

(after! typescript-tsx-mode
  (add-hook 'typescript-tsx-mode-hook #'add-node-modules-path))

(after! rjsx-mode
  (add-hook 'rjsx-mode-hook #'add-node-modules-path))

(after! js-mode
  (add-hook 'js-mode-hook #'add-node-modules-path))

(after! js2-mode
  (add-hook 'js2-mode-hook #'add-node-modules-path))

(use-package blamer
  :bind (("C-c i" . blamer-show-commit-info))
  :defer 20
  :custom
  (blamer-idle-time 0.3)
  (blamer-min-offset 70)
  :custom-face
  (blamer-face ((t :foreground "#7a88cf"
                    :background nil
                    ;; :height 140
                    :italic t)))
  :config
  (global-blamer-mode 1))
