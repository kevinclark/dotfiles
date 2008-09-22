(require 'color-theme)
(color-theme-initialize)
(load-file "~/.emacs.d/twilight-emacs/color-theme-twilight.el")
(color-theme-twilight)

(load-file "~/.emacs.d/ruby-mode.el")
(autoload 'ruby-mode "ruby-mode" "Major mode for editing ruby scripts." t)
(add-to-list auto-mode-alist '(".rb$" . ruby-mode))