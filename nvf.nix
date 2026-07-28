{
  pkgs,
  texpresso-vim,
  ...
}: let
  texpressoVimPlugin = pkgs.vimUtils.buildVimPlugin {
    pname = "texpresso.vim";
    version = "unstable";
    src = texpresso-vim;
  };

  splitNvimPlugin = pkgs.vimUtils.buildVimPlugin {
    pname = "split.nvim";
    version = "unstable-2025-02-07";
    src = builtins.fetchGit {
      url = "https://github.com/wurli/split.nvim.git";
      rev = "12c4fb27a9c617e0291ef0ae1609662ae409c9f8";
    };
  };
in {
  config.vim = {
    globals.mapleader = " ";
    lineNumberMode = "relNumber";

    options = {
      wrap = false;
      colorcolumn = "80";
      shiftwidth = 4;
      tabstop = 4;
      expandtab = true;
      splitright = true;
      splitbelow = true;
      softtabstop = 4;
      wildmode = "longest,list,full";
      ruler = true;
      undolevels = 1000;
      foldmethod = "marker";
      exrc = true;
      hlsearch = false;
      scrolloff = 6;
      backup = false;
      writebackup = false;
      updatetime = 100;
      signcolumn = "yes";
      termguicolors = true;
      completeopt = "menuone,noinsert,noselect";
      shortmess = "c";
      cmdheight = 2;
    };

    clipboard.providers.wl-copy.enable = true;

    autocmds = [
      {
        command = "setlocal wrap colorcolumn=0 spell spelllang=da,en_gb";
        event = ["BufEnter" "BufWinEnter"];
        pattern = ["*.md"];
      }
      {
        command = "nnoremap <buffer> <leader>sc [slz=";
        event = ["BufEnter" "BufWinEnter"];
        pattern = ["*.md"];
      }
    ];

    keymaps = [
      {
        action = "<cmd>cnext<cr>";
        key = "<leader>cn";
        mode = "n";
      }
      {
        action = "<cmd>cprev<cr>";
        key = "<leader>cp";
        mode = "n";
      }
      {
        action = "<cmd>copen<cr>";
        key = "<leader>co";
        mode = "n";
      }
      {
        action = "<cmd>cclose<cr>";
        key = "<leader>cc";
        mode = "n";
      }
      {
        action = ":call setqflist([])<cr>";
        key = "<leader>cf";
        mode = "n";
      }
    ];

    theme = {
      enable = true;
      base16-colors = import ./base16.nix;
    };

    notes.obsidian.enable = true;

    statusline.lualine.enable = true;

    ui.noice.enable = true;
    visuals.nvim-web-devicons.enable = true;

    lsp = {
      presets.harper.enable = true;
      servers.harper.filetypes = ["gitcommit" "latex" "markdown" "typst"];
    };

    languages = {
      enableExtraDiagnostics = true;
      enableFormat = true;
      enableTreesitter = true;
      nix = {
        enable = true;
        lsp.enable = true;
      };
      typescript = {
        enable = true;
        format.enable = false;
        lsp.enable = true;
      };
      python = {
        enable = true;
        lsp.enable = true;
      };
      markdown = {
        enable = true;
        lsp.enable = true;
        extensions.render-markdown-nvim.enable = true;
      };
      yaml.enable = true;
      html.enable = true;
      typst = {
        enable = true;
        extensions.typst-preview-nvim.enable = true;
        lsp.enable = true;
        format.type = ["typstyle"];
      };
      tex = {
        enable = true;
        lsp.enable = true;
        treesitter.enable = true;
      };
    };

    lsp = {
      enable = true;
      formatOnSave = true;
      inlayHints.enable = false;
      lspsaga = {
        enable = true;
        setupOpts.lightbulb.enable = false;
      };
      trouble.enable = true;
    };

    formatter.conform-nvim.setupOpts.formatters.typstyle.prepend_args = [
      "--wrap-text"
      "--line-width"
      "80"
    ];

    autocomplete.blink-cmp = {
      enable = true;
      setupOpts.signature.enable = true;
      mappings = {
        complete = "<C-CR>";
        confirm = "<C-Space>";
        next = "<C-j>";
        previous = "<C-k>";
        scrollDocsDown = "<C-l>";
        scrollDocsUp = "<C-h>";
      };
    };

    treesitter = {
      enable = true;
      indent.enable = true;
    };

    utility.surround.enable = true;
    comments.comment-nvim.enable = true;
    git.gitsigns.enable = true;
    utility.oil-nvim = {
      enable = true;
      setupOpts = {
        default_file_explorer = true;
        view_options.show_hidden = true;
        columns = ["icon"];
      };
    };

    telescope = {
      enable = true;
      mappings = {
        liveGrep = "<leader>ps";
        treesitter = "<leader>pt";
        findFiles = "<leader>pf";
        buffers = "<leader>pb";
      };
    };

    assistant = {
      copilot.enable = true;
      codecompanion-nvim = {
        enable = true;
      };
    };

    extraPlugins = {
      texpresso = {
        package = texpressoVimPlugin;

        # Optional, only needed if `texpresso` is not otherwise in PATH.
        setup = ''
          require("texpresso").texpresso_path = "${pkgs.texpresso}/bin/texpresso"
        '';
      };

      split = {
        package = splitNvimPlugin;
        setup = ''
          require("split").setup({
            set_default_mappings = false,
            keymaps = {
              -- Sentence-split the current line.
              ["<leader>ss"] = {
                pattern = "[%.?!]%s+",
                unsplitter = " ",
                smart_ignore = "code",
                quote_characters = {},
                brace_characters = {},
                operator_pending = false,
                interactive = false,
              },

              -- Interactive splitting for the current line.
              ["<leader>si"] = {
                operator_pending = false,
                interactive = true,
              },
            },
          })
        '';
      };
    };
  };
}
