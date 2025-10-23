(local opts {:behavior {:auto_start_server true}})

(local keys [])

[{1 :editor-code-assistant/eca-nvim
  :dependencies [:nvim-lua/plenary.nvim :MunifTanjim/nui.nvim]
  : keys
  : opts
  ; :config (fn []
  ;           (let [eca (require :eca)]
  ;             (eca.setup ops)))
  :lazy false}]
