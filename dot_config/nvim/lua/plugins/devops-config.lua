-- DevOps configuration loader
return {
  {
    "LazyVim/LazyVim",
    opts = function(_, opts)
      -- Initialize DevOps configuration
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          require("config.devops-init").setup()
        end,
      })
    end,
  },
}