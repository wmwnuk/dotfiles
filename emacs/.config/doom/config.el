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

(set-frame-parameter nil 'alpha-background 85)
(add-to-list 'default-frame-alist '(alpha-background . 85))

;; Editor settings
(setq display-line-numbers-type 'relative)
(setq-default tab-width 4)
(global-visual-line-mode t)
(pixel-scroll-precision-mode t)

(use-package blamer
  :bind (("C-c i" . blamer-show-commit-info))
  :defer 20
  :custom
  (blamer-idle-time 0.3)
  (blamer-min-offset 70)
  :custom-face
  (blamer-face ((t :foreground "#7a88cf"
                    :background "unspecified"
                    ;; :height 140
                    :italic t)))
  :config
  (global-blamer-mode 1))

(use-package! beacon
  :config
  (beacon-mode 1))

(require 'posframe)
(require 'vertico-posframe)
(vertico-posframe-mode 1)

(require 'dired-x)
  (setq dired-omit-files (concat dired-omit-files "\\|^.obsidian$\\|^.+.edtz$\\|^.trash$\\|^System Volume Information$\\|^$RECYCLE.BIN$\\|^.+.tmp$\\|^.stfolder$\\|^.stversions$\\|^$Temp$\\|^$Recycle.Bin$\\|^DumpStack.log$\\|^Recovery$\\|^$WinREAgent$\\|^NTUSER.+\\|^ntuser.+"))

(after! treemacs
  (treemacs-project-follow-mode t))

(with-eval-after-load 'treemacs

  (defun treemacs-ignore-obsidian (filename absolute-path)
    (or (string-equal filename ".obsidian")
        (string-equal filename ".trash")
        (string-equal filename ".projectile")
        (string-suffix-p ".edtz" absolute-path)))

  (add-to-list 'treemacs-ignored-file-predicates #'treemacs-ignore-obsidian))

(+global-word-wrap-mode +1)
(global-visual-line-mode +1)

(map! :after evil-collection :map evil-normal-state-map "<up>" 'evil-previous-visual-line)
(map! :after evil-collection :map evil-normal-state-map "<down>" 'evil-next-visual-line)
(map! :after evil-collection :map evil-normal-state-map "k" 'evil-previous-visual-line)
(map! :after evil-collection :map evil-normal-state-map "j" 'evil-next-visual-line)

;; change org link in dashboard
(plist-put (alist-get "Open org-agenda" +doom-dashboard-menu-sections nil nil 'equal)
           :action #'obsidian-daily-note)
(plist-put (alist-get "Open org-agenda" +doom-dashboard-menu-sections nil nil 'equal)
           :key "SPC n a")

;; No more smartparens
(smartparens-global-mode -1)
(remove-hook 'doom-first-buffer-hook #'smartparens-global-mode)

;; Search settings
(after! consult
  (setq consult-ripgrep-args "rg --hidden --no-ignore --null --line-buffered --color=never --max-columns=1000 --path-separator /\
   --smart-case --no-heading --with-filename --line-number --search-zip") ;; -g '!{.git,node_modules,.composer,generated,var}/'")) ;; FIXME
  (setq consult-fd-args "fd --color=never -i -u --no-ignore-vcs -H -E .git -E generated -E var -E node_modules --regex "))

(map! :leader
      (:prefix "r"
               "g" #'consult-ripgrep)
      )

(map! :leader
      (:prefix "f"
               "f" #'consult-fd
               "w" #'consult-ripgrep
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
              )
  :config (add-to-list 'copilot-major-mode-alist '("nxml" . "xml")))

(use-package! gptel
  :config
  (setq
   gptel-model "nous-hermes-2-mistral-dpo:latest"
   gptel-backend (gptel-make-ollama "Ollama"
                   :host "localhost:11434"
                   :stream t
                   :models '("nous-hermes-2-mistral-dpo:latest")))
  (gptel-make-ollama "Ollama"             ;Any name of your choosing
    :host "localhost:11434"               ;Where it's running
    :stream t
    :models '("nous-hermes-2-mistral-dpo:latest" "codegemma:7b" "codegemma:2b"
              "dolphin-mixtral:latest" "codellama:latest" "deepseek-coder:6.7b"
              "deepseek-coder:base" "dolphin-mistral:latest" "llama3:8b" "llama2:latest"
              "llama3:instruct" "mistral:latest" "openchat:latest" "phi3:latest"
              "zephyr:latest" "starcoder:latest" "gemma:latest" "nomic-embed-text:latest"
              "dolphin-llama3:8b" "primeagen:latest" "reaperbuddy:latest"))
  (map! :leader
        (:prefix ("e" . "gptel")
                 "a" #'gptel-send
                 :desc "Open chat buffer" "c" #'gptel
                 "i" #'gptel-menu
                 "x" #'gptel-abort)))

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

;; Wezterm
(defun +wezterm/split ()
  "Split wezterm"
  (interactive)
  (let ((directory (current-project-dir))
        (command (if (getenv "WSLENV") "wezterm.exe" "wezterm")))
  (shell-command-to-string (format "%s cli split-pane --percent 25 --cwd %s -- wsl" command directory))))

(defun +wezterm/vsplit ()
  "Vsplit wezterm"
  (interactive)
  (let ((directory (current-project-dir))
        (command (if (getenv "WSLENV") "wezterm.exe" "wezterm")))
  (shell-command-to-string (format "%s cli split-pane --right --percent 25 --cwd %s -- wsl" command directory))))

(defun +wezterm/lazygit ()
  "Start lazygit in wezterm"
  (interactive)
  (let ((directory (current-project-dir))
        (command (if (getenv "WSLENV") "wezterm.exe" "wezterm")))
  (shell-command-to-string (format "%s cli split-pane --right --percent 25 --cwd %s -- wsl lazygit" command directory))))

(map! :leader
      (:prefix "o"
               "w" #'+wezterm/split
               "W" #'+wezterm/vsplit
               "g" #'+wezterm/lazygit))
