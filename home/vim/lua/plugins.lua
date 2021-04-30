-- vi: foldmethod=marker
ruby_filetypes = {"ruby", "eruby", "slim", "haml", "rspec"}

local packer = nil

local function init()
    if packer == nil then
        packer = require('packer')
        util = require("packer/util")
        packer.init({
            compile_path = util.join_paths(vim.fn.stdpath("config"),
                                           "vimscript", "packer_compiled.vim"),
            max_jobs = 10
        })
    end

    local use = packer.use
    packer.reset()

    use {"wbthomason/packer.nvim", opt = true}

    use {"tpope/vim-unimpaired"}

    use {"jrudess/vim-foldtext"}

    use {
        "AndrewRadev/deleft.vim",
        cmd = {"Deleft"},
        config = function() vim.g.deleft_remove_strategy = "comment" end
    }

    use {"AndrewRadev/rails_extra.vim", ft = ruby_filetypes}

    use {
        "AndrewRadev/splitjoin.vim",
        cmd = {"SplitjoinSplit", "SplitjoinJoin"},
        config = function()
            vim.g.splitjoin_split_mapping = ""
            vim.g.splitjoin_join_mapping = ""
            vim.g.splitjoin_align = 1
        end
    }

    use {
        "AndrewRadev/switch.vim",
        cmd = {"Switch", "SwitchReverse"},
        config = function()
            vim.g.switch_custom_definitions =
                {
                    {"assert", "refute"}, {"if", "unless"}, {"[ ]", "[x]"},
                    {"yes", "no"}, {"let g:", "vim.g."},
                    {
                        "\\([^. ]\\+\\)\\.should\\(_not\\|\\)': 'expect(\\1)\\.to\\2"
                    },
                    {
                        "expect(\\([^. ]\\+\\))\\.to\\(_not\\|\\)': '\\1.should\\2"
                    }
                }
        end
    }

    use {
        "SidOfc/mkdx",
        ft = "markdown",
        config = function()
            vim.api.nvim_set_var("mkdx#settings", {
                highlight = {enable = 1},
                checkbox = {toggles = {" ", "x"}},
                enter = {shift = 1},
                restore_visual = 1,
                links = {external = {enable = 1}},
                toc = {text = "Table of Contents", update_on_write = 1},
                fold = {enable = 1},
                map = {prefix = "<localleader>m"}
            })
        end
    }

    use {"rstacruz/vim-xtract", cmd = {'Xtract'}}

    use {
        "AndrewRadev/sideways.vim",
        keys = {
            "<Plug>SidewaysArgumentAppendAfter",
            "<Plug>SidewaysArgumentInsertFirst",
            "<Plug>SidewaysArgumentTextobjA", "<Plug>SidewaysArgumentTextobjI"
        }
    }

    use {
        "ruanyl/vim-gh-line",
        keys = {"<Plug>(gh-line)", "<Plug>(gh-line-blame)"},
        config = function()
            vim.g.gh_line_map_default = 0
            vim.g.gh_line_blame_map_default = 0
        end
    }

    use {
        "kana/vim-textobj-user",
        requires = {
            "coderifous/textobj-word-column.vim", "kana/vim-textobj-entire",
            "kana/vim-textobj-indent", "kana/vim-textobj-line",
            "kana/vim-textobj-user", "jceb/vim-textobj-uri",
            "somini/vim-textobj-fold", "glts/vim-textobj-indblock"
        }
    }

    -- COLORSCHEMES {{{
    use {
        "tiagovla/tokyodark.nvim",
        config = function()
            vim.g.tokyonight_enable_italic = true
            vim.g.tokyonight_enable_italic_comment = true
        end
    }

    use {
        "folke/tokyonight.nvim",
        config = function()
            vim.g.tokyonight_style = "night"
            vim.g.tokyonight_dark_sidebar = true
        end
    }
    -- use {"pineapplegiant/spaceduck"}
    -- use {
    --     "mhartington/oceanic-next",
    --     config = function()
    --         vim.g.oceanic_next_terminal_bold = 1
    --         vim.g.oceanic_next_terminal_italic = 1
    --     end
    -- }
    -- use {"kyazdani42/blue-moon"}
    -- use {"eemed/sitruuna.vim"}
    -- use {"pgavlin/pulumi.vim"}
    -- use {"cocopon/iceberg.vim"}
    -- use {"flrnd/plastic.vim"}
    -- use {"whatyouhide/vim-gotham"}
    -- use {"xolox/vim-colorscheme-switcher"}
    -- use {"xolox/vim-misc"}
    -- }}} COLORSCHEMES

    use {
        "airblade/vim-gitgutter",
        config = function()
            vim.g.gitgutter_sign_added = "│"
            vim.g.gitgutter_sign_modified = "│"
            vim.g.gitgutter_sign_removed = "│"
            vim.g.gitgutter_sign_removed_first_line = "│"
            vim.g.gitgutter_sign_modified_removed = "│"

            -- vim.g.gitgutter_sign_added              = '▓'
            -- vim.g.gitgutter_sign_modified           = '▓'
            -- vim.g.gitgutter_sign_modified_removed   = '▓'
            -- vim.g.gitgutter_sign_removed            = '▓'
            -- vim.g.gitgutter_sign_removed_first_line = '▓'

            vim.g.gitgutter_map_keys = 0
            vim.g.gitgutter_set_sign_backgrounds = 1
            vim.g.gitgutter_realtime = 0
            vim.g.gitgutter_eager = 0
            vim.g.gitgutter_grep = "rg"
            vim.g.gitgutter_preview_win_floating = 1
            -- cool boxes, for reference: ░▒▓
        end
    }

    use {
        "camspiers/animate.vim",
        config = function()
            vim.api.nvim_set_var("animate#distribute_space", 0)
            vim.api.nvim_set_var("animate#duration", 150.0)
            vim.api.nvim_set_var("animate#easing_func",
                                 "animate#ease_in_out_sine")
        end
    }

    use {
        "camspiers/lens.vim",
        config = function()
            vim.api.nvim_set_var("lens#disabled_filetypes",
                                 {"help", "fzf", "vista"})
            vim.api.nvim_set_var("lens#animate", 0)
        end
    }

    use {
        "ntpeters/vim-better-whitespace",
        config = function()
            vim.g.better_whitespace_enabled = 1
            vim.g.strip_whitespace_on_save = 1
            vim.g.strip_whitespace_confirm = 0
            vim.g.better_whitespace_filetypes_blacklist =
                {"diff", "gitcommit", "qf", "help", "markdown", "packer"}
        end
    }

    use {
        "norcalli/nvim-colorizer.lua",
        config = function() require"colorizer".setup() end
    }

    use {
        "akinsho/nvim-bufferline.lua",
        config = function()
            require"bufferline".setup {
                options = {
                    view = "multiwindow",
                    numbers = "buffer_id",
                    number_style = "superscript",
                    mappings = false,
                    buffer_close_icon = '',
                    modified_icon = '●',
                    close_icon = '',
                    left_trunc_marker = "",
                    right_trunc_marker = "",
                    max_name_length = 18,
                    max_prefix_length = 15,
                    tab_size = 18,
                    show_buffer_close_icons = false,
                    always_show_bufferline = false,
                    sort_by = "relative_directory"
                }
            }
        end
    }

    -- use {"tjdevries/train.nvim", config = function() end}

    use {
        "kevinhwang91/nvim-hlslens",
        config = function()
            require"hlslens".setup({
                auto_enable = true,
                calm_down = true,
                override_line_lens = nil
            })
        end
    }

    use {"drzel/vim-repo-edit", cmd = {'RepoEdit'}}

    use {
        "AndrewRadev/multichange.vim",
        keys = {"sm", "smm"},
        config = function()
            vim.g.multichange_mapping = "sm"
            vim.g.multichange_motion_mapping = "m"
        end
    }

    use {
        "dense-analysis/ale",
        config = function()
            vim.api.nvim_command [[
    call ale#linter#Define('gitcommit', { 'name': 'vale', 'executable': 'vale', 'command': 'vale --output=JSON %t', 'callback': 'ale#handlers#vale#Handle' })
    ]]
            vim.g.ale_disable_lsp = 1
            vim.g.ale_linters = {
                ruby = {"rubocop"},
                txt = {"vale"},
                gitcommit = {"vale"},
                text = {"vale"},
                markdown = {"vale"}
            }
            vim.g.ale_fixers = {ruby = {"rubocop"}}
            vim.g.ale_sign_warning = "▪"
            vim.g.ale_sign_error = "▬"
            vim.g.ale_sign_info = "▪"
            vim.g.ale_echo_cursor = 1
            vim.g.ale_virtualtext_cursor = 0
            vim.g.ale_linters_ignore = {'brakeman'}
        end
    }

    use {
        "eugen0329/vim-esearch",
        keys = {"<Plug>(esearch)"},
        config = function()
            vim.g.esearch = {
                default_mappings = 0,
                before = 1,
                after = 1,
                backend = "nvim",
                win_map = {
                    {"n", "o", "<plug>(esearch-win-open)", {nowait = 1}},
                    {"n", "R", "<plug>(esearch-win-reload)"},
                    {"n", "t", "<plug>(esearch-win-tabopen)"},
                    {"n", "T", "<plug>(esearch-win-tabopen:stay)"},
                    -- { 'n', 'o', '<plug>(esearch-win-split)',}, -- removed default
                    -- { 'n', 'O', '<plug>(esearch-win-split:reuse:stay)', }, -- removed default
                    {"n", "s", "<plug>(esearch-win-vsplit)"},
                    {"n", "S", "<plug>(esearch-win-vsplit:reuse:stay)"},
                    {"n", "<cr>", "<plug>(esearch-win-open)"},
                    {"n", "p", "<plug>(esearch-win-preview)"},
                    {"n", "P", "100<plug>(esearch-win-preview:enter)"},
                    {"n", "<esc>", "<plug>(esearch-win-preview:close)"},
                    {" ", "J", "<plug>(esearch-win-jump:entry:down)"},
                    {" ", "K", "<plug>(esearch-win-jump:entry:up)"},
                    {" ", "}", "<plug>(esearch-win-jump:filename:down)"},
                    {" ", "{", "<plug>(esearch-win-jump:filename:up)"},
                    {" ", ")", "<plug>(esearch-win-jump:dirname:down)"},
                    {" ", "(", "<plug>(esearch-win-jump:dirname:up)"},
                    {"ov", "im", "<plug>(textobj-esearch-match-i)"},
                    {"ov", "am", "<plug>(textobj-esearch-match-a)"},
                    {"ic", "<cr>", "<plug>(esearch-cr)", {nowait = 1}},
                    {"n", "I", "<plug>(esearch-I)"},
                    {"x", "x", "<plug>(esearch-d)"},
                    {"nx", "d", "<plug>(esearch-d)"},
                    {"n", "dd", "<plug>(esearch-dd)"},
                    {"nx", "c", "<plug>(esearch-c)"},
                    {"n", "cc", "<plug>(esearch-cc)"},
                    {"nx", "C", "<plug>(esearch-C)"},
                    {"nx", "D", "<plug>(esearch-D)"},
                    {"x", "s", "<plug>(esearch-c)"},
                    {"n", ".", "<plug>(esearch-.)"},
                    {"n", "@:", "<plug>(esearch-@:)"},
                    {"n", "za", "<plug>(esearch-za)"},
                    {"n", "zc", "<plug>(esearch-zc)"},
                    {"n", "zM", "<plug>(esearch-zM)"}
                }
            }
        end
    }

    use {
        "junegunn/fzf",
        config = function()
            vim.g.fzf_buffers_jump = 1
            vim.g.fzf_preview_window = {"right:50%:hidden", "ctrl-/"}
            vim.g.fzf_tags_command = "ripper-tags -R"
        end
    }

    use {"junegunn/fzf.vim"}

    use {
        "junegunn/vim-easy-align",
        keys = {"<Plug>(EasyAlign)", "<Plug>(LiveEasyAlign)"},
        config = function()
            vim.g.easy_align_delimiters =
                {
                    ["/"] = {
                        pattern = "//\\+\\|/\\*\\|\\*/",
                        delimiter_align = "l",
                        ignore_groups = {"!Comment"}
                    },
                    ["\\"] = {pattern = "\\$"},
                    [";"] = {
                        pattern = ";",
                        delimiter_align = "l",
                        ignore_groups = {"!Comment"}
                    },
                    ["("] = {
                        pattern = "(",
                        delimiter_align = "l",
                        right_margin = 0
                    },
                    ["]"] = {
                        pattern = "[[\\]]",
                        left_margin = 0,
                        right_margin = 0,
                        stick_to_left = 0
                    }
                }

            vim.g.easy_align_bypass_fold = 1
        end
    }

    use {"folke/which-key.nvim",
    config = function()
      require("which-key").setup {
        plugins = {
          marks = true, -- shows a list of your marks on ' and `
          registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
          -- the presets plugin, adds help for a bunch of default keybindings in Neovim
          -- No actual key bindings are created
          presets = {
            operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
            motions = true, -- adds help for motions
            text_objects = true, -- help for text objects triggered after entering an operator
            windows = true, -- default bindings on <c-w>
            nav = true, -- misc bindings to work with windows
            z = true, -- bindings for folds, spelling and others prefixed with z
            g = true, -- bindings for prefixed with g
          },
        },
        -- add operators that will trigger motion and text object completion
        -- to enable all native operators, set the preset / operators plugin above
        operators = { gc = "Comments" },
        icons = {
          breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
          separator = "➜", -- symbol used between a key and it's label
          group = "+", -- symbol prepended to a group
        },
        window = {
          border = "shadow", -- none, single, double, shadow
          position = "bottom", -- bottom, top
          margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
          padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
        },
        layout = {
          height = { min = 4, max = 25 }, -- min and max height of the columns
          width = { min = 20, max = 50 }, -- min and max width of the columns
          spacing = 3, -- spacing between columns
        },
        hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ "}, -- hide mapping boilerplate
        show_help = false -- show help message on the command line when the popup is visible
      }
    end}

    use {
        "machakann/vim-sandwich",
        config = function()
            vim.g.sandwich_quotes = {
                {
                    buns = {'"', '"'},
                    quoteescape = 1,
                    expand_range = 0,
                    nesting = 0,
                    linewise = 0
                }, {
                    buns = {"'", "'"},
                    quoteescape = 1,
                    expand_range = 0,
                    nesting = 0,
                    linewise = 0
                }, {
                    buns = {"`", "`"},
                    quoteescape = 1,
                    expand_range = 0,
                    nesting = 0,
                    linewise = 0
                }
            }

            vim.g.sandwich_braces = {
                {buns = {"(", ")"}, nesting = 1},
                {buns = {"[", "]"}, nesting = 1},
                {buns = {"{ ", " }"}, nesting = 1}
            }
            vim.api.nvim_set_keymap('o', "iq",
                                    "textobj#sandwich#auto('o', 'i', {}, g:sandwich_quotes)",
                                    {silent = true, expr = true})
            vim.api.nvim_set_keymap('x', "iq",
                                    "textobj#sandwich#auto('o', 'i', {}, g:sandwich_quotes)",
                                    {silent = true, expr = true})
            vim.api.nvim_set_keymap('o', "ij",
                                    "textobj#sandwich#auto('o', 'i', {}, g:sandwich_braces)",
                                    {silent = true, expr = true})
            vim.api.nvim_set_keymap('x', "ij",
                                    "textobj#sandwich#auto('o', 'i', {}, g:sandwich_braces)",
                                    {silent = true, expr = true})
        end
    }

    use {
        "pechorin/any-jump.vim",
        cmd = {'AnyJump', 'AnyJumpVisual'},
        config = function()
            vim.g.any_jump_list_numbers = 0
            vim.g.any_jump_references_enabled = 1
            vim.g.any_jump_grouping_enabled = 0
            vim.g.any_jump_preview_lines_count = 5
            vim.g.any_jump_max_search_results = 7
            vim.g.any_jump_search_prefered_engine = "rg"
            vim.g.any_jump_results_ui_style = "filename_first"
            vim.g.any_jump_window_width_ratio = 0.8
            vim.g.any_jump_window_height_ratio = 0.8
            vim.g.any_jump_window_top_offset = 4
            vim.g.any_jump_disable_default_keybindings = 1
            vim.g.any_jump_remove_comments_from_results = 1
            vim.g.any_jump_keyword_match_cursor_mode = "word"

            vim.g.any_jump_colors = {
                plain_text = "Comment",
                preview = "Comment",
                preview_keyword = "Operator",
                heading_text = "Function",
                heading_keyword = "Identifier",
                group_text = "Comment",
                group_name = "Function",
                more_button = "Operator",
                more_explain = "Comment",
                result_line_number = "Comment",
                result_text = "Statement",
                result_path = "String",
                help = "String"
            }
        end
    }

    use {"rhysd/conflict-marker.vim", config = function() end} -- TODO: configure me

    use {
        "sbdchd/neoformat",
        cmd = {'Neoformat'},
        config = function()
            vim.g.neoformat_lua_luaformatter = {exe = "lua-format"}
        end
    }
    use {"stsewd/gx-extended.vim", config = function() end} -- TODO: configure me

    use {"tpope/vim-commentary"}

    use {
        "janko-m/vim-test",
        cmd = {'TestNearest', 'TestFile', 'TestVisit', 'TestLast'},
        config = function()
            vim.api.nvim_set_var("test#preserve_screen", 1)
            vim.api.nvim_exec([[source $DOTFILES/home/vim/lua/vim-test.vim]],
                              false)
            -- vim.api.nvim_set_var('test#strategy', 'floaterm_custom')
            vim.api.nvim_set_var("test#strategy", "gary_terminal")
            vim.api.nvim_set_var("test#ruby#rspec#options", {
                ["nearest"] = "--format progress --force-color --fail-fast",
                ["file"] = "--format documentation --force-color --fail-fast"
            })
            vim.api.nvim_set_var("test#ruby#rspec#executable",
                                 "ENABLE_SPRING=1 bin/rspec")
        end
    }

    -- use {"nathunsmitty/nvim-ale-diagnostic"}

    use {"npxbr/glow.nvim", cmd = {"Glow"}}

    use {"tpope/vim-projectionist"}

    -- use {"vijaymarupudi/nvim-fzf"}

    -- use {"vijaymarupudi/nvim-fzf-commands"}

    use {"DanilaMihailov/beacon.nvim"}

    use {"wincent/terminus"}

    use {"farmergreg/vim-lastplace"}

    use {"duggiefresh/vim-easydir"}

    use {"antoinemadec/FixCursorHold.nvim"}

    use {"euclidianAce/BetterLua.vim", ft = 'lua'}

    use {"Rasukarusan/nvim-block-paste", config = function() end}

    use {"andymass/vim-matchup", config = function() end}

    use {"romainl/vim-cool", config = function() vim.g.CoolTotalMatches = 1 end}

    -- use {
    --     "nvim-treesitter/nvim-treesitter",
    --     run = ":TSUpdate",
    --     config = function()
    --         require "nvim-treesitter"
    --         require"nvim-treesitter.configs".setup {
    --             ensure_installed = "maintained",
    --             highlight = {enable = true},
    --             rainbow = {enable = true},
    --             refactor = {
    --                 highlight_current_scope = {enable = false},
    --                 highlight_definitions = {enable = true},
    --                 smart_rename = {
    --                     enable = true,
    --                     keymaps = {smart_rename = "grr"}
    --                 },
    --                 navigation = {
    --                     enable = true,
    --                     keymaps = {
    --                         goto_next_usage = "<a-*>",
    --                         goto_previous_usage = "<a-#>"
    --                     }
    --                 }
    --             }
    --         }
    --     end,
    --     requires = {
    --         "p00f/nvim-ts-rainbow", "nvim-treesitter/nvim-treesitter-refactor"
    --     }
    -- }

    use {
        "hrsh7th/nvim-compe",
        config = function()
            require"compe".setup {
                enabled = true,
                autocomplete = true,
                debug = false,
                min_length = 1,
                preselect = "enable",
                throttle_time = 80,
                source_timeout = 200,
                incomplete_delay = 400,
                max_abbr_width = 100,
                max_kind_width = 100,
                max_menu_width = 100,
                documentation = true,
                source = {
                    path = true,
                    buffer = true,
                    calc = true,
                    vsnip = true,
                    nvim_lsp = false,
                    nvim_lua = false,
                    spell = true,
                    tags = true,
                    snippets_nvim = false,
                    treesitter = true
                }
            }

            local t = function(str)
                return vim.api.nvim_replace_termcodes(str, true, true, true)
            end

            local check_back_space = function()
                local col = vim.fn.col(".") - 1
                if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
                    return true
                else
                    return false
                end
            end

            -- Use (s-)tab to:
            --- move to prev/next item in completion menuone
            --- jump to prev/next snippet's placeholder
            _G.tab_complete = function()
                if vim.fn.pumvisible() == 1 then
                    if vim.fn.call("vsnip#available", {1}) == 1 then
                        return t "<Plug>(vsnip-expand-or-jump)"
                    else
                        return t "<C-n>"
                    end
                elseif check_back_space() then
                    return t "<Tab>"
                else
                    return vim.fn["compe#complete"]()
                end
            end
            _G.s_tab_complete = function()
                if vim.fn.pumvisible() == 1 then
                    return t "<C-p>"
                elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
                    return t "<Plug>(vsnip-jump-prev)"
                else
                    return t "<S-Tab>"
                end
            end

            vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()",
                                    {expr = true})
            vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()",
                                    {expr = true})
            vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()",
                                    {expr = true})
            vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()",
                                    {expr = true})
        end
    }

    use {"hrsh7th/vim-vsnip"}

    use {"hrsh7th/vim-vsnip-integ"}

    use {
        'hoob3rt/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true},
        config = function()
            require('lualine').setup {
                options = {
                    theme = 'tokyonight',
                    icons_enabled = true,
                    padding = 2,
                    section_separators = {'', ''},
                    component_separators = {'', ''}
                },
                sections = {
                    lualine_a = {
                        {
                            'branch',
                            format = function(branch)
                                return branch:sub(1, 15)
                            end
                        }
                    },
                    lualine_b = {
                        {
                            'filename', {
                                format = function(filename)
                                    if string.find(filename, "ee/", nil, true) then
                                        return "EE"
                                    else
                                        return nil
                                    end
                                end,
                                full_path = true,
                                color = "ErrorMsg"
                            }
                        }, {'filename'}
                    },
                    lualine_c = {},
                    lualine_x = {{'diff'}},
                    lualine_y = {{'diagnostics', sources = {'ale'}}},
                    lualine_z = {'location'}
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = {'filename'},
                    lualine_x = {'location'},
                    lualine_y = {},
                    lualine_z = {}
                },
                extensions = {'fzf', 'nvim-tree'}
            }
        end
    }

    use {
        "kyazdani42/nvim-tree.lua",
        cmd = {'NvimTreeToggle', 'NvimTreeFindFile'},
        config = function() vim.g.nvim_tree_auto_close = 1 end
    }

    use {
        "Shougo/echodoc.vim",
        config = function()
            vim.g.echodoc_enable_at_startup = 1
            vim.g.echodoc = {["type"] = "floating"}
        end
    }
    use {
        "airblade/vim-rooter",
        config = function()
            vim.g.rooter_disable_map = 1
            vim.g.rooter_silent_chdir = 1
            vim.g.rooter_resolve_links = 1

            vim.g.rooter_patterns = {
                '.env', '.gitignore', '.gitattributes', '.styleci.yml',
                '_ide_helper', 'composer.json', 'composer.lock', 'package.json',
                'README.md', '.editorconfig', '.git', '.git/', '_darcs/',
                '.hg/', '.bzr/', '.svn/', 'node_modules/', 'Gemfile'
            }

            vim.g.rooter_change_directory_for_non_project_files = "current"
        end
    }

    use {
        "karb94/neoscroll.nvim",
        config = function() require('neoscroll').setup() end
    }

    use {
        "foosoft/vim-argwrap",
        cmd = {'ArgWrap'},
        config = function() vim.g.argwrap_tail_indent_braces = "(" end
    }

    use {"justinmk/vim-gtfo"}

    use {"kana/vim-niceblock"}

    use {
        "mhinz/vim-sayonara",
        cmd = {"Sayonara"},
        config = function() vim.g.sayonara_confirm_quit = 1 end
    }

    use {"takac/vim-commandcaps"}

    use {"tpope/vim-abolish"}

    use {"tpope/vim-apathy"}

    use {"tpope/vim-eunuch"}

    use {"tpope/vim-repeat"}

    use {"tpope/vim-rsi"}

    use {
        "voldikss/vim-floaterm",
        cmd = {'FloatermNew', 'FloatermToggle'},
        config = function()
            vim.g.floaterm_width = 0.9
            vim.g.floaterm_height = 0.9
            vim.g.floaterm_autoclose = 1
        end
    }

    use {
        "rhysd/git-messenger.vim",
        keys = {'<Plug>(git-messenger)'},
        config = function()
            vim.g.git_messenger_include_diff = "none"
            vim.g.git_messenger_always_into_popup = true

            -- can't this move?
            vim.api.nvim_exec([[
              function! GitMessengerPopup() abort
              nmap <buffer><C-o> o
              nmap <buffer><C-i> O
              nmap <silent><buffer>j :GitMessengerClose<CR>
              nmap <silent><buffer>k :GitMessengerClose<CR>
              endfunction

              augroup GitMessenger
              autocmd!
              autocmd FileType gitmessengerpopup call GitMessengerPopup()
              augroup END
              ]], false)
        end
    }

    use {
        "garymh/vim-tmux-navigator",
        -- cmd = {
        --     "TmuxNavigateLeft", "TmuxNavigateDown", "TmuxNavigateUp",
        --     "TmuxNavigateRight", "TmuxNavigateNext", "TmuxNavigatePrevious"
        -- },
        cond = has_tmux
    }

    use {'dstein64/vim-startuptime'}

    -- TODO:
    -- use {"marcushwz/nvim-workbench"}
