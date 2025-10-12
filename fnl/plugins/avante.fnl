(local {: g} (require :config.utils))

(local opts {:provider :internal
             :providers {:copilot {:endpoint "https://api.github.com"
                                   :model :gpt-4o-2024-05-13
                                   :proxy nil
                                   :allow_insecure false
                                   :timeout 30000}
                         :internal {:endpoint "https://ist-prod-litellm.nullmplatform.com/"
                                    :__inherited_from :openai
                                    :model :gpt-4o-2024-08-06
                                    :api_key_name :LITELLM_KEY
                                    :timeout 30000}
                         :gemini {:model :gemini-2.5-flash}}
             :behaviour {:auto_suggestions true
                         :auto_set_highlight_group true
                         :auto_set_keymaps true
                         :auto_apply_diff_after_generation false
                         :support_paste_from_clipboard true
                         :minimize_diff true
                         :enable_token_counting true}
             :mappings {:diff {:ours :co
                               :theirs :ct
                               :all_theirs :ca
                               :both :cb
                               :cursor :cc
                               :next "]x"
                               :prev "[x"}
                        :suggestion {:accept :<M-l>
                                     :next "<M-]>"
                                     :prev "<M-[>"
                                     :dismiss "<C-]>"}
                        :jump {:next "]]" :prev "[["}
                        :submit {:normal :<CR> :insert :<C-s>}
                        :sidebar {:apply_all :A
                                  :apply_cursor :a
                                  :switch_windows :<Tab>
                                  :reverse_switch_windows :<S-Tab>}}
             :hints {:enabled true}
             :windows {:position :right
                       :wrap true
                       :width 30
                       :sidebar_header {:enabled true
                                        :align :center
                                        :rounded true}}
             :highlights {:diff {:current :DiffText :incoming :DiffAdd}}
             :selector {:provider :telescope :provider_opts {}}})

[{1 :yetone/avante.nvim
  :event :VeryLazy
  :version false
  :build "make BUILD_FROM_SOURCE=true"
  :dependencies [:nvim-lua/plenary.nvim
                 :MunifTanjim/nui.nvim
                 :nvim-telescope/telescope.nvim
                 :hrsh7th/nvim-cmp
                 :nvim-tree/nvim-web-devicons
                 :zbirenbaum/copilot.lua
                 {1 :HakonHarnes/img-clip.nvim
                  :event :VeryLazy
                  :opts {:default {:embed_image_as_base64 false
                                   :prompt_for_file_name false
                                   :drag_and_drop {:insert_mode true}
                                   :use_absolute_path true}}}
                 {1 :MeanderingProgrammer/render-markdown.nvim
                  :opts {:file_types [:markdown :Avante]}
                  :ft [:markdown :Avante]}]
  :keys [{1 :<leader>aa 2 :<cmd>AvanteAsk<cr> :desc "avante: ask"}
         {1 :<leader>ar 2 :<cmd>AvanteRefresh<cr> :desc "avante: refresh"}
         {1 :<leader>ae
          2 :<cmd>AvanteEdit<cr>
          :desc "avante: edit"
          :mode [:n :v]}
         {1 :<leader>at 2 :<cmd>AvanteToggle<cr> :desc "avante: toggle"}
         {1 :<leader>af 2 :<cmd>AvanteFocus<cr> :desc "avante: focus"}
         {1 :<leader>ac 2 :<cmd>AvanteClear<cr> :desc "avante: clear"}
         {1 :<leader>as 2 :<cmd>AvanteStop<cr> :desc "avante: stop"}
         {1 :<leader>ah 2 :<cmd>AvanteHistory<cr> :desc "avante: history"}]
  :config (fn []
            (let [avante (require :avante)]
              (avante.setup opts)))}]
