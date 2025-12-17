-- Sidekick AI chat configuration
-- This file configures sidekick's AI CLI integration with space+a keybindings

return {
  {
    "folke/sidekick.nvim",
    keys = {
      -- Main chat toggle
      {
        "<leader>a",
        "",
        desc = "+ai",
        mode = { "n", "v" },
      },
      {
        "<leader>aa",
        function()
          require("sidekick.cli").toggle({ focus = true })
        end,
        desc = "Toggle Sidekick Chat",
        mode = { "n", "v" },
      },

      -- Direct access to specific AI tools
      {
        "<leader>ac",
        function()
          require("sidekick.cli").toggle({ name = "claude", focus = true })
        end,
        desc = "Claude Chat",
        mode = { "n", "v" },
      },
      {
        "<leader>ag",
        function()
          require("sidekick.cli").toggle({ name = "gemini", focus = true })
        end,
        desc = "Gemini Chat",
        mode = { "n", "v" },
      },
      {
        "<leader>ao",
        function()
          require("sidekick.cli").toggle({ name = "copilot", focus = true })
        end,
        desc = "Copilot CLI Chat",
        mode = { "n", "v" },
      },

      -- Prompt actions
      {
        "<leader>ap",
        function()
          require("sidekick.cli").select_prompt()
        end,
        desc = "Select Prompt",
        mode = { "n", "v" },
      },

      -- Quick actions using prompts
      {
        "<leader>ae",
        function()
          require("sidekick.cli").ask({ prompt = "explain", submit = true })
        end,
        desc = "Explain Code",
        mode = { "n", "v" },
      },
      {
        "<leader>af",
        function()
          require("sidekick.cli").ask({ prompt = "fix", submit = true })
        end,
        desc = "Fix Code",
        mode = { "n", "v" },
      },
      {
        "<leader>ar",
        function()
          require("sidekick.cli").ask({ prompt = "review", submit = true })
        end,
        desc = "Review Code",
        mode = { "n", "v" },
      },
      {
        "<leader>at",
        function()
          require("sidekick.cli").ask({ prompt = "tests", submit = true })
        end,
        desc = "Generate Tests",
        mode = { "n", "v" },
      },
      {
        "<leader>ad",
        function()
          require("sidekick.cli").ask({ prompt = "diagnostics", submit = true })
        end,
        desc = "Explain Diagnostics",
        mode = { "n", "v" },
      },
      {
        "<leader>ai",
        function()
          require("sidekick.cli").ask({ prompt = "optimize", submit = true })
        end,
        desc = "Optimize Code",
        mode = { "n", "v" },
      },

      -- Quick question
      {
        "<leader>aq",
        function()
          vim.ui.input({
            prompt = "Ask Sidekick: ",
          }, function(input)
            if input and input ~= "" then
              require("sidekick.cli").ask({ msg = input, submit = true })
            end
          end)
        end,
        desc = "Quick Question",
        mode = { "n", "v" },
      },

      -- Clear/reset chat
      {
        "<leader>ax",
        function()
          local cli = require("sidekick.cli")
          -- Close the current CLI window if open
          local win = cli.get_win()
          if win then
            vim.api.nvim_win_close(win, true)
          end
        end,
        desc = "Close Chat",
        mode = { "n", "v" },
      },

      -- Tab for next edit suggestions (in addition to defaults)
      {
        "<tab>",
        function()
          if not require("sidekick").nes_jump_or_apply() then
            return "<Tab>"
          end
        end,
        expr = true,
        desc = "Goto/Apply Next Edit Suggestion",
        mode = { "n" },
      },
    },

    opts = {
      -- Configure CLI tools
      cli = {
        win = {
          width = 80,
          height = 20,
          layout = "vertical",
          position = "right",
        },
        -- Additional prompts
        prompts = {
          explain = "Explain this code",
          diagnostics = {
            msg = "What do the diagnostics in this file mean?",
            diagnostics = true,
          },
          fix = {
            msg = "Can you fix the issues in this code?",
            diagnostics = true,
          },
          review = {
            msg = "Can you review this code for any issues or improvements?",
            diagnostics = true,
          },
          optimize = "How can this code be optimized?",
          tests = "Can you write tests for this code?",
          document = "Add documentation comments to this code",
        },
      },
    },
  },
}