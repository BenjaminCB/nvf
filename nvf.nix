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

    theme = {
      enable = true;
      base16-colors = import ./base16.nix;
    };

    statusline.lualine.enable = true;

    ui.noice.enable = true;
    visuals.nvim-web-devicons.enable = true;

    languages = {
      enableExtraDiagnostics = true;
      enableFormat = true;
      enableTreesitter = true;
      nix = {
        enable = true;
        lsp.enable = true;
      };
      ts = {
        enable = true;
        format.enable = false;
        lsp.enable = true;
      };
      python = {
        enable = true;
        lsp.enable = true;
      };
    };

    lsp = {
      enable = true;
      formatOnSave = true;
      inlayHints.enable = true;
      lspsaga = {
        enable = true;
        setupOpts.lightbulb.enable = false;
      };
      trouble.enable = true;
    };

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
  };
}
