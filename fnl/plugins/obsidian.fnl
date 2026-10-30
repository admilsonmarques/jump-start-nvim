;; Obsidian vault work in Neovim: dataview (DQL) fences rendered inline.
;;
;; Division of labour, so markview keeps the look it always had:
;;   - markview.nvim renders headings/tables/quotes/checkboxes (fnl/plugins/markview.fnl)
;;   - render-markdown.nvim runs ONLY as the host for obsidian-query's fence handler,
;;     with every builtin decoration disabled
;;   - obsidian-query.nvim draws the ```dataview / ```query results
(local md [:markdown])

[{1 :obsidian-nvim/obsidian.nvim
  :version false
  :ft md
  :dependencies [:nvim-lua/plenary.nvim]
  :init (fn []
          (let [(ok? patch) (pcall require :config.obsidian_patch)]
            (when ok? (patch.apply))))
  :opts {:legacy_commands false
         :picker {:name :snacks.picker}
         :workspaces [{:name :rpg
                       :path "/home/adba/dev/ade/brain-rpg/duelo-de-dragões"}]
         :cache {:enabled true}
         ;; obsidian.nvim's own in-buffer decorations would double up with
         ;; markview's
         :ui {:enable false}}}

 {1 :MeanderingProgrammer/render-markdown.nvim
  :ft md
  :dependencies [:nvim-treesitter/nvim-treesitter
                 :nvim-tree/nvim-web-devicons]
  :opts (fn [_ opts]
          ;; markview draws everything; render-markdown must not decorate anything,
          ;; it is here only because it is the API obsidian-query hooks into.
          ;; NB: callout is a map of callout definitions, not a section with an
          ;; `enabled` flag — setting it to {enabled=false} crashes render-markdown.
          (each [_ k (ipairs [:heading :bullet :checkbox :quote :dash :pipe_table
                              :code :link :latex :indent :inline_highlight])]
            (tset opts k {:enabled false}))
          (set opts.custom_handlers (or opts.custom_handlers {}))
          (tset opts.custom_handlers :markdown (. (require :obsidian-query) :handler))
          (tset opts.custom_handlers :markdown_inline (. (require :obsidian-query.inline) :handler))
          ;; render-markdown's default is concealcursor='' while rendering, which
          ;; un-hides the raw text of whatever line the cursor is on; markview
          ;; keeps the cursor line rendered in normal/command mode ("nc")
          (set opts.win_options {:concealcursor {:default ""
                                                :rendered "nc"}}))}

 {1 :dpezto/obsidian-query.nvim
  :ft md
  :dependencies [:obsidian.nvim :render-markdown.nvim]
  ;; max_inline_rows defaults to 12; this vault has a 70-row table (Ameaças)
  :opts {:picker {:style :rich}
         :max_inline_rows math.huge}
  :config (fn [_ opts]
            (let [oq (require :obsidian-query)
                  devicons (require :nvim-web-devicons)]
              ;; a custom `config` replaces lazy's default opts-driven setup, so
              ;; the plugin has to be set up by hand here
              (oq.setup opts)
              ;; clicking a rendered table row opens that note (upstream only
              ;; supports calendar clicks); see lua/config/obsidian_query_patch.lua
              (let [(ok? rowclick) (pcall require :config.obsidian_query_patch)]
                (when ok? (rowclick.apply)))
              ;; obsidian-query registers 󰆼 for the `dataview` language; swap back
              ;; to the glyph markview used for unknown languages so the fence
              ;; chrome looks exactly like it did before
              (devicons.set_icon {:dataview {:icon "󰻺"
                                             :color "#6d8086"
                                             :cterm_color "66"
                                             :name "Dataview"}})))}]
