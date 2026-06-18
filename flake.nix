{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nvf.url = "github:notashelf/nvf";
    texpresso-vim = {
      url = "github:let-def/texpresso.vim";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    nvf,
    texpresso-vim,
    ...
  } @ inputs: {
    packages.x86_64-linux = {
      # Set the default package to the wrapped instance of Neovim.
      # This will allow running your Neovim configuration with
      # `nix run` and in addition, sharing your configuration with
      # other users in case your repository is public.
      default =
        (inputs.nvf.lib.neovimConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = {inherit inputs texpresso-vim;};
          modules = [
            ./nvf.nix
          ];
        })
        .neovim;
    };
  };
}
