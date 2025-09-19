{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    
    # Add some useful plugins
    plugins = with pkgs.vimPlugins; [
      vim-nix
      vim-fugitive
      nvim-treesitter.withAllGrammars
      plenary-nvim
      telescope-nvim
      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      luasnip
      cmp_luasnip
    ];
    
    extraConfig = ''
      set number
      set relativenumber
      set expandtab
      set tabstop=2
      set shiftwidth=2
      set softtabstop=2
      set smartindent
      set wrap
      set ignorecase
      set smartcase
      set termguicolors
      set scrolloff=8
      set updatetime=50
      set colorcolumn=80
    '';
  };
}