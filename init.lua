-- OPTIONS
local opt = vim.opt

opt.number = true          	-- line numbers
opt.relativenumber = false 	-- relative line numbers
opt.tabstop = 4            	-- 2 spaces for tab
opt.shiftwidth = 2         	-- 2 spaces for indent
opt.expandtab = true       	-- spaces instead of tabs
opt.smartindent = true     	-- auto indent
opt.wrap = true            	-- no line wrap
opt.mouse = "a"            	-- mouse support
opt.clipboard = "unnamedplus"	-- use system clipboard
opt.termguicolors = true	-- full color support
opt.scrolloff = 8          	-- keep 8 lines above/below cursor
opt.signcolumn = "yes"     	-- always show sign column
opt.cursorline = true      	-- highlight current line
opt.splitbelow = true      	-- horizontal splits go below
opt.splitright = true      	-- vertical splits go right

-- KEYMAPS
local map = vim.keymap.set
vim.g.mapleader = " "

-- ── File ──────────────────────────────────────────────
map("n", "<leader>w", ":w<CR>",           { desc = "Save" })
map("n", "<leader>q", ":q<CR>",           { desc = "Quit" })
map("n", "<leader>Q", ":qa<CR>",          { desc = "Quit all" })

-- ── Duplicate line (Cmd+D) ────────────────────────────
map("n", "<leader>d", "yyp",              { desc = "Duplicate line" })
map("v", "<leader>d", "y'>p",             { desc = "Duplicate selection" })

