require("neo-tree").setup({
  filesystem = {
    bind_to_cwd = true,
    filtered_items = {
      visible = false, -- when true, they will just be displayed differently than normal items
      hide_dotfiles = false,
      hide_gitignored = false,
      hide_by_name = {
        -- ".DS_Store",
        -- "thumbs.db",
        --"node_modules",
      },
      hide_by_pattern = {
        --"*.meta",
        --"*/src/*/tsconfig.json",
      },
      always_show = { -- remains visible even if other settings would normally hide it
        ".gitignored",
        ".gitignore",
      },
      never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
        --".DS_Store",
        --"thumbs.db",
      },
      never_show_by_pattern = { -- uses glob style patterns
        --".null-ls_*",
      },
    },
  },
  default_component_configs = {
    symbols = {
      -- Change type
      added     = "✚",
      deleted   = "✖",
      modified  = "",
      renamed   = "󰁕",
      -- Status type
      untracked = "",
      ignored   = "",
      unstaged  = "󰄱",
      staged    = "",
      conflict  = "",
    }
  },
  event_handlers = {
    {
      event = "file_opened",
      handler = function(file_path)
        -- auto close
        -- vimc.cmd("Neotree close")
        -- OR
        require("neo-tree.command").execute({ action = "close" })
      end
    },

  }
})

-- {
--   event = "file_opened",
--   handler = function(arg)
--     -- do something, the value of arg varies by event.
--   end,
--   id = "optional unique id, only meaningful if you want to unsubscribe later"
-- },
-- {
--   event = "neo_tree_buffer_leave",
--   handler = function(arg)
--     -- do something, the value of arg varies by event.
--   end,
--   id = "optional unique id, only meaningful if you want to unsubscribe later"
-- }
