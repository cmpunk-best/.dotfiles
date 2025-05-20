
return {
    --{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    { "ellisonleao/gruvbox.nvim", priority = 1000 , config = true, opts = ...},
    { "bluz71/vim-moonfly-colors", name = "moonfly", lazy = false, priority = 1000 },
    {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
    },
    {
    'nvim-telescope/telescope.nvim', tag = '0.1.6',
      dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", 
      "MunifTanjim/nui.nvim",
    }
    },
    {
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-buffer',
    },
    { "rose-pine/neovim",name = "rose-pine"},

  }
