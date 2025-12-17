return {
  {
    "folke/twilight.nvim",
    config = function(_, opts)
      require("twilight").setup(opts)
    end,
    opts = {
      dimming = {
        alpha = 0.35,
        color = { "Normal", "#cdd6f4" },
      },
      context = 8,
      expand = { "function", "method" },
    },
  },
}
