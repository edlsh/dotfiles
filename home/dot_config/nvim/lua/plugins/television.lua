-- Television: Blazing fast fuzzy finder (Rust-powered)
-- Requires: brew install television
return {
  {
    "alexpasmantier/tv.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local h = require("tv").handlers

      require("tv").setup({
        -- Global window appearance
        window = {
          width = 0.85,
          height = 0.85,
          border = "rounded",
          title = " Television ",
          title_pos = "center",
        },

        -- Per-channel configurations
        channels = {
          -- Find files (like telescope find_files)
          files = {
            keybinding = "<C-p>",
            handlers = {
              ["<CR>"] = h.open_as_files,
              ["<C-q>"] = h.send_to_quickfix,
              ["<C-s>"] = h.open_in_split,
              ["<C-v>"] = h.open_in_vsplit,
              ["<C-y>"] = h.copy_to_clipboard,
            },
          },

          -- Grep text in files (like telescope live_grep)
          text = {
            keybinding = "<leader><leader>",
            handlers = {
              ["<CR>"] = h.open_at_line,
              ["<C-q>"] = h.send_to_quickfix,
              ["<C-s>"] = h.open_in_split,
              ["<C-v>"] = h.open_in_vsplit,
              ["<C-y>"] = h.copy_to_clipboard,
            },
          },

          -- Git log browser
          ["git-log"] = {
            keybinding = "<leader>gl",
            handlers = {
              ["<CR>"] = function(entries, config)
                if #entries > 0 then
                  vim.cmd("enew | setlocal buftype=nofile bufhidden=wipe")
                  vim.cmd("silent 0read !git show " .. vim.fn.shellescape(entries[1]))
                  vim.cmd("1delete _ | setlocal filetype=git nomodifiable")
                  vim.cmd("normal! gg")
                end
              end,
              ["<C-y>"] = h.copy_to_clipboard,
            },
          },

          -- Git branch switcher
          ["git-branch"] = {
            keybinding = "<leader>gb",
            handlers = {
              ["<CR>"] = h.execute_shell_command("git checkout {}"),
              ["<C-y>"] = h.copy_to_clipboard,
            },
          },

          -- Git status
          ["git-diff"] = {
            keybinding = "<leader>gd",
            handlers = {
              ["<CR>"] = h.open_as_files,
              ["<C-q>"] = h.send_to_quickfix,
            },
          },

          -- Buffer list
          buffers = {
            keybinding = "<leader>,",
            handlers = {
              ["<CR>"] = h.open_as_files,
              ["<C-q>"] = h.send_to_quickfix,
            },
          },

          -- Environment variables
          env = {
            keybinding = "<leader>se",
            handlers = {
              ["<CR>"] = h.insert_at_cursor,
              ["<C-y>"] = h.copy_to_clipboard,
            },
          },

          -- Shell aliases
          alias = {
            keybinding = "<leader>sa",
            handlers = {
              ["<CR>"] = h.insert_at_cursor,
              ["<C-y>"] = h.copy_to_clipboard,
            },
          },
        },

        tv_binary = "tv",
        global_keybindings = {
          channels = "<leader>tv", -- Opens the channel selector
        },
        quickfix = {
          auto_open = true,
        },
      })
    end,
    keys = {
      { "<C-p>", desc = "TV: Find files" },
      { "<leader><leader>", desc = "TV: Grep text" },
      { "<leader>gl", desc = "TV: Git log" },
      { "<leader>gb", desc = "TV: Git branches" },
      { "<leader>gd", desc = "TV: Git diff" },
      { "<leader>,", desc = "TV: Buffers" },
      { "<leader>tv", desc = "TV: Channel selector" },
      { "<leader>se", desc = "TV: Environment vars" },
      { "<leader>sa", desc = "TV: Shell aliases" },
    },
    cmd = "Tv",
  },
}
