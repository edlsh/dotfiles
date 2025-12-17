-- Amp: Sourcegraph's agentic coding tool
return {
  {
    "sourcegraph/amp.nvim",
    branch = "main",
    lazy = false,
    opts = {
      auto_start = true,
      log_level = "info",
    },
    config = function(_, opts)
      require("amp").setup(opts)

      -- AmpSend: Send quick message to agent
      vim.api.nvim_create_user_command("AmpSend", function(cmd_opts)
        local message = cmd_opts.args
        if message == "" then
          vim.notify("Please provide a message", vim.log.levels.WARN)
          return
        end
        require("amp.message").send_message(message)
      end, { nargs = "*", desc = "Send a message to Amp" })

      -- AmpSendBuffer: Send entire buffer contents
      vim.api.nvim_create_user_command("AmpSendBuffer", function()
        local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
        require("amp.message").send_message(table.concat(lines, "\n"))
      end, { desc = "Send current buffer to Amp" })

      -- AmpPromptSelection: Add selected text to prompt
      vim.api.nvim_create_user_command("AmpPromptSelection", function(cmd_opts)
        local lines = vim.api.nvim_buf_get_lines(0, cmd_opts.line1 - 1, cmd_opts.line2, false)
        require("amp.message").send_to_prompt(table.concat(lines, "\n"))
      end, { range = true, desc = "Add selection to Amp prompt" })

      -- AmpPromptRef: Add file+selection reference
      vim.api.nvim_create_user_command("AmpPromptRef", function(cmd_opts)
        local bufname = vim.api.nvim_buf_get_name(0)
        if bufname == "" then
          vim.notify("Buffer has no filename", vim.log.levels.WARN)
          return
        end
        local ref = "@" .. vim.fn.fnamemodify(bufname, ":.")
        if cmd_opts.line1 ~= cmd_opts.line2 then
          ref = ref .. "#L" .. cmd_opts.line1 .. "-" .. cmd_opts.line2
        elseif cmd_opts.line1 > 1 then
          ref = ref .. "#L" .. cmd_opts.line1
        end
        require("amp.message").send_to_prompt(ref)
      end, { range = true, desc = "Add file reference to Amp prompt" })
    end,
    keys = {
      { "<leader>as", "<cmd>AmpSend ", desc = "Amp: Send message" },
      { "<leader>ab", "<cmd>AmpSendBuffer<cr>", desc = "Amp: Send buffer" },
      { "<leader>ap", ":'<,'>AmpPromptSelection<cr>", mode = "v", desc = "Amp: Add selection to prompt" },
      { "<leader>ar", ":'<,'>AmpPromptRef<cr>", mode = "v", desc = "Amp: Add file ref to prompt" },
    },
  },
}
