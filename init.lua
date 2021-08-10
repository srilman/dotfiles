-- Package Manager
vim.cmd [[packadd packer.nvim]]
require('packer').startup(function()
  use 'wbthomason/packer.nvim'      -- Let Packer Manage Itself
  use 'ful1e5/onedark.nvim';        -- One Dark Theme
  
  -- Fuzzy Finder Popup
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  }

  -- Status Bar
  use {
    'hoob3rt/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }
end)


-- Map leader to space
vim.g.mapleader = ' '

local opt = vim.opt    -- to set options
local cmd = vim.cmd

local map = function(mode, key, result)
  vim.api.nvim_set_keymap(
    mode, key, result,
    { noremap = true }
  )
end


-- General Configuration
opt.syntax = 'enable'
opt.expandtab = true            -- Use spaces instead of tabs
opt.number = true               -- Show line numbers
opt.relativenumber = true       -- Relative line numbers
opt.scrolloff = 4               -- Lines of context
opt.shiftwidth = 2              -- Size of an indent
opt.smartindent = true          -- Insert indents automatically
opt.tabstop = 2                 -- Number of spaces tabs count for
opt.signcolumn = 'yes'


-- Lualine Configuration
local colors = {
  black  = '#20232a',
  red    = '#e86671',
  cyan   = '#56b6c2',
  purple = '#c678dd',
  yellow = '#daaa78',
  blue   = '#61afef',
  green  = '#98c379',
  fg     = '#abb2bf',
  bg     = '#282c34',
  gray1  = '#5c6370',
  gray2  = '#2c323d',
}

local custom_theme = {
  normal = {
    a = {fg = colors.black, bg = colors.cyan, gui = 'bold'},
    b = {fg = colors.black, bg = colors.gray1, gui = 'bold'},
    c = {fg = colors.fg, bg = colors.gray2}
  },
  insert = {a = {fg = colors.black, bg = colors.green, gui = 'bold'}},
  command = {a = {fg = colors.black, bg = colors.purple, gui = 'bold'}},
  visual = {a = {fg = colors.black, bg = colors.red, gui = 'bold'}},
  replace = {a = {fg = colors.black, bg = colors.yellow, gui = 'bold'}},
  inactive = {
    a = {fg = colors.gray1, bg = colors.bg, gui = 'bold'},
    b = {fg = colors.gray1, bg = colors.bg},
    c = {fg = colors.gray1, bg = colors.gray2}
  }
}

require('lualine').setup {
  options = {
    theme = custom_theme,
    section_separators = '',
    component_separators = '|',
  },
  sections = {
    lualine_b = {{'filename', path = 1}},
    lualine_c = {
      {'branch', icon = "", component_separators = '', color = {gui = 'bold'}},
      {
        'diff', 
        colored = true, 
        component_separators = '', 
        padding = 0,
        color_added = colors.green,
        color_modified = colors.yellow,
        color_removed = colors.red,
        symbols = {added = '+', modified = '~', removed = '-'}
      },
    },
    lualine_x = {
      'encoding', 
      {'fileformat', icons_enabled = false, upper = true}, 
      'filetype'
    },
  }
}

require("onedark").setup()
require("telescope").setup()


-- Key Mapings
map('i', 'jj', '<ESC>')
map('n', '<leader>ff', ':lua require("telescope.builtin").git_files()<CR>')
--map('n', 'fd', ':lua require("telescope.builtin").live_grep()<CR>')
--map('n', 'fs', ':lua require("telescope.builtin").buffers()<CR>')
--map('n', 'fa', ':lua require("telescope.builtin").help_tags()<CR>')
