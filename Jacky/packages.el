;;; packages.el --- Jacky Layer packages File for Spacemacs
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

;; List of all packages to install and/or initialize. Built-in packages
;; which require an initialization must be listed explicitly in the list.
(setq Jacky-packages
    '(
      ;; package Jackys go here
      swiper
      markdown-mode
      youdao-dictionary
      ))

;; List of packages to exclude.
(setq Jacky-excluded-packages '())


(defun Jacky/post-init-markdown-mode()
  (use-package markdown-mode
    :defer t
    :config
    (progn
      (defun Jacky/markdown-to-html ()
        (interactive)
        (start-process "grip" "*gfm-to-html*" "grip" (buffer-file-name)

                       )
        (browse-url (format  "http://localhost:5000/%s" (buffer-name))))

      (define-key markdown-mode-map (kbd "s-r") 'Jacky/markdown-to-html)
     )))


(defun Jacky/init-swiper()
  (use-package swiper
    :defer t
    :init
    (global-set-key (kbd "C-s") 'swiper)))

(defun Jacky/init-youdao-dictionary()
  (use-package youdao-dictionary
    :defer t
    :init
   ))
