# Jump Start Nvim

A Neovim configuration written in **Fennel** (a Lisp that compiles to Lua), using **lazy.nvim** as the plugin manager and **NFNL** for Fennel compilation.

> Inspired by [ThePrimeagen's Neovim RC From Scratch](https://www.youtube.com/watch?v=w7i4amO_zaE) with significant additions and personal tweaks.

---

## Architecture

| Directory | Purpose |
|-----------|---------|
| `fnl/` | Fennel source files (edit these) |
| `lua/` | Auto-generated Lua (compiled by NFNL on save) |
| `fnl/config/` | Core config: options, keymaps, autocmds, utils |
| `fnl/plugins/` | One file per plugin |
| `init.fnl` | Entry point |

**Never edit `lua/` files directly** — they are overwritten by NFNL whenever the corresponding `.fnl` file is saved in Neovim.

---

## Features

### Editor
- **Fennel** configuration language via [NFNL](https://github.com/Olical/nfnl) — Lisp with full Lua interop
- **lazy.nvim** plugin manager with lockfile (`lazy-lock.json`)
- **Treesitter** — syntax highlighting, indentation, and rainbow delimiters
- **Which-key** — interactive keymap discovery on leader press
- **Noice** — fully replaced command line, messages, and LSP UI
- **Undotree** — persistent undo history browser
- **Mini Pairs** — auto-close brackets and quotes
- **Surround** — add/change/delete surrounding characters (`ys`, `ds`, `cs`)
- **Comment.nvim** — toggle comments with `gc` / `gb`

### LSP & Completion
- **lsp-zero** — zero-config LSP setup
- **Mason** — LSP server installer
- **nvim-cmp** — autocompletion with LuaSnip snippets
- **Configured servers**: `clojure_lsp`, `ts_ls`, `fennel_language_server`, `lua_ls`, `jqls`, `yamlls`, `pyright`, `bashls`, `jsonls`, `cssls`, `html`, `marksman`
- **Trouble** — pretty diagnostics list
- **Conform** — code formatting on `<localleader>f`

### Navigation & Search
- **Telescope** — fuzzy finder for files, grep, keymaps, commands
- **nvim-tree** — file explorer sidebar
- **Harpoon** — quick file marks (via Telescope extension)
- **Spectre** — project-wide find & replace

### Git
- **Gitsigns** — inline hunk indicators, stage/reset/blame
- **Diffview** — side-by-side diff viewer
- **Git-conflict** — conflict resolution helpers (`co`, `ct`, `cb`, `cx`)
- **Open on Git** — open current file/line/repo on GitHub

### AI
- **ECA (Editor Code Assistant)** — AI chat, context management, model/behavior selection
- **Copilot** — inline suggestions (`<C-l>` to accept)

### Clojure / Lisp
- **Conjure** — interactive REPL evaluation, log management, test runner
- **CIDER jack-in** — automatic nREPL start with dependency injection
- **FlowStorm** — time-travel debugger integration (via `:storm` Leiningen profile)
- **vim-jack-in** — additional REPL jack-in support

### UI
- **Lualine** — statusline
- **Bufferline** — buffer tabs
- **Alpha** — dashboard / home screen
- **Themery** — live theme switcher
- **Colorizer** — inline color preview
- **Illuminate** — highlight other uses of word under cursor
- **Baleia** — ANSI color rendering in buffers
- **Statuscol** — custom status column with fold indicators
- **Transparent** — toggle background transparency

### Terminal
- **Toggleterm** — floating, horizontal, and vertical terminal windows

---

## Key Bindings

> `<leader>` = **Space** · `<localleader>` = **Comma**

### Global

| Key | Action |
|-----|--------|
| `<C-s>` | Save file |
| `<C-h/j/k/l>` | Navigate windows |
| `<C-m>` / `<C-i>` | Previous / next buffer |
| `<C-d>` / `<C-u>` | Scroll down / up (centered) |
| `<S-h>` / `<S-l>` | Previous / next buffer tab |
| `<C-S-s>` / `<C-S-t>` | Horizontal / vertical split |
| `<C-S-h/k/l>` | Previous tab / close tab / next tab |
| `<C-S-↑↓←→>` | Resize window |
| `jk` | Exit insert/command/terminal mode |
| `<` / `>` | Indent left / right (stay in visual) |
| `J` / `K` | Move selection up / down (visual block) |
| `-` | Open netrw file explorer |

### Leader Keys

#### Find (`<leader>f`)
| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>ft` | Live grep (text search) |
| `<leader>fS` | Search word under cursor |
| `<leader>fl` | Resume last search |
| `<leader>fp` | Projects |
| `<leader>fr` | Recent files |
| `<leader>fk` | Keymaps |
| `<leader>fC` | Commands |
| `<leader>fT` | Find TODOs |

#### Git (`<leader>g`)
| Key | Action |
|-----|--------|
| `<leader>gd` | Diffview open |
| `<leader>gD` | Diffview close |
| `<leader>go` | Open file on GitHub |
| `<leader>gl` | Open current line on GitHub |
| `<leader>gr` | Open repo on GitHub |

#### Git Hunk (`<leader>h`)
| Key | Action |
|-----|--------|
| `]h` / `[h` | Next / prev hunk |
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |
| `<leader>hp` | Preview hunk |
| `<leader>hb` | Blame line |
| `<leader>hd` | Diff this |

#### Diagnostic (`<leader>d`)
| Key | Action |
|-----|--------|
| `<leader>dd` | Trouble toggle |
| `<leader>dt` | Telescope diagnostics |

#### Replace (`<leader>r`)
| Key | Action |
|-----|--------|
| `<leader>rs` | Spectre toggle |
| `<leader>rf` | Spectre file search |
| `<leader>rw` | Spectre word search |
| `<leader>rr` | LSP rename symbol |

#### AI (`<leader>a`)
| Key | Action |
|-----|--------|
| `<leader>ac` | ECA chat |
| `<leader>at` | ECA toggle |
| `<leader>af` | ECA focus |
| `<leader>ax` | ECA close |
| `<leader>aaf` | Add current file as context |
| `<leader>aas` | Add selection as context |
| `<leader>ass` | Start ECA server |
| `<leader>asx` | Stop ECA server |
| `<leader>asm` | Select model |
| `<leader>asb` | Select behavior |

#### Terminal (`<leader>t`)
| Key | Action |
|-----|--------|
| `<leader>tf` | Float terminal |
| `<leader>th` | Horizontal terminal |
| `<leader>tv` | Vertical terminal |
| `<M-1>` | Horizontal terminal (quick) |
| `<M-2>` | Vertical terminal (quick) |
| `<M-3>` | Float terminal (quick) |
| `<C-\>` | Toggle terminal |

#### Settings (`<leader>x`)
| Key | Action |
|-----|--------|
| `<leader>xr` | Recompile all Fennel files |
| `<leader>xn` | Notifications (Noice) |

#### Themes (`<leader>T`)
| Key | Action |
|-----|--------|
| `<leader>TT` | Themery (live theme picker) |
| `<leader>Tt` | Toggle transparency |

#### Misc
| Key | Action |
|-----|--------|
| `<leader>e` | Toggle file explorer (nvim-tree) |
| `<leader>u` | Toggle undotree |
| `<leader>q` | Close buffer |
| `<leader>L` | LSP info |
| `<leader>;` | Home (dashboard) |
| `]t` / `[t` | Next / prev TODO comment |

---

### LSP (buffer-local, on attach)

| Key | Action |
|-----|--------|
| `<localleader>d` | Go to definition |
| `<localleader>k` | Hover documentation |
| `<localleader>a` | Code action |
| `<localleader>r` | References |
| `<localleader>i` | Implementation |
| `<localleader>D` | Float diagnostic |
| `<localleader>h` | Toggle inlay hints |
| `<localleader>xx` | Trouble diagnostics |
| `<localleader>xX` | Trouble buffer diagnostics |
| `<localleader>f` | Format buffer |

### Completion (nvim-cmp)

| Key | Action |
|-----|--------|
| `<C-n>` / `<C-p>` | Next / prev item |
| `<CR>` | Confirm |
| `<C-e>` | Abort |
| `<C-u>` / `<C-d>` | Scroll docs |
| `<C-f>` / `<C-b>` | Snippet jump forward / back |

### Copilot

| Key | Action |
|-----|--------|
| `<C-l>` | Accept suggestion |
| `<C-h>` | Dismiss suggestion |
| `<C-k>` / `<C-j>` | Previous / next suggestion |

---

### Clojure / Conjure (`<localleader>`)

#### Connection (`<localleader>c`)
| Key | Action |
|-----|--------|
| `<localleader>cc` | Jack-in (CIDER deps) |
| `<localleader>c!` | Jack-in with test profiles |
| `<localleader>cF` | Jack-in with FlowStorm |
| `<localleader>cC` | Jack-in on specific port |
| `<localleader>cn` | Connect |
| `<localleader>cd` | Disconnect |
| `<localleader>cs` | Connection status |

#### Evaluate (`<localleader>e`)
| Key | Action |
|-----|--------|
| `<localleader>ee` | Evaluate current form |
| `<localleader>er` | Evaluate root form |
| `<localleader>ef` | Evaluate file |
| `<localleader>eb` | Evaluate buffer |
| `<localleader>em` | Evaluate motion |
| `gd` / `<C-]>` | Go to definition |
| `K` | Show documentation |
| `gD` | View source |

#### Test (`<localleader>t`)
| Key | Action |
|-----|--------|
| `<localleader>tt` | Run current test |
| `<localleader>tn` | Run namespace tests |
| `<localleader>ta` | Run all tests |
| `<localleader>tr` | Refresh tests |

#### Log (`<localleader>l`)
| Key | Action |
|-----|--------|
| `<localleader>ls` | Log split |
| `<localleader>lv` | Log vsplit |
| `<localleader>lt` | Log tab |
| `<localleader>lq` | Close log |
| `<localleader>lr` | Log reset (soft) |
| `<localleader>lR` | Log reset (hard) |

#### Search (`<localleader>s`)
| Key | Action |
|-----|--------|
| `<localleader>sp` | Search project (grep) |
| `<localleader>sf` | Search files |

#### FlowStorm (`<localleader>F`, Clojure buffers only)
| Key | Action |
|-----|--------|
| `<localleader>Fc` | Connect FlowStorm GUI |
| `<localleader>Fd` | Disconnect (keep REPL) |
| `<localleader>Fq` | Quit (stop GUI + kill REPL) |
| `<localleader>Fs` | Start recording |
| `<localleader>Fp` | Stop recording |
| `<localleader>Fr` | Reset traces |

#### Diagnostics (`<localleader>x`)
| Key | Action |
|-----|--------|
| `<localleader>xx` | Trouble diagnostics |
| `<localleader>xX` | Trouble buffer diagnostics |

---

## FlowStorm Workflow

FlowStorm is a time-travel debugger for Clojure. Requires the `:storm` profile in `~/.lein/profiles.clj`:

```clojure
:storm {:dependencies [[com.github.flow-storm/clojure "1.12.4"]
                       [com.github.flow-storm/flow-storm-dbg "4.5.9"]]
        :exclusions [org.clojure/clojure]}
```

Also set the instrumentation prefix in your project (or profile):
```
-Dclojure.storm.instrumentOnlyPrefixes=your.namespace.prefix
```

**Typical session:**
1. `<localleader>cF` — jack-in with FlowStorm (disconnects existing REPL first, waits ~9s)
2. `<localleader>Fs` — start recording
3. Eval your code (`<localleader>ef`, `<localleader>ee`, etc.)
4. Explore execution in the FlowStorm GUI window
5. `<localleader>Fq` — quit and kill the REPL when done

---

## Themes

Available themes (switch with `<leader>TT`):
- Catppuccin, Dracula, Kanagawa, Rose Pine, Tokyo Night

---

## References

- [ThePrimeagen Init.Lua](https://github.com/ThePrimeagen/init.lua)
- [Olical's dotfiles](https://github.com/Olical/dotfiles)
- [RafaelDelboni's cajus-nfnl](https://github.com/rafaeldelboni/cajus-nfnl)
- [lazy.nvim](https://github.com/folke/lazy.nvim)
- [NFNL](https://github.com/Olical/nfnl)