end

local plugins = setmetatable({}, {
    __index = function(_, key)
        init()
        return packer[key]
    end
})

return plugins

-- " use {'datwaft/bubbly.nvim'
-- vim.g.db_ui_env_variable_url = 'DATABASE_URL'
-- " use {'kshenoy/vim-signature'
-- use {"ChristianChiarulli/nvcode-color-schemes.vim"}
-- use {"arzg/vim-colors-xcode"}
-- use {"atahabaki/archman-vim"}
-- use {"tjammer/focusedpanic.vim"}
-- use {"relastle/bluewery.vim"}
-- use {"levelone/tequila-sunrise.vim"}
-- use {"challenger-deep-theme/vim"}
-- use {"benmills/vimux", opt = true, cond = has_tmux}

-- use {"lukas-reineke/indent-blankline.nvim", branch = "lua", config = function()
--   vim.g.indent_blankline_show_first_indent_level = false
--   vim.g.indent_blankline_char = ' '
--   vim.g.indent_blankline_filetype_exclude = { 'help', 'text', 'which_key', 'fzf', "packer", 'yaml', 'NvimTree' }
--   vim.g.indent_blankline_char_highlight_list = {
--     'IndentBlankLine1',
--     'IndentBlankLine2',
--     'IndentBlankLine3',
--     'IndentBlankLine4',
--     'IndentBlankLine5',
--     'IndentBlankLine6',
--     'IndentBlankLine7',
--     'IndentBlankLine8',
--   }
--   vim.g.indent_blankline_use_treesitter = true
--   vim.g.indent_blankline_context_highlight = 'IndentBlankLineContext'
--   vim.g.indent_blankline_show_current_context = true
-- end}

