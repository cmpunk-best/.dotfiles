
--------------------
--- Basic Vim 
--------------------
vim.cmd("set expandtab")
vim.cmd("set relativenumber")
vim.cmd("set nu")
vim.cmd("set tabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set nohlsearch")
-- Highlighting the current line
vim.cmd("set cursorline")
vim.cmd("set clipboard=unnamed")
vim.g.mapleader = " "
--------------------
--- LazyPlugin 
--------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
-- Calling lazy to download plugins
require("lazy").setup("plugins")
require("neo-tree").setup({
  close_if_last_window = true,
  window = {
    position = 'bottom',
    width = 25,
    indent = 0,  -- Set to 1 for a small separation line
  },
  default_component_configs = {
    indent = {
      indent_marker = '',  -- Customize the indent marker if desired
      last_indent_marker = '',  -- Customize the last indent marker
    },
  },
})

--------------------
--- KeyMaps
--------------------

local builtin = require("telescope.builtin")
vim.keymap.set('n','<leader>p', builtin.find_files,{})
vim.keymap.set('n','<leader>f', builtin.find_files,{})
vim.keymap.set('n','<leader>g', builtin.live_grep,{})
vim.keymap.set('n','<leader>n', ':Neotree filesystem reveal right toggle<CR>')
-- Completions
-- init.lua or cmp-config.lua
local cmp = require('cmp')
cmp.setup({
  snippet = {
    expand = function(args)
      -- For simplicity, not using snippets here
    end,
  },
  mapping = {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-u>'] = cmp.mapping.select_prev_item(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<C-space>'] = cmp.mapping.close(),
  },
  sources = cmp.config.sources({
    { name = 'buffer' }, -- Enable buffer source for autocompletion
  }),
})
-- Optional: Map <C-Space> to trigger completion
vim.api.nvim_set_keymap('i', '<C-Space>', [[cmp#complete()]], { expr = true, silent = true })


--------------------
--- THEME 
--------------------
-- will exclude all javascript snippets
-- Colorscheme
--require("gruvbox").setup()
--require("darkvoid").setup()
require("catppuccin").setup({
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    background = { -- :h background
        light = "latte",
        dark = "mocha",
    },
    transparent_background = true, -- disables setting the background color.
    show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
    no_italic = true, -- Force no italic
  }) 
--[[
require("rose-pine").setup({
                variant = "moon",      -- auto, main, moon, or dawn
                dark_variant = "moon", -- main, moon, or dawn
                dim_inactive_windows = false,
                -- disable_background = true,
                -- disable_nc_background = false,
                -- disable_float_background = false,
                -- extend_background_behind_borders = false,
                styles = {
                  bold = true,
                  italic = false,
                  transparency = true,
                },
                highlight_groups = {
                     ColorColumn = { bg = "#1C1C21" },
                     -- Normal = { bg = "none" },                      -- Main background remains transparent
                     Pmenu = { bg = "", fg = "#e0def4" },           -- Completion menu background
                     PmenuSel = { bg = "#4a465d", fg = "#f8f5f2" }, -- Highlighted completion item
                     PmenuSbar = { bg = "#191724" },                -- Scrollbar background
                     PmenuThumb = { bg = "#9ccfd8" },               -- Scrollbar thumb
                },
                enable = {
                    terminal = false,
                    legacy_highlights = false, -- Improve compatibility for previous versions of Neovim
                    migrations = true,         -- Handle deprecated options automatically
                },

})
--]]

vim.o.background = "dark" -- or "light" for light mode
--vim.cmd.colorscheme("retrobox")
vim.cmd.colorscheme("catppuccin")
vim.g.moonflyTransparent = true

vim.g.moonflyCursorColor = true
vim.g.moonflyWinSeparator = 2

--------------------
--- Lualine
--------------------
local colors = {
  blue   = '#80a0ff',
  cyan   = '#79dac8',
  black  = '#080808',
  white  = '#c6c6c6',
  red    = '#ff5189',
  --red    = '#ff9fbf',
  violet = '#d183e8',
  grey   = '#080808',
  green  = '#00e600',
  
}

local bubbles_theme = {
  normal = {
    a = { fg = colors.black, bg = colors.red},
    b = { fg = colors.white, bg = colors.grey },
    c = { fg = colors.white },
  },

  insert = { a = { fg = colors.black, bg = colors.blue } },
  visual = { a = { fg = colors.black, bg = colors.cyan } },
  replace = { a = { fg = colors.black, bg = colors.red } },

  inactive = {
    a = { fg = colors.white, bg = colors.black },
    b = { fg = colors.white, bg = colors.black },
    c = { fg = colors.white },
  },
}
require('lualine').setup {
  options = {
    theme = bubbles_theme,
    component_separators = '',
    --section_separators = { left = '', right = '' },
    section_separators = { left = '', right = ''},
    icons_enabled = true,
  },
  sections = {
    lualine_a = { 
      { 'mode', separator = { right = '' }, right_padding = 2 ,
            fmt = function(str)
          local mode_map = {
            ['NORMAL'] = 'N',
            ['INSERT'] = 'I',
            ['VISUAL'] = 'V',
            ['V-LINE'] = 'V',
            ['V-BLOCK'] = 'V',
            ['REPLACE'] = 'R',
            ['COMMAND'] = 'C',
            ['SELECT'] = 'S',
            ['S-LINE'] = 'S',
            ['S-BLOCK'] = 'S',
            ['EX'] = 'E',
            ['TERMINAL'] = 'T',
          }
          return mode_map[str] or str
        end
      },
      {
        'branch', separator = { right = '' }, right_padding = 2,
        color = {fg = colors.white , bg = colors.black}
      }
    },
    lualine_b = {  
    {'buffers',
     use_mode_colors = false,
      buffers_color = {
        -- Same values as the general color option can be used here.
        --active = 'LualineActiveBuffer',
        active = { fg =colors.black, bg = colors.green },
        --inactive = 'LualineInactiveBuffer',
      },
    symbols = {
        modified = ' ●',   -- Symbol for modified buffers
        alternate_file = '',
      },
    }
    },
    lualine_c = {
      '%=', --[[ add your center compoentnts here in place of this comment ]]
    },
    lualine_x = {
    },
    lualine_y = { 'filetype', 'progress' },
    lualine_z = {
      --{ 'location', separator = { right = '' }, left_padding = 0 },
      {
        function()
          local hour = tonumber(os.date('%H'))
          local icon = (hour >= 6 and hour < 18) and ' ' or '󰖔 ' 
        return icon .. os.date('%H:%M')
        end,
        --icon = '󱩷', -- Optional clock icon--
        separator = {  right = '' },
        left_padding=0,
        color = { fg = colors.violet, bg = colors.black }, -- Custom colors for time
      },
    },
  },
  inactive_sections = {
    lualine_a = { 'filename' },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { 'location' },
  },
  tabline = {},
  extensions = {},
}
--require('lualine').setup {
--  options = {
--    component_separators = '',
--    section_separators = ''
--  }
--}

--------------------
--- Misc KeyMaps 
--------------------

-- Slide split screen left
vim.api.nvim_set_keymap('n', '<leader>h', '<C-w>h', { noremap = true, silent = true })
-- Slide split screen right
vim.api.nvim_set_keymap('n', '<leader>l', '<C-w>l', { noremap = true, silent = true })

-- Increase split screen width by 2 columns
vim.api.nvim_set_keymap('n', '<Right>', ':vertical resize +2<CR>', { noremap = true, silent = true })

-- Decrease split screen width by 2 columns
vim.api.nvim_set_keymap('n', '<Left>', ':vertical resize -2<CR>', { noremap = true, silent = true })
-- Opening Ex
vim.api.nvim_set_keymap('n', '<leader>p', ':Ex<CR>', { noremap = true, silent = true })

-- Buffers
vim.api.nvim_set_keymap('n', ',', ':bn<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '.', ':bp<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>d', ':bd<CR>', { noremap = true, silent = true })




