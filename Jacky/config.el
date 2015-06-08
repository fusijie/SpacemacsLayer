;;; extensions.el --- Jacky Layer extensions File for Spacemacs
;;
;; Copyright (c) 2012-2014 Sylvain Benner
;; Copyright (c) 2014-2015 Sylvain Benner & Contributors
;;
;; Author: Sylvain Benner <sylvain.benner@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(setq-default cursor-type 'bar)

(setq  initial-frame-alist (quote ((fullscreen . maximized))))

(global-set-key (kbd "<s-left>") 'move-beginning-of-line)
(global-set-key (kbd "<s-right>") 'move-end-of-line)
(global-set-key (kbd "<s-down>") 'end-of-buffer)
(global-set-key (kbd "<s-up>") 'beginning-of-buffer)
(global-set-key (kbd "C-t") 'ansi-term)
(global-set-key (kbd "C-x C-d") 'dired)
(global-set-key (kbd "C-i") 'youdao-dictionary-search-at-point+)

(setq auto-mode-alist
      (append
       '(("CMakeLists\\.txt\\'" . cmake-mode))
       '(("\\.cmake\\'" . cmake-mode))
       auto-mode-alist))

(set-face-attribute 'region nil :background "#00FFFF" :foreground "#000000")
(global-visual-line-mode t)
(setq inhibit-splash-screen t)
(setq initial-scratch-message nil)
(global-linum-mode t)
(tool-bar-mode -1)
(delete-selection-mode 1)
(scroll-bar-mode -1)
(transient-mark-mode 1)
(show-paren-mode 1)
(setq show-paren-style 'expression)
(column-number-mode 1)
(global-hl-line-mode 1)

(setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil)))
(setq mouse-wheel-progressive-speed nil)
(electric-pair-mode 1)

(defadvice kill-ring-save (before slickcopy activate compile)
  (interactive
     (if mark-active (list (region-beginning) (region-end))
       (list (line-beginning-position)
          (line-beginning-position 2)))))
(defadvice kill-region (before slickcut activate compile)
   (interactive
     (if mark-active (list (region-beginning) (region-end))
       (list (line-beginning-position)
             (line-beginning-position 2)))))
(global-set-key (kbd "s-d") 'kill-region)

(setq system-uses-terminfo nil)

(defun my-term-hook ()
  (goto-address-mode)
  (define-key term-raw-map "\C-y" 'my-term-paste)
  (let ((base03  "#002b36")
        (base02  "#073642")
        (base01  "#586e75")
        (base00  "#657b83")
        (base0   "#839496")
        (base1   "#93a1a1")
        (base2   "#eee8d5")
        (base3   "#fdf6e3")
        (yellow  "#b58900")
        (orange  "#cb4b16")
        (red     "#dc322f")
        (magenta "#d33682")
        (violet  "#6c71c4")
        (blue    "#268bd2")
        (cyan    "#2aa198")
        (green   "#859900"))
    (setq ansi-term-color-vector
          (vconcat `(unspecified ,base02 ,red ,green ,yellow ,blue
                                 ,magenta ,cyan ,base2)))))

(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

(defadvice term-sentinel (around my-advice-term-sentinel (proc msg))
  (if (memq (process-status proc) '(signal exit))
      (let ((buffer (process-buffer proc)))
        ad-do-it
        (kill-buffer buffer))
    ad-do-it))
(ad-activate 'term-sentinel)

(defvar my-term-shell "/bin/zsh")
(defadvice ansi-term (before force-bash)
  (interactive (list my-term-shell)))
(ad-activate 'ansi-term)


(defadvice split-window (after move-point-to-new-window activate)
  "Moves the point to the newly created window after splitting."
  (other-window 1))

