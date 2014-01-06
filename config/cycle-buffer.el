(autoload 'cycle-buffer                     "cycle-buffer"
  "Cycle forward." t)
(autoload 'cycle-buffer-backward            "cycle-buffer"
  "Cycle backward." t)
(autoload 'cycle-buffer-permissive          "cycle-buffer"
  "Cycle forward allowing *buffers*." t)
(autoload 'cycle-buffer-backward-permissive "cycle-buffer"
  "Cycle backward allowing *buffers*." t)
(autoload 'cycle-buffer-toggle-interesting  "cycle-buffer"
  "Toggle if this buffer will be considered." t)
(global-set-key [(f9)]        'cycle-buffer-backward)
(global-set-key [(f10)]       'cycle-buffer)
(global-set-key [(shift f9)]  'cycle-buffer-backward-permissive)
(global-set-key [(shift f10)] 'cycle-buffer-permissive)
