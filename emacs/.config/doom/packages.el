;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

(package! vimrc-mode :pin "13bc150a870d5d4a95f1111e4740e2b22813c30e")
(package! gptel :pin "a834adbcba46197f4a59b0208e48dd3e80f15c46")
(package! prettier-js :pin "e9b73e81d3e1642aec682195f127a42dfb0b5774")
(package! add-node-modules-path :pin "841e93dfed50448da66c89a977c9182bb18796a1")
(package! copilot
  :recipe (:host github :repo "copilot-emacs/copilot.el" :files ("*.el" "dist")) :pin "733bff26450255e092c10873580e9abfed8a81b8")
(package! obsidian :pin "5aeb88cec9814be2b0b047453d797a29628b5a91")
(package! beacon :pin "85261a928ae0ec3b41e639f05291ffd6bf7c231c")
(package! transient :pin "4f0fe22cafb6c2c8c8749a9037351ed01cf121ef")
(package! vertico-posframe :pin "6c3d0d900cb6e6554a1552ed93b84b0c4a78d015")
(package! solaire-mode :disable t)
