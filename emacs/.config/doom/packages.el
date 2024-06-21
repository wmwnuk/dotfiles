;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

(package! vimrc-mode)
(package! ellama)
(package! prettier-js)
(package! add-node-modules-path)
(package! blamer)
(package! copilot
  :recipe (:host github :repo "zerolfx/copilot.el" :files ("*.el" "dist")))
(package! solaire-mode :disable t)
(package! obsidian)
(package! beacon)
(package! transient :pin "4f0fe22cafb6c2c8c8749a9037351ed01cf121ef")
