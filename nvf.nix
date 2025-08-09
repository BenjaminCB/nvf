{pkgs, ...}: {
  config.vim = {
    globals.mapleader = " ";
    lineNumberMode = "relNumber";

    options = {
      wrap = false;
      colorcolumn = "80";
      shiftwidth = 4;
      tabstop = 4;
      expandtab = true;
      smartindent = true;
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
        action = "<cmd>cprev><cr>";
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

    # Enable custom theming options
    theme = {
      enable = true;
      name = "gruvbox";
      style = "dark";
    };

    statusline.lualine.enable = true;

    formatter.conform-nvim = {
      enable = true;
      setupOpts.format_on_save = {
        lsp_farmat = "fallback";
        timeout_ms = 500;
      };
    };

    languages = {
      enableExtraDiagnostics = true;
      enableFormat = true;
      nix = {
        enable = true;
        lsp.enable = true;
        treesitter.enable = true;
      };
    };

    treesitter = {
      enable = true;
      context.enable = true;
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
  };
}
