{1 :OXY2DEV/markview.nvim
 :ft [:markdown]
 :dependencies [:nvim-tree/nvim-web-devicons
                :nvim-treesitter/nvim-treesitter]
 ;; markview reads options PER RENDERER: the previous top-level
 ;; headings/tables/checkboxes/code_blocks/block_quotes keys (and their
 ;; `preset` shortcuts) are ignored by this version — `presets.lua` is dead code
 ;; here. Everything below is what actually reaches the renderer.
 :opts {:preview {:icon_provider :devicons}
        :markdown {:block_quotes {:enable true
                                  ;; vault notes use Minimal's `> [!infobox]`;
                                  ;; unknown callouts keep the literal text and
                                  ;; get no background. Card look = preview +
                                  ;; icon + full-width `line_hl` (markview can't
                                  ;; draw a right border around quotes).
                                  :INFOBOX {:preview "󰋽 Infobox"
                                            :hl "MarkviewBlockQuoteNote"
                                            :icon "󰋽"
                                            :line_hl "MarkviewPalette5"}}}}}
