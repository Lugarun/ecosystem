;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Lukas Schmidt"
      user-mail-address "lfschmidt.me@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/projects/org/")
(setq org-agenda-files (directory-files-recursively "~/projects/org/" "\\.org$"))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
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
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
(after! mu4e
  (setq sendmail-program (executable-find "msmtp")
        send-mail-function #'smtpmail-send-it
        message-sendmail-f-is-evil t
        message-sendmail-extra-arguments '("--read-envelope-from")
        message-send-mail-function #'message-send-mail-with-sendmail))

(set-email-account! "gmail"
  '((mu4e-sent-folder       . "/Gmail/[Gmail]/Sent Mail")
    (mu4e-drafts-folder     . "/Gmail/[Gmail]/Drafts")
    (mu4e-trash-folder      . "/Gmail/[Gmail]/Bin")
    (mu4e-refile-folder     . "/Gmail/[Gmail]/All Mail")
    (smtpmail-smtp-user     . "lfschmidt.me@gmail.com")
    (user-mail-address      . "lfschmidt.me@gmail.com")    ;; only needed for mu < 1.4
    (mu4e-compose-signature . "---\nYours truly\nThe Baz"))
  t)

(set-email-account! "uwaterloo"
  '((mu4e-sent-folder       . "/Uwaterloo/Sent")
    (mu4e-drafts-folder     . "/Uwaterloo/Drafts")
    (mu4e-trash-folder      . "/Uwaterloo/Trash")
    (mu4e-refile-folder     . "/Uwaterloo/Inbox")
    (smtpmail-smtp-user     . "lfschmid@uwaterloo.ca")
    (user-mail-address      . "lfschmid@uwaterloo.ca")    ;; only needed for mu < 1.4
    (mu4e-compose-signature . "---\nYours truly\nThe Baz"))
  t)

(add-hook! 'doom-sync-pre-hook
  (or (not (getenv "DIRENV_DIR"))
      doom-auto-accept
      (y-or-n-p "doom env update: Direnv detected! Continue anyway?")
      (user-error "Aborted")))

(defvar +direnv--old-process-environment nil)
(defadvice! +direnv--persist-environment-in-org-babel-execution-a (orig-fn &rest args)
  :around #'org-babel-execute-src-block
  (if +direnv--old-process-environment
      (apply orig-fn args)
    (setq-default +direnv--old-process-environment (default-value 'process-environment)
                  process-environment process-environment)
    (unwind-protect (apply orig-fn args)
      (setq-default process-environment +direnv--old-process-environment
                    +direnv--old-process-environment nil))))
