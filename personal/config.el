(setq projectile-globally-ignored-directories
      (append '(".git" "node_modules" "bower_components") projectile-globally-ignored-directories))
(projectile-global-mode t)
(require 'prelude-helm-everywhere)
(setq exec-path (append exec-path '("/usr/local/bin/")))
(global-set-key (kbd "<home>") 'move-beginning-of-line)
(global-set-key (kbd "<end>") 'move-end-of-line)
(global-set-key (kbd "C-S-f") 'helm-projectile-ag)
(global-set-key [(super shift f)] 'helm-projectile-find-file)
(setq-default indent-tabs-mode nil)
(setq ruby-align-chained-calls nil)
(setq ruby-align-to-stmt-keywords t)
(setq ruby-deep-indent-paren nil)
(setq ruby-deep-indent-paren-style nil)
(setq ruby-deep-arglist nil)
(add-hook 'ruby-mode-hook
          (lambda ()
            (electric-pair-mode)))
(setq scss-compile-at-save nil)
(setq css-indent-offset 2)
(setq js-indent-level 2)
(defun my-bell-function ()
  (unless (memq this-command
        '(isearch-abort abort-recursive-edit exit-minibuffer
              keyboard-quit mwheel-scroll down up next-line previous-line
              backward-char forward-char))
    (ding)))
(setq ring-bell-function 'my-bell-function)

(add-to-list 'auto-mode-alist '("\\.hamlbars$" . haml-mode))
(add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.ru$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Guardfile$" . ruby-mode))

(defadvice ruby-indent-line (after unindent-closing-paren activate)
  "Indent sole parenthesis in loca's way."
  (let ((column (current-column))
        indent offset)
    (save-excursion
      (back-to-indentation)
      (let ((state (syntax-ppss)))
        (setq offset (- column (current-column)))
        (when (and (eq (char-after) ?\))
                   (not (zerop (car state))))
          (goto-char (cadr state))
          (setq indent (current-indentation)))))
    (when indent
      (indent-line-to indent)
            (when (> offset 0) (forward-char offset)))))
