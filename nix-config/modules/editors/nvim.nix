{ pkgs, ... }:

# Ref:
# https://nix-community.github.io/nixvim/search

let
  colors = import ../theming/colors.nix;
in
{
  # # steam-run for codeium-vim
  # # start nvim in bash first time, so the spell files can be downloaded
  # programs.zsh.shellAliases = {
  #   vim = "${pkgs.steam-run}/bin/steam-run nvim";
  #   nvim = "${pkgs.steam-run}/bin/steam-run nvim";
  # };
  environment = {
    systemPackages = with pkgs; [
      go
      nodejs
      python3
      ripgrep
      # zig
    ];
  };

  programs.nixvim = {
    enable = true;
    enableMan = false;
    viAlias = true;
    vimAlias = true;
    autoCmd = [
      {
        event = "VimEnter";
        command = "set nofoldenable";
        desc = "Unfold All";
      }
      {
        event = "BufWrite";
        command = "%s/\\s\\+$//e";
        desc = "Remove Trailing Whitespaces";
      }
      {
        event = "FileType";
        pattern = [ "markdown" "org" "norg" ];
        command = "setlocal conceallevel=2";
        desc = "Conceal Syntax Attribute";
      }
      {
        event = "FileType";
        pattern = [ "markdown" "org" "norg" ];
        command = "setlocal spell spelllang=en";
        desc = "Spell Checking";
      }
      {
        event = "FileType";
        pattern = [ "markdown" ];
        command = "setlocal scrolloff=30 | setlocal wrap";
        desc = "Fixed cursor location on markdown (for preview) and enable wrapping";
      }
    ];

    opts = {
      number = true;
      relativenumber = true;
      hidden = true;
      foldlevel = 99;
      shiftwidth = 4;
      tabstop = 4;
      softtabstop = 4;
      expandtab = true;
      autoindent = true;
      wrap = false;
      scrolloff = 5;
      sidescroll = 40;
      completeopt = [ "menu" "menuone" "noselect" ];
      pumheight = 15;
      fileencoding = "utf-8";
      swapfile = false;
      timeoutlen = 2500;
      conceallevel = 3;
      cursorline = true;
      spell = false;
      spelllang = [ "en" ];
    };

    clipboard = {
      register = "unnamedplus";
      providers.wl-copy.enable = true;
    };

    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    keymaps = [
      {
        key = "<leader>q";
        action = "<CMD>q<CR>";
        options.desc = "Quit";
      }
      {
        key = "<leader>t";
        action = "<CMD>Neotree float reveal<CR>";
        options.desc = "Reveal NeoTree";
      }
      {
        key = "<leader>T";
        action = "<CMD>Neotree float reveal_file=<cfile> reveal_force_cwd<CR>";
        options.desc = "Reveal cursor focus in NeoTree";
      }
      {
        key = "<leader>sh";
        action = "<C-w>s";
        options.desc = "Split Horizontal";
      }
      {
        key = "<leader>sv";
        action = "<C-w>v";
        options.desc = "Split Vertical";
      }
      {
        key = "<leader><Left>";
        action = "<C-w>h";
        options.desc = "Select Window Left";
      }
      {
        key = "<leader>h";
        action = "<C-w>h";
        options.desc = "Select Window Left";
      }
      {
        key = "<leader><Right>";
        action = "<C-w>l";
        options.desc = "Select Window Right";
      }
      {
        key = "<leader>l";
        action = "<C-w>l";
        options.desc = "Select Window Right";
      }
      {
        key = "<leader><Down>";
        action = "<C-w>j";
        options.desc = "Select Window Below";
      }
      {
        key = "<leader>j";
        action = "<C-w>j";
        options.desc = "Select Window Below";
      }
      {
        key = "<leader><Up>";
        action = "<C-w>k";
        options.desc = "Select Window Above";
      }
      {
        key = "<leader>k";
        action = "<C-w>k";
        options.desc = "Select Window Above";
      }
      {
        key = "<leader>W";
        action = "<C-w>w";
        options.desc = "Cycle Between Windows";
      }
      {
        key = "<leader>bb";
        action = "<CMD>BufferPick<CR>";
        options.desc = "Select Buffer";
      }
      {
        key = "<leader>bc";
        action = "<CMD>BufferClose<CR>";
        options.desc = "Close Current Buffer";
      }
      {
        key = "<leader>bn";
        action = "<CMD>:bnext<CR>";
        options.desc = "Next Buffer";
      }
      {
        key = "<leader>bp";
        action = "<CMD>:bprev<CR>";
        options.desc = "Previous Buffer";
      }
      {
        mode = "v";
        key = ">";
        action = ">gv";
        options.desc = "Indent";
      }
      {
        mode = "v";
        key = "<";
        action = "<gv";
        options.desc = "Dedent";
      }
      {
        mode = [ "n" "v" ];
        key = "<C-/>";
        action = "<Plug>(comment_toggle_linewise_current)";
        options.desc = "(Un)comment";
      }
      {
        mode = [ "n" "v" ];
        key = "<leader>e";
        action = "<CMD>lua vim.diagnostic.open_float(0, {scope=\"line\"})<CR>";
        options.desc = "Show LSP Diagnostic";
      }
      {
        mode = "n";
        key = "<leader>ld";
        action = "<CMD>lua vim.lsp.buf.hover()<CR>";
        options.desc = "Show LSP definition in floating window";
      }
      {
        mode = "n";
        key = "<leader>lD";
        action = "<CMD>lua vim.lsp.buf.definition()<CR>";
        options.desc = "Load LSP definition in new buffer";
      }
      {
        mode = "n";
        key = "<leader>le";
        action = "<CMD>lua vim.diagnostic.open_float()<CR>";
        options.desc = "Show LSP diagnostic in floating window";
      }
      # {
      #   mode = "n";
      #   key = "<leader>r";
      #   action = ":! ";
      #   options.desc = "Run command";
      # }
      {
        mode = "n";
        key = "<TAB>";
        action = "z=";
        options.desc = "Get spell suggestion";
      }
      {
        mode = "n";
        key = "\\\\";
        action = "<CMD>ToggleTerm<CR>";
        options.desc = "Toggle terminal";
      }
      {
        mode = "t";
        key = "<esc>";
        action = "<C-\\><C-n>";
        options.desc = "Exit terminal mode";
      }
      {
        mode = [ "n" "v" ];
        key = "<leader>@";
        action = "<CMD>CopilotChat<CR>";
        options.desc = "Copilot Chat";
      }
      # TODO: lots more good stuff for file open https://vi.stackexchange.com/a/3369
      {
        mode = "n";
        key = "gf";
        action = "gf";
        options.desc = "Edit file under cursor";
      }

      # Refactoring (https://github.com/MattSturgeon/nix-config/blob/5dd1b19bc69fa33bfc950c10083490187c3d58a2/nvim/config/keymaps.nix#L89C5-L128C1)
      {
        mode = "n";
        key = "<leader>rr";
        action.__raw = /* lua */ ''
          require("telescope").extensions.refactoring.refactors
        '';
        options.desc = "Select refactor";
      }
      {
        mode = "n";
        key = "<leader>re";
        action = ":Refactor extract_var ";
        options.desc = "Extract to variable";
      }
      {
        mode = "n";
        key = "<leader>rE";
        action = ":Refactor extract ";
        options.desc = "Extract to function";
      }
      {
        mode = "n";
        key = "<leader>rb";
        action = ":Refactor extract_block ";
        options.desc = "Extract to block";
      }
      {
        mode = "n";
        key = "<leader>ri";
        action = ":Refactor inline_var ";
        options.desc = "Inline variable";
      }
      {
        mode = "n";
        key = "<leader>rI";
        action = ":Refactor inline_func ";
        options.desc = "Inline function";
      }

      # hop keymaps (https://github.com/smoka7/hop.nvim/wiki/Commands)
      {
        key = "gf";
        action.__raw = ''
          function()
            require'hop'.hint_char2({
              direction = require'hop.hint'.HintDirection.AFTER_CURSOR,
              current_line_only = false
            })
          end
        '';
        options.desc = "HopChar2 » (incl)";
        # options.group = "hops";
      }
      {
        key = "gF";
        action.__raw = ''
          function()
            require'hop'.hint_char2({
              direction = require'hop.hint'.HintDirection.BEFORE_CURSOR,
              current_line_only = false
            })
          end
        '';
        options.desc = "HopChar2 « (incl)";
        # options.group = "hops";
      }
      {
        key = "gt";
        action.__raw = ''
          function()
            require'hop'.hint_char2({
              direction = require'hop.hint'.HintDirection.AFTER_CURSOR,
              current_line_only = false,
              hint_offset = -1
            })
          end
        '';
        options.desc = "HopChar2 » (excl)";
        # options.group = "hops";
      }
      {
        key = "gT";
        action.__raw = ''
          function()
            require'hop'.hint_char2({
              direction = require'hop.hint'.HintDirection.BEFORE_CURSOR,
              current_line_only = false,
              hint_offset = 1
            })
          end
        '';
        options.desc = "HopChar2 « (excl)";
        # options.group = "hops";
      }
      {
        key = "g/";
        action.__raw = ''
          function()
            require'hop'.hint_patterns({ })
          end
        '';
        options.desc = "Hop Search ⇕";
        # options.group = "hops";
      }
      {
        key = "gw";
        action.__raw = ''
          function()
            require'hop'.hint_words({
              direction = require'hop.hint'.HintDirection.AFTER_CURSOR,
            })
          end
        '';
        options.desc = "Hop Word ꜜ";
        # options.group = "hops";
      }
      {
        key = "gW";
        action.__raw = ''
          function()
            require'hop'.hint_words({
              direction = require'hop.hint'.HintDirection.AFTER_CURSOR,
            })
          end
        '';
        options.desc = "Hop Word ꜛ";
        # options.group = "hops";
      }
      {
        key = "gj";
        action.__raw = ''
          function()
            require'hop'.hint_lines({
              direction = require'hop.hint'.HintDirection.AFTER_CURSOR,
            })
          end
        '';
        options.desc = "Hop Line ꜜ";
        # options.group = "hops";
      }
      {
        key = "gk";
        action.__raw = ''
          function()
            require'hop'.hint_lines({
              direction = require'hop.hint'.HintDirection.BEFORE_CURSOR,
            })
          end
        '';
        options.desc = "Hop Line ꜛ";
        # options.group = "hops";
      }
      # camel / snake case (https://dev.to/dimaportenko/switching-between-camelcase-and-snakecase-in-neovim-using-lua-3ah7)
      {
        key = "gs";
        action.__raw = ''
          function()
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            local word = vim.fn.expand('<cword>')
            local word_start = vim.fn.matchstrpos(vim.fn.getline('.'), '\\k*\\%' .. (col+1) .. 'c\\k*')[2]

            -- Detect camelCase
            if word:find('[a-z][A-Z]') then
              -- Convert camelCase to snake_case
              local snake_case_word = word:gsub('([a-z])([A-Z])', '%1_%2'):lower()
              vim.api.nvim_buf_set_text(0, line - 1, word_start, line - 1, word_start + #word, {snake_case_word})
            -- Detect snake_case
            elseif word:find('_[a-z]') then
              -- Convert snake_case to camelCase
              local camel_case_word = word:gsub('(_)([a-z])', function(_, l) return l:upper() end)
              vim.api.nvim_buf_set_text(0, line - 1, word_start, line - 1, word_start + #word, {camel_case_word})
            else
              print("Not a snake_case or camelCase word")
            end
          end
        '';
        options.desc = "Camel ⇔ Snake case";
      }
    ];

    plugins = {
      copilot-chat.enable = true;
      copilot-lua = {
        enable = true;
        # turn off per copilot-cmp
        panel.enabled = false;
        suggestion.enabled = false;
      };
      copilot-cmp.enable = true;
      neotest = {
        enable = true;
        adapters.jest.enable = true;
      };
      nvim-surround = {
        enable = true;
      };
      lualine = {
        enable = true;
        settings = {
          sections = {
            # one character mode
            lualine_a = [
              {
                __unkeyed-1 = "mode";
                fmt.__raw = ''
                  function(str) return str:sub(1,1) end
                '';
              }
            ];
            # truncated branch name
            lualine_b = [
              {
                __unkeyed-1 = "branch";
                fmt.__raw = ''
                  function(str) return str:gsub("personal/cjewett", "ccj") end
                '';
              }
            ];
            lualine_c = [
              {
                __unkeyed-1 = "filename";
                path = 0;
                # do something smarter based upon column count & window width
                shorting_target = 35;
              }
              "diff"
            ];
            lualine_x = [ ];
          };
          # inactive_sections = {
          #   lualine_c = [ "buffers" ];
          # };
        };
      };
      barbar.enable = true;
      gitgutter = {
        enable = true;
        defaultMaps = false;
      };
      mini = {
        enable = true;
        modules = {
          icons = { };
          indentscope = { };
          # mockDevIcons = { };
          move = { };
        };
      };
      web-devicons.enable = true;
      indent-blankline = {
        enable = true;
        settings.scope.enabled = false;
      };
      lastplace.enable = true;
      comment.enable = true;
      fugitive.enable = true;
      markdown-preview.enable = true;
      nvim-autopairs.enable = true;

      # https://github.com/ThePrimeagen/refactoring.nvim
      refactoring = {
        enable = true;
        enableTelescope = true;
      };
      telescope = {
        enable = true;
        settings = {
          pickers.find_files = {
            hidden = true;
          };
        };
        keymaps = {
          "<leader>ff" = {
            action = "git_files";
            options = {
              desc = "Find Git Files";
            };
          };
          "<leader>fg" = {
            action = "live_grep";
            options = {
              desc = "Find Via Grep";
            };
          };
          "<leader>fF" = {
            action = "find_files";
            options = {
              desc = "Find File";
            };
          };
          "<leader>fs" = {
            action = "git_status";
            options = {
              desc = "List Git Status";
            };
          };
          "<leader>fS" = {
            action = "git_stash";
            options = {
              desc = "List Git Stash";
            };
          };
          "<leader>fb" = {
            action = "buffers";
            options = {
              desc = "Find Buffers";
            };
          };
          "<leader>fh" = {
            action = "help_tags";
            options = {
              desc = "Find Help";
            };
          };
          "<leader>tt" = {
            action = "builtin";
            options = {
              desc = "Telescope Builtins";
            };
          };
        };
      };
      trouble = {
        enable = true;
        settings = {
          # win.wo.wrap = true;
          preview = {
            type = "float";
            relative = "editor";
            border = "rounded";
            title = "Preview";
            title_pos = "center";
            position = (0 - 2);
            size = { width = 0.3; height = 0.3; };
            zindex = 200;
          };
        };
      };
      neo-tree = {
        enable = true;
        window.width = 30;
        closeIfLastWindow = true;
        extraOptions = {
          filesystem = {
            filtered_items = {
              visible = true;
            };
          };
        };
      };
      undotree = {
        enable = true;
        settings = {
          FocusOnToggle = true;
          HighlightChangedText = true;
        };
      };
      treesitter = {
        enable = true;
        nixvimInjections = true;
        folding = false;
        nixGrammars = true;
        settings = {
          ensure_installed = "all";
          highlight.enable = true;
          incremental_selection.enable = true;
          indent.enable = true;
          highlight_definitions.enable = true;

        };
      };
      treesitter-refactor = {
        enable = true;
        smartRename = {
          enable = true;
          keymaps = {
            smartRename = "<leader>rn";
          };
        };
        navigation = {
          enable = true;
          keymaps = {
            gotoDefinition = "gd";
            listDefinitions = "gD";
            listDefinitionsToc = "gO";
            gotoNextUsage = "<a-*>";
            gotoPreviousUsage = "<a-#>";
          };
        };
      };
      nvim-colorizer = {
        enable = true;
        userDefaultOptions = {
          css = true;
          tailwind = "both";
        };
      };
      cursorline = {
        enable = true;
        cursorline = {
          enable = true;
          number = true;
          timeout = 0;
        };
        cursorword = {
          enable = true;
          hl = { underline = true; };
          minLength = 3;
        };
      };
      # neorg = {
      #   enable = true;
      #   package = stable.vimPlugins.neorg;
      #   lazyLoading = true;
      #   modules = {
      #     "core.defaults".__empty = null;
      #     "core.dirman".config = {
      #       workspaces = {
      #         notes = "~/notes";
      #       };
      #       default_workspace = "notes";
      #     };
      #     "core.concealer".__empty = null;
      #     "core.completion".config.engine = "nvim-cmp";
      #   };
      # };
      lsp = {
        enable = true;
        servers = {
          bashls = {
            enable = true;
            filetypes = [ "sh" "bash" "zsh" ];
          };
          cssls.enable = true;
          eslint.enable = true;
          html.enable = true;
          java_language_server.enable = true;
          nil_ls.enable = true;
          pyright.enable = true;
          tailwindcss = {
            enable = true;
            filetypes = [
              "html"
              "js"
              "ts"
              "jsx"
              "tsx"
              "mdx"
            ];
          };
          ts_ls.enable = true;
          gopls.enable = true;
          # zls.enable = true;
        };
      };
      lsp-format.enable = true;
      none-ls = {
        enable = true;
        enableLspFormat = true;
        sources = {
          diagnostics = {
            zsh.enable = true;
          };
          formatting = {
            prettier = {
              enable = true;
              disableTsServerFormatter = true;
            };
            nixpkgs_fmt.enable = true;
            markdownlint.enable = true;
          };
        };
      };
      lspkind = {
        enable = true;
        cmp = {
          enable = true;
          menu = {
            copilot = "";
            nvim_lsp = "[LSP]";
            nvim_lua = "[api]";
            path = "[path]";
            luasnip = "[snip]";
            look = "[look]";
            buffer = "[buffer]";
            orgmode = "";
            neorg = "[neorg]";
          };
        };
      };
      lsp-lines.enable = true;
      luasnip.enable = true;
      cmp_luasnip.enable = true;
      cmp-nvim-lsp.enable = true;
      cmp-look.enable = true;
      cmp = {
        enable = true;
        settings = {
          snippet.expand = "luasnip";
          mapping = {
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-e>" = "cmp.mapping.close()";
            # "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
            # "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
            "<Down>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
            "<Up>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
            "<C-j>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
            "<C-k>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
            "<Tab>" = "cmp.mapping.confirm({ select = true })";
          };
          sources = [
            { name = "copilot"; }
            { name = "nvim_lsp"; }
            { name = "luasnip"; }
            { name = "look"; keywordLength = 2; option = { convert_case = true; loud = true; }; }
            { name = "path"; }
            { name = "buffer"; }
            { name = "nvim_lua"; }
            { name = "orgmode"; }
            { name = "neorg"; }
          ];
          window = {
            completion.border = "rounded";
            documentation.border = "rounded";
          };
          completion.completeopt = "menu,menuone,noselect,preview";
        };
      };
      which-key = {
        enable = true;
        settings = {
          spec = [
            {
              __unkeyed-1 = "<leader>b";
              desc = "Buffer";
            }
            {
              __unkeyed-1 = "<leader>f";
              desc = "Find";
            }
            {
              __unkeyed-1 = "<leader>o";
              desc = "Org Mode";
            }
            {
              __unkeyed-1 = "<leader>s";
              desc = "Split Window";
            }
            {
              __unkeyed-1 = "<leader>rn";
              desc = "Rename (Smart)";
            }
          ];
        };
      };
      toggleterm = {
        enable = true;
        settings = {
          autoScroll = true;
          closeOnExit = true;
          direction = "horizontal";
          persistMode = true;
          startInInsert = true;
        };
      };
      hop = {
        enable = true;
      };
      spider = {
        enable = true;
        keymaps = {
          motions = {
            w = "w";
            e = "e";
            b = "b";
            ge = "ge";
          };
          silent = true;
        };
      };
    };
    extraPlugins = with pkgs.vimPlugins; [
      friendly-snippets
      luasnip
      nvim-scrollbar
      orgmode
      onedarkpro-nvim
      vim-cool
      vim-prettier
      # codeium-vim
      (pkgs.vimUtils.buildVimPlugin rec {
        pname = "scope-nvim";
        version = "cd27af77ad61a7199af5c28d27013fb956eb0e3e";
        src = pkgs.fetchFromGitHub {
          owner = "tiagovla";
          repo = "scope.nvim";
          rev = version;
          sha256 = "sha256-z1ytdhxKrLnZG8qMPEe2h+wC9tF4K/x6zplwnIojZuE=";
        };
      })
      (pkgs.vimUtils.buildVimPlugin rec {
        pname = "org-bullets.nvim";
        version = "6e0d60e901bb939eb526139cb1f8d59065132fd9";
        src = pkgs.fetchFromGitHub {
          owner = "akinsho";
          repo = "org-bullets.nvim";
          rev = version;
          sha256 = "sha256-x6S4WdgfUr7HGEHToSDy3pSHEwOPQalzWhBUipqMtnw=";
        };
      })
      (pkgs.vimUtils.buildVimPlugin rec {
        pname = "follow-md-links.nvim";
        version = "cf081a0a8e93dd188241a570b9a700b6a546ad1c";
        src = pkgs.fetchFromGitHub {
          owner = "jghauser";
          repo = "follow-md-links.nvim";
          rev = version;
          sha256 = "sha256-ElgYrD+5FItPftpjDTdKAQR37XBkU8mZXs7EmAwEKJ4=";
        };
      })
      (pkgs.vimUtils.buildVimPlugin rec {
        pname = "vim-plist";
        version = "60e69bec50dfca32f0a62ee2dacdfbe63fd92038";
        src = pkgs.fetchFromGitHub {
          owner = "darfink";
          repo = "vim-plist";
          rev = version;
          sha256 = "sha256-OIMXpX/3YXUsDsguY8/lyG5VXjTKB+k5XPfEFUSybng=";
        };
      })
    ];
    extraConfigLua = with colors.scheme.default.hex; ''
      require('orgmode').setup({
        org_agenda_files = { '~/org/**/*' },
        org_default_notes_file = '~/org/refile.org',
      })
      vim.cmd[[
        augroup orgmode_settings
          autocmd!
          autocmd FileType org
          \ setlocal conceallevel=2 |
          \ setlocal concealcursor=nc
        augroup END
      ]]

      require('onedarkpro').setup({
        colors = {
          bg = "#${bg}",
        },
        options = {
          cursorline = true,
          transparency = true,
        },
      })
      local border = {
        {"╭", "FloatBorder"},
        {"─", "FloatBorder"},
        {"╮", "FloatBorder"},
        {"│", "FloatBorder"},
        {"╯", "FloatBorder"},
        {"─", "FloatBorder"},
        {"╰", "FloatBorder"},
        {"│", "FloatBorder"},
      }
      local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
      function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
        opts = opts or {}
        opts.border = opts.border or border
        return orig_util_open_floating_preview(contents, syntax, opts, ...)
      end
      vim.cmd[[
        colorscheme onedark
        highlight FloatBorder guifg=white guibg=NONE
        highlight Pmenu guibg=NONE
        highlight PmenuSbar guibg=NONE
        highlight PmenuThumb guibg=white
      ]]

      require('org-bullets').setup()

      require('scrollbar').setup()

      vim.o.runtimepath = vim.o.runtimepath .. ',~/.local/share/nvim/site' -- set spellfile path

      vim.opt.fillchars:append({ eob = " " })
    '';
  };
}
