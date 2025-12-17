-- Oil.nvim: Edit filesystem like a buffer
return {
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false, -- Load early for netrw replacement
    opts = {
      -- Replace netrw with oil
      default_file_explorer = true,

      -- Columns to display
      columns = {
        "icon",
        -- "permissions",
        -- "size",
        -- "mtime",
      },

      -- Buffer-local options
      buf_options = {
        buflisted = false,
        bufhidden = "hide",
      },

      -- Window-local options
      win_options = {
        wrap = false,
        signcolumn = "no",
        cursorcolumn = false,
        foldcolumn = "0",
        spell = false,
        list = false,
        conceallevel = 3,
        concealcursor = "nvic",
      },

      -- Skip confirmation for simple operations
      skip_confirm_for_simple_edits = true,

      -- Prompt to save before modifying files
      prompt_save_on_select_new_entry = true,

      -- Cleanup on close
      cleanup_delay_ms = 2000,

      -- Keymaps in oil buffer
      keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-v>"] = "actions.select_vsplit",
        ["<C-s>"] = "actions.select_split",
        ["<C-t>"] = "actions.select_tab",
        ["<C-p>"] = "actions.preview",
        ["<C-c>"] = "actions.close",
        ["<C-l>"] = "actions.refresh",
        ["-"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = "actions.tcd",
        ["gs"] = "actions.change_sort",
        ["gx"] = "actions.open_external",
        ["g."] = "actions.toggle_hidden",
        ["g\\"] = "actions.toggle_trash",
        ["q"] = "actions.close",
        ["<Esc>"] = "actions.close",
      },

      -- Use extended keymaps
      use_default_keymaps = false,

      -- View options
      view_options = {
        show_hidden = true,
        is_hidden_file = function(name, bufnr)
          return vim.startswith(name, ".")
        end,
        is_always_hidden = function(name, bufnr)
          return name == ".." or name == ".git"
        end,
        natural_order = true,
        sort = {
          { "type", "asc" },
          { "name", "asc" },
        },
      },

      -- Float window settings (for Oil.open_float)
      float = {
        padding = 2,
        max_width = 0,
        max_height = 0,
        border = "rounded",
        win_options = {
          winblend = 0,
        },
        override = function(conf)
          conf.width = math.floor(vim.o.columns * 0.6)
          conf.height = math.floor(vim.o.lines * 0.7)
          return conf
        end,
      },

      -- Preview window settings
      preview = {
        max_width = 0.6,
        min_width = { 40, 0.3 },
        max_height = 0.8,
        min_height = { 5, 0.1 },
        border = "rounded",
        win_options = {
          winblend = 0,
        },
        update_on_cursor_moved = true,
      },

      -- Progress indicator
      progress = {
        max_width = 0.5,
        min_width = { 40, 0.3 },
        minimized_border = "none",
        border = "rounded",
        win_options = {
          winblend = 0,
        },
      },

      -- SSH support
      ssh = {
        border = "rounded",
      },

      -- Keymaps help
      keymaps_help = {
        border = "rounded",
      },
    },
    keys = {
      { "-", "<cmd>Oil<cr>", desc = "Oil: Open parent directory" },
      { "<leader>-", "<cmd>Oil --float<cr>", desc = "Oil: Float file browser" },
      { "<leader>o", "<cmd>Oil<cr>", desc = "Oil: File browser" },
    },
  },
}
