(local {: g} (require :config.utils))

(local opts {:panel {:enabled false}
             :suggestion {:enabled false}
             :filetypes ["*" true]})

[{1 :zbirenbaum/copilot.lua
  :cmd :Copilot
  :event :InsertEnter
  :config (fn []
            (let [copilot (require :copilot)]
              (copilot.setup opts)))}]