-- doesn't seem to work?
-- use {
--   'zegervdv/nrpattern.nvim',
--   config = function()
--     -- Basic setup
--     -- See below for more options
--     require"nrpattern".setup()
--   end,
-- }

-- use {
--   'lewis6991/gitsigns.nvim',
--   requires = {
--     'nvim-lua/plenary.nvim'
--   },
--   config = function()
--     require('gitsigns').setup {
--       signs = {
--         add          = {hl = 'GitSignsAdd'   , text = '▓', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
--         change       = {hl = 'GitSignsChange', text = '▓', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
--         delete       = {hl = 'GitSignsDelete', text = '▓', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
--         topdelete    = {hl = 'GitSignsDelete', text = '▓', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
--         changedelete = {hl = 'GitSignsChange', text = '▓', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
--       },
--       numhl = false,
--       linehl = false,
--       keymaps = {
--         -- Default keymap options
--         noremap = true,
--         buffer = true,

--         -- ['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'"},
--         -- ['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'"},

--         ['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
--         ['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
--         ['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
--         ['n <leader>hR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
--         ['n <leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',

--         -- Text objects
--         ['o ih'] = ':<C-U>lua require"gitsigns".text_object()<CR>',
--         ['x ih'] = ':<C-U>lua require"gitsigns".text_object()<CR>'
--       },
--       watch_index = {
--         interval = 1000
--       },
--       sign_priority = 6,
--       update_debounce = 100,
--       status_formatter = nil, -- Use default
--       use_decoration_api = true,
--       use_internal_diff = true,  -- If luajit is present
--     }
--   end
-- }

-- use {"sagi-z/oonav"}

