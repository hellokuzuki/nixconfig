{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    
    # Core plugins with Telescope and LSP
    plugins = with pkgs.vimPlugins; [
      # Essential dependencies
      plenary-nvim
      nvim-web-devicons
      
      # Telescope
      telescope-nvim
      telescope-fzf-native-nvim
      
      # Treesitter
      nvim-treesitter.withAllGrammars
      nvim-treesitter-context
      nvim-treesitter-textobjects
      
      # LSP
      nvim-lspconfig
      
      # Completion
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-cmdline
      cmp_luasnip
      luasnip
      friendly-snippets
      
      # UI enhancements
      lualine-nvim
      bufferline-nvim
      which-key-nvim
      gitsigns-nvim
      indent-blankline-nvim
      
      # Colorscheme
      tokyonight-nvim
      catppuccin-nvim
      
      # File explorer
      neo-tree-nvim
      nui-nvim
      
      # Utilities
      comment-nvim
      todo-comments-nvim
      vim-fugitive
    ];
    
    extraLuaConfig = ''
      -- Set leader key
      vim.g.mapleader = " "
      vim.g.maplocalleader = "\\"
      
      -- Basic options
      vim.opt.number = true
      vim.opt.relativenumber = true
      vim.opt.expandtab = true
      vim.opt.tabstop = 2
      vim.opt.shiftwidth = 2
      vim.opt.smartindent = true
      vim.opt.wrap = false
      vim.opt.ignorecase = true
      vim.opt.smartcase = true
      vim.opt.termguicolors = true
      vim.opt.scrolloff = 8
      vim.opt.updatetime = 50
      vim.opt.colorcolumn = "80"
      
      -- Setup catppuccin colorscheme
      local has_catppuccin, catppuccin = pcall(require, "catppuccin")
      if has_catppuccin then
        catppuccin.setup({
          flavour = "mocha", -- latte, frappe, macchiato, mocha
          transparent_background = false,
          integrations = {
            telescope = true,
            treesitter = true,
            cmp = true,
            gitsigns = true,
            which_key = true,
            indent_blankline = {
              enabled = true,
              colored_indent_levels = false,
            },
          }
        })
        vim.cmd.colorscheme("catppuccin")
      else
        -- Try tokyonight as fallback
        local has_tokyo = pcall(vim.cmd, 'colorscheme tokyonight')
        if not has_tokyo then
          vim.cmd.colorscheme("default")
        end
      end
      
      -- Telescope setup and keymaps
      local telescope = require('telescope')
      telescope.setup({
        defaults = {
          mappings = {
            i = {
              ["<C-j>"] = "move_selection_next",
              ["<C-k>"] = "move_selection_previous",
            }
          }
        }
      })
      
      -- Load fzf extension
      telescope.load_extension('fzf')
      
      -- Telescope keybindings
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find files' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Live grep' })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find buffers' })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Help tags' })
      vim.keymap.set('n', '<leader>fo', builtin.oldfiles, { desc = 'Recent files' })
      vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = 'Find word' })
      vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'Diagnostics' })
      vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = 'Resume' })
      vim.keymap.set('n', '<leader>fs', builtin.git_status, { desc = 'Git status' })
      vim.keymap.set('n', '<leader>fc', builtin.git_commits, { desc = 'Git commits' })
      vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = 'Git branches' })
      
      -- LSP setup
      local lspconfig = require('lspconfig')
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      
      -- Setup LSP servers (only those that are installed)
      -- For Nix LSP
      local ok_nil, _ = pcall(function()
        lspconfig.nil_ls.setup({
          capabilities = capabilities,
        })
      end)
      
      -- For TypeScript/JavaScript (using ts_ls instead of deprecated tsserver)
      local ok_ts, _ = pcall(function()
        lspconfig.ts_ls.setup({
          capabilities = capabilities,
        })
      end)
      
      -- For Python
      local ok_py, _ = pcall(function()
        lspconfig.pyright.setup({
          capabilities = capabilities,
        })
      end)
      
      -- For Lua
      local ok_lua, _ = pcall(function()
        lspconfig.lua_ls.setup({
          capabilities = capabilities,
          settings = {
            Lua = {
              diagnostics = {
                globals = { 'vim' }
              }
            }
          }
        })
      end)
      
      -- LSP keymaps
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'Find references' })
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'Go to implementation' })
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover' })
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code action' })
      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename' })
      vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, { desc = 'Format' })
      
      -- Completion setup
      local cmp = require('cmp')
      cmp.setup({
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'path' },
        })
      })
      
      -- Lualine
      local has_lualine, lualine = pcall(require, 'lualine')
      if has_lualine then
        lualine.setup({
          options = {
            theme = 'auto'  -- Use auto to match current colorscheme
          }
        })
      end
      
      -- Gitsigns
      pcall(function() require('gitsigns').setup() end)
      
      -- Comment
      pcall(function() require('Comment').setup() end)
      
      -- Which-key
      pcall(function() require('which-key').setup() end)
      
      -- Indent blankline
      pcall(function() require('ibl').setup() end)
      
      -- Neo-tree
      vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>', { desc = 'File explorer' })
    '';
  };
}