;; sidekick has no fullscreen layout: find its window (it tags vim.w.sidekick_cli)
;; and grow it to full width, remembering the previous width for the way back.
(fn panel-win []
  (var found nil)
  (each [_ w (ipairs (vim.api.nvim_list_wins))]
    (when (and (not found) (. (. vim.w w) :sidekick_cli))
      (set found w)))
  found)

(fn resize-win [win width]
  (let [cfg (vim.api.nvim_win_get_config win)]
    (if (= "" cfg.relative)
        (vim.api.nvim_win_set_width win width)
        (do
          (tset cfg :width width)
          (vim.api.nvim_win_set_config win cfg)))))

(fn toggle-max []
  (let [win (panel-win)]
    (if (not win)
        (vim.notify "sidekick: painel nao esta aberto" vim.log.levels.WARN)
        (let [cfg (vim.api.nvim_win_get_config win)
              float? (not= "" cfg.relative)
              cur (if float? cfg.width (vim.api.nvim_win_get_width win))
              max-w (if float? (math.floor (* vim.o.columns 0.95)) vim.o.columns)
              ;; state, not geometry: nvim settles a full-width split a few columns
              ;; short of `columns`, so a width test cannot tell max from not-max
              wvar (. vim.w win)]
          (if (. wvar :sidekick_maximized)
              (do
                (tset wvar :sidekick_maximized false)
                (resize-win win (or (. wvar :sidekick_prev_width) 88)))
              (do
                (tset wvar :sidekick_prev_width cur)
                (tset wvar :sidekick_maximized true)
                (resize-win win max-w)))))))

(local opts
       {:nes {:enabled false}
        ;; AI CLI panel. `hermes` is a custom tool (just a cmd);
        ;; `claude` ships with sidekick.
        :cli {:picker :snacks
              :watch true
              :win {:layout :right
                    :split {:width 88}
                    ;; usable from inside the panel (terminal + normal mode)
                    :keys {:fullscreen {1 :<M-z>
                                        2 (fn [_] (toggle-max))
                                        :mode "nt"
                                        :desc "toggle fullscreen"}
                           ;; <C-.> (sidekick default) never arrives inside tmux: TERM=xterm-256color
                           ;; means kitty stays in legacy encoding, so Ctrl+. is not encodable.
                           :hide_alt {1 :<M-h>
                                      2 :hide
                                      :mode "nt"
                                      :desc "hide the panel"}}}
              :tools {:claude {:cmd [:claude "--dangerously-skip-permissions"]}
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
        {1 :<leader>az
         2 #(toggle-max)
         :mode :n
         :desc "AI Fullscreen"}
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
