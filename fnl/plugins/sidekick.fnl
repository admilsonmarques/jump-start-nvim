(local opts
       {:nes {:enabled false}
        ;; AI CLI panel. `hermes` is a custom tool (just a cmd);
        ;; `claude` ships with sidekick.
        :cli {:picker :snacks
              :watch true
              :win {:layout :right
                    :split {:width 88}}
              :tools {:claude {}
                      :hermes {:cmd [:hermes]}}}})

(fn toggle [name]
  (let [cli (require :sidekick.cli)]
    (cli.toggle {:name name :focus true})))

(local keys
       [{1 :<leader>ac
         2 #(toggle :claude)
         :mode :n
         :desc "Claude Code"}
        {1 :<leader>ah
         2 #(toggle :hermes)
         :mode :n
         :desc "Hermes"}
        {1 :<leader>as
         2 #(let [cli (require :sidekick.cli)]
             (cli.select {:filter {:installed true}}))
         :mode :n
         :desc "Select CLI"}
        {1 :<leader>ad
         2 #(let [cli (require :sidekick.cli)] (cli.close))
         :mode :n
         :desc "Detach CLI"}
        {1 :<leader>af
         2 #(let [cli (require :sidekick.cli)] (cli.send {:msg "{file}"}))
         :mode :n
         :desc "Send File"}
        {1 :<leader>av
         2 #(let [cli (require :sidekick.cli)] (cli.send {:msg "{selection}"}))
         :mode :x
         :desc "Send Selection"}
        {1 :<leader>ap
         2 #(let [cli (require :sidekick.cli)] (cli.prompt))
         :mode [:n :x]
         :desc "AI Prompts"}])

[{1 :folke/sidekick.nvim
  :keys keys
  :opts opts}]
