[]
; (local {: g} (require :config.utils))
;
; (local opts {:panel {:auto-refresh true
;                      :keymap {:open :<Space>gc :refresh :gr}}
;              :suggestion {:auto_trigger true :keymap {:accept :<C-l> :dismiss :<C-h> :next :<C-k> :prev :<C-j>}}
;              
;              :filetypes ["*" true]})
;
; [{1 :zbirenbaum/copilot.lua
;   :cmd :Copilot
;   :event :InsertEnter
;   :config (fn []
;             (let [copilot (require :copilot)]
;               (copilot.setup opts)))}]
;
