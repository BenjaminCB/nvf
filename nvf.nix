{ pkgs, ... }: 
{
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

    # Enable custom theming options
    theme = {
      enable = true;
      name = "gruvbox";
      style = "dark";
    };

    treesitter.enable = true;
    telescope.enable = true;
    statusline.lualine.enable = true;
  };
}
