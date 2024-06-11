;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Name and e-mail
(setq user-full-name "Wojciech M. Wnuk"
      user-mail-address "laniusone@pm.me")

;; Font settings
(setq doom-font "Source Code Pro:pixelsize=14")
(setq doom-symbol-font "SauceCodePro Nerd Font:pixelsize=14")

;; Theme settings
(setq doom-theme 'doom-kyoto-night)

;;;; Remove background in terminal to show waifu
(if (display-graphic-p)
    nil
  (progn
    (custom-set-faces
     '(default ((t (:background "unspecified-bg"))))
     )
    (after! solaire-mode
      (solaire-global-mode -1))))

(set-frame-parameter nil 'alpha-background 98)
(add-to-list 'default-frame-alist '(alpha-background . 98))

;; Editor settings
(setq display-line-numbers-type 'relative)
(setq-default tab-width 4)
(global-visual-line-mode t)

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

;; change org link in dashboard
(plist-put (alist-get "Open org-agenda" +doom-dashboard-menu-sections nil nil 'equal)
           :action #'obsidian-daily-note)
(plist-put (alist-get "Open org-agenda" +doom-dashboard-menu-sections nil nil 'equal)
           :key "SPC n a")

;; No more smartparens
(turn-off-smartparens-mode)
(remove-hook 'doom-first-buffer-hook #'smartparens-global-mode)

(require 'posframe)
(use-package! vertico-posframe
  :after vertico
  :config
  (vertico-posframe-mode 1))

;; Search settings
(after! consult
  (setq consult-ripgrep-args "rg --hidden --no-ignore --null --line-buffered --color=never --max-columns=1000 --path-separator /\
   --smart-case --no-heading --with-filename --line-number --search-zip"))

(after! vertico
  (setq +vertico-consult-fd-args "fd --color=never -i -u -E .git --regex "))

(after! treemacs
  (treemacs-project-follow-mode t))

(map! :leader
      (:prefix "r"
               "g" #'consult-ripgrep)
      )

(map! :leader
      (:prefix "f"
               "f" #'+vertico/consult-fd
               "b" #'project-dired))

(map! :leader
      :prefix "y"
      "y" #'consult-yank-from-kill-ring)

(map! "C-," 'embark-dwim)
(add-hook 'minibuffer-setup-hook
          (lambda ()
            (local-set-key (kbd "M-p") 'embark-export)))

;; Utility functions
(defun current-project-dir ()
  "Get current project directory"
  (interactive)
  (cdr (project-projectile (file-name-directory buffer-file-name))))

(defun file-path-in-project ()
  "Return file path in current project"
  (interactive)
  (let ((dir (current-project-dir))) (if dir (s-replace (current-project-dir) "" buffer-file-name) buffer-file-name)))

;; LSP settings
(after! lsp-mode
  (setq lsp-enable-file-watchers nil))

;;;; PHP
(load! "iph.el")
(load! "php.el")

;;;; prettier-js
(load! "prettier-js.el")

;; accept completion from copilot and fallback to company
(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("<tab>" . 'copilot-accept-completion)
              ("TAB" . 'copilot-accept-completion)
              ("C-TAB" . 'copilot-accept-completion-by-word)
              ("C-<tab>" . 'copilot-accept-completion-by-word)
              ("C-<right>" . 'copilot-accept-completion-by-word)
              ))

(load! "ollama.el")
(load! "tgpt.el")

;; Various settings and fixes
(after! centaur-tabs
  (setq centaur-tabs-set-bar 'right))

(map! :after better-jumper "M-," 'centaur-tabs-backward-tab)
(map! :after evil-collection :map evil-normal-state-map "M-." 'centaur-tabs-forward-tab)

;; clear projectile cache
(add-hook 'projectile-after-switch-project-hook (lambda ()
      (projectile-invalidate-cache nil)))

;; Vterm
(load! "vterm.el")

;; Obsidian
(load! "obsidian.el")

;; WSL specific stuff
(when (getenv "WSLENV")
  (let ((cmd-exe "/mnt/c/Windows/System32/cmd.exe")
        (cmd-args '("/c" "start")))
    (when (file-exists-p cmd-exe)
      (setq browse-url-generic-program  cmd-exe
            browse-url-generic-args     cmd-args
            browse-url-browser-function 'browse-url-generic
            search-web-default-browser 'browse-url-generic))))

(when (getenv "WSLENV")
  (shell-command-to-string "sudo rm -r /tmp/.X11-unix;ln -s /mnt/wslg/.X11-unix /tmp/.X11-unix"))
