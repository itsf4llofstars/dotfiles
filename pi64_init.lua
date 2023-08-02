-- [[ Neovim Init Lua ]]
-- Table of Contents
-- Treesitter
-- Telescope
-- Which key
-- Mason
-- Mason Lsp-Config

require('plugins')

-- [[ Treesitter ]] <<<
require'nvim-treesitter.configs'.setup {
  modules = { "python" },
  ensure_installed = { "c", "rust", "lua", "vim", "vimdoc", "python" },
  sync_install = false,
  auto_install = true,
  ignore_install = { "javascript" },

  highlight = {
    enable = true,
    -- disable = { "c", "rust" },
    additional_vim_regex_highlighting = false,
  },
}
-- >>>

-- [[ Telescope ]] <<<
require('telescope').setup({
  defaults = {
    layout_config = {
      vertical = { width = 0.5 },
    },
  },
}) -- >>>

-- [[ Which key ]] <<<
require('which-key').setup({
  plugins = {
    marks = true,
    registers = true,
    spelling = {
      enabled = true,
      suggestions = 10,
    },
    presets = {
      operators = true,
      motions = true,
      text_objects = true,
      windows = true,
      nav = true,
      z = true,
      g = true,
    },
  },
  operators = { gc = "Comments" },
  key_labels = {
    ["<space>"] = "SPC",
    ["<tab>"] = "TAB",
    ["<cr>"] = "RET",
  },
  motions = {
    count = true,
  },
  icons = {
    breadcrumb = "»",
    separator = "➜",
    group = "+",
  },
  popup_mappings = {
    scroll_down = "<c-d>",
    scroll_up = "<c-u>",
  },
  window = {
    border = "single",
    position = "bottom",
    margin = { 1, 0, 1, 0 },
    padding = { 1, 2, 1, 2 },
    winblend = 0,
    zindex = 1000,
  },
  layout = {
    height = { min = 4, max = 25 },
    width = { min = 20, max = 50 },
    spacing = 3,
    align = "left",
  },
  ignore_missing = false,
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "^:", "^ ", "^call ", "^lua " },
  show_help = true,
  show_keys = true,
  triggers = "auto",
  -- triggers = {"<leader>"} -- or specifiy a list manually
  triggers_nowait = {
    -- marks
    "`",
    "'",
    "g`",
    "g'",
    '"',
    "<c-r>",
    "z=",
  },
  triggers_blacklist = {
    i = { "j", "k" },
    v = { "j", "k" },
  },
  disable = {
    buftypes = {},
    filetypes = {},
  },
}) -- >>>

-- [[ Mason ]] <<<
require('mason').setup({
  ui = {
    check_outdated_packages_on_open = true,
    border = "none",
    width = 0.8,
    height = 0.9,

    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },

    keymaps = {
      toggle_package_expand = "<CR>",
      install_package = "i",
      update_package = "u",
      check_package_version = "c",
      update_all_packages = "U",
      check_outdated_packages = "C",
      uninstall_package = "X",
      cancel_installation = "<C-c>",
      apply_language_filter = "<C-f>",
    },
  },
  registries = {
    "github:mason-org/mason-registry",
  },
  providers = {
    "mason.providers.registry-api",
    "mason.providers.client",
  },
  github = {
    download_url_template = "https://github.com/%s/releases/download/%s/%s",
  },

  pip = {
    upgrade_pip = false,
    install_args = {},
  },
}) -- >>>

-- [[ Mason Lsp-Config ]] <<<
require('mason-lspconfig').setup({
  -- ensure_installed = { "lua_ls", "jedi_language_server", "rust_analyzer", "bashls", "cmake", "jsonls"},
  automatic_installation = false,
  handlers = nil,
  diagnostics = {
    globals = {
      "vim"
    }
  },
}) -- >>>

-- [[ LSP Configs ]] <<<
require('lspconfig').lua_ls.setup{}
require('lspconfig').lua_ls.setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {
          'vim',
          'require'
        },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
} -- >>>

-- [[ LSP Config Setup ]] <<<
local capabilities = require('cmp_nvim_lsp').default_capabilities()
require('lspconfig').jedi_language_server.setup {
  require('cmp_nvim_lsp').default_capabilities(capabilities)
  -- capabilities = capabilities
}
require('lspconfig').bashls.setup {
  capabilities = capabilities
}
require('lspconfig').cmake.setup {
  capabilities = capabilities
}
require('lspconfig').jsonls.setup {
  capabilities = capabilities
}
require('lspconfig').rust_analyzer.setup {
  capabilities = capabilities
} -- >>>

-- [[ CMP ]] <<<
local cmp = require'cmp'
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
    { name = 'luasnip' }, -- For luasnip users.
  }, {
    { name = 'buffer' },
  })
}) -- >>>

-- [[ Catppuccin ]] <<<
require("catppuccin").setup({
  flavour = "mocha", -- latte, frappe, macchiato, mocha
  background = {
    light = "latte",
    dark = "mocha",
  },
  transparent_background = false,
  show_end_of_buffer = false,
  term_colors = false,
  dim_inactive = {
    enabled = false,
    shade = "dark",
    percentage = 0.15,
  },
  no_italic = false,
  no_bold = false,
  no_underline = true,
  styles = {
    comments = { "italic" },
    conditionals = { "italic" },
    loops = {},
    functions = {},
    keywords = {},
    strings = {},
    variables = {},
    numbers = {},
    booleans = {},
    properties = {},
    types = {},
    operators = {},
  },
  color_overrides = {},
  custom_highlights = {},
  integrations = {
    cmp = true,
    gitsigns = true,
    nvimtree = true,
    treesitter = true,
    notify = false,
    mini = false,
  },
})

vim.cmd.colorscheme "catppuccin"
-- >>>

-- [[ Indent Line ]] <<<
require("indent_blankline").setup {
  -- for example, context is off by default, use this to turn it on
  show_current_context = true,
  show_current_context_start = true,
} -- >>>

require('settings')
require('keymaps')
require('autogroups')

-- LUA LINE <<<
--[[
require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    component_separators = { left = '|', right = '|'},
    section_separators = { left = '|', right = '|'},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
]]
-- >>>
