{ pkgs, ... }: 
{
  config.vim = {
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
