;; agent-radar — managed by agent-radar/install.sh
;; jump to Claude/Hermes sessions: <leader>ar or :Radar
[{:dir "~/dev/ade/agent-radar"
  :name :agent-radar
  :main :agent-radar
  ;; `radar jump` calls into the plugin over --remote-expr, keep it loaded
  :lazy false
  :opts {}
  :keys [{1 :<leader>ar 2 "<cmd>Radar<cr>" :mode :n :desc "Agent radar"}]}]