-- ── Comment (Cmd+/) ───────────────────────────────────
-- requires Comment.nvim plugin (we'll add later)
map("n", "<C-/>", "gcc", { desc = "Toggle comment", remap = true })
map("v", "<C-/>", "gc",  { desc = "Toggle comment", remap = true })


-- ── Search everywhere (Shift+Shift) ───────────────────
-- requires Telescope (we'll add later)
map("n", "<leader><leader>", "<cmd>Telescope find_files<CR>",  { desc = "Search files" })
map("n", "<leader>/",        "<cmd>Telescope live_grep<CR>",   { desc = "Search in project" })
map("n", "<leader>e",        "<cmd>Telescope recent_files<CR>",{ desc = "Recent files" })

-- ── Code actions / LSP (Alt+Enter, Shift+F6) ──────────
-- activates once LSP is set up
map("n", "<leader>a", vim.lsp.buf.code_action, { desc = "Code action" })
map("n", "<F6>",      vim.lsp.buf.rename,         { desc = "Rename (Shift+F6 → F6)" })
map("n", "<leader>f", vim.lsp.buf.format,         { desc = "Format file (Cmd+Alt+L)" })

-- ── Go to definition / usages (Cmd+B, Alt+F7) ─────────
map("n", "<M-b>",  vim.lsp.buf.definition,        { desc = "Go to definition (Alt+B)" })
map("n", "<M-u>", vim.lsp.buf.references,        { desc = "Find usages (Alt+F7)" })
map("n", "K",      vim.lsp.buf.hover,             { desc = "Hover docs" })

-- ── Errors (F2) ───────────────────────────────────────
map("n", "<F2>",   function() vim.diagnostic.jump({ count = 1 });  vim.defer_fn(function() vim.diagnostic.open_float({ scope = "line" }) end, 500) end, { desc = "Next diagnostic" })
map("n", "<S-F2>", function() vim.diagnostic.jump({ count = -1 }); vim.defer_fn(function() vim.diagnostic.open_float({ scope = "line" }) end, 500) end, { desc = "Prev diagnostic" })

-- ── Buffer switching (Cmd+Shift+[ / ]) ────────────────
map("n", "<M-[>", ":bprevious<CR>",               { desc = "Prev buffer" })
map("n", "<M-]>", ":bnext<CR>",                   { desc = "Next buffer" })
map("n", "<M-w>", ":bdelete<CR>",                 { desc = "Close buffer" })

-- ── Splits ────────────────────────────────────────────
map("n", "<C-h>", "<C-w>h",                       { desc = "Move left" })
map("n", "<C-l>", "<C-w>l",                       { desc = "Move right" })
map("n", "<C-j>", "<C-w>j",                       { desc = "Move down" })
map("n", "<C-k>", "<C-w>k",                       { desc = "Move up" })

-- ── Navigation ────────────────────────────────────────
map("n", "<C-d>", "<C-d>zz",                      { desc = "Scroll down centered" })
map("n", "<C-u>", "<C-u>zz",                      { desc = "Scroll up centered" })
map("v", "J",     ":m '>+1<CR>gv=gv",             { desc = "Move selection down" })
map("v", "K",     ":m '<-2<CR>gv=gv",             { desc = "Move selection up" })

-- ── Misc ──────────────────────────────────────────────
map("n", "<Esc>", ":nohlsearch<CR>",              { desc = "Clear search highlight" })
map("n", "<leader>t", ":Neotree toggle<CR>", { desc = "Toggle file tree" })
map("n", "<leader>g", ":LazyGit<CR>", { desc = "LazyGit" })

map("n", "<F1>", ":Cheatsheet<CR>", { desc = "Cheatsheet" })

-- ── Floating terminal (`) ─────────────────────────────
map("n", "`", "<cmd>FloatermToggle<CR>", { desc = "Toggle floating terminal" })
map("t", "`", "<cmd>FloatermToggle<CR>", { desc = "Toggle floating terminal" })


-- PLUGINS (lazy.nvim)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- COLORSCHEME (Catppuccin - dark, modern, IntelliJ-like)
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,  -- load before everything else
    config = function()
      vim.cmd.colorscheme("catppuccin-mocha")
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    main = "nvim-treesitter.config",
    opts = {
      ensure_installed = { "lua", "go", "gomod", "gosum", "json", "yaml", "markdown" },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    },
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        sorting_strategy = "ascending",
        layout_config = {
          prompt_position = "top",
        },
      },
    },
  },

  -- Mason: auto-installs language servers
  {
    "williamboman/mason.nvim",
    opts = {},
  },

  -- LSP progress notifications
  {
    "j-hui/fidget.nvim",
    opts = {},
  },

  -- Highlight TODO/FIXME/NOTE/HACK in comments
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },

  -- Smooth animations for cursor, scroll, and window resize
  {
    "echasnovski/mini.animate",
    opts = {},
  },

  -- Diagnostics panel (GoLand-like Problems window)
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",          desc = "Diagnostics panel" },
      { "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Document diagnostics" },
      { "<leader>xw", "<cmd>Trouble diagnostics toggle<cr>",          desc = "Workspace diagnostics" },
    },
  },

  -- Bridge between mason and lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "gopls" },  -- Go language server
      automatic_installation = true,
    },
  },


  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      vim.lsp.config("gopls", {
        settings = {
          gopls = {
            analyses = { unusedparams = true },
            staticcheck = true,
          },
        },
      })
      vim.lsp.enable("gopls")
    end,
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      delay = 500,  -- ms to wait before showing popup
    },
  },

  -- Completion engine
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",    -- LSP completions
      "hrsh7th/cmp-buffer",      -- buffer word completions
      "hrsh7th/cmp-path",        -- file path completions
      "L3MON4D3/LuaSnip",        -- snippet engine
      "saadparwaiz1/cmp_luasnip", -- snippet completions
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-j>"] = cmp.mapping.select_next_item(),  -- next suggestion
          ["<C-k>"] = cmp.mapping.select_prev_item(),  -- prev suggestion
          ["<C-Space>"] = cmp.mapping.complete(),       -- trigger completion
          ["<C-e>"] = cmp.mapping.abort(),              -- close completion
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- confirm
          ["<Tab>"] = cmp.mapping.confirm({ select = true }), -- confirm with tab
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      filesystem = {
        follow_current_file = { enabled = true },
        hijack_netrw_behavior = "open_current",
      },
      window = {
        width = 30,
      },
    },
  },


    -- Git signs in gutter
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,  -- shows git blame on current line
    },
  },

  -- Lazygit inside neovim
  {
    "kdheepak/lazygit.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },



  -- Comment with Ctrl+/
  {
    "numToStr/Comment.nvim",
    opts = {},
  },

  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "catppuccin",
        globalstatus = true,
      },
    },
  },

  -- Indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
  },

  -- Auto close brackets
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },

  {
    "sudormrfbin/cheatsheet.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    opts = {
      bundled_cheatsheets = true,
      bundled_plugin_cheatsheets = true,
      include_only_installed_plugins = true,
    },
  },

  {
    "nvzone/floaterm",
    dependencies = { "nvzone/volt" },
    cmd = "FloatermToggle",
    opts = {
      border = true,
      size = { h = 90, w = 90 },
    },
  },

})

