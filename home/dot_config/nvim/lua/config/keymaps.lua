local map = vim.keymap.set

map("n", "<leader>ff", function()
  require("telescope.builtin").find_files()
end, { desc = "Find files" })

map("n", "<leader>fg", function()
  require("telescope.builtin").live_grep()
end, { desc = "Live grep" })

map("n", "<leader>fb", function()
  require("telescope.builtin").buffers()
end, { desc = "Find buffers" })

map("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
map("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })

local diagnostics_active = true

map("n", "<leader>td", function()
  diagnostics_active = not diagnostics_active
  if diagnostics_active then
    vim.diagnostic.enable()
  else
    vim.diagnostic.disable()
  end
end, { desc = "Toggle diagnostics" })

map({ "n", "v" }, "<leader>ac", function()
  vim.cmd("CodeCompanionChat")
end, { desc = "CodeCompanion: chat" })

map({ "n", "v" }, "<leader>aa", function()
  vim.cmd("CodeCompanionActions")
end, { desc = "CodeCompanion: actions" })

map("n", "<leader>wd", function()
  require("wtf").diagnose()
end, { desc = "Debug diagnostic with AI" })

map("n", "<leader>wf", function()
  require("wtf").fix()
end, { desc = "Fix diagnostic with AI" })

map("n", "<leader>ws", function()
  require("wtf").search()
end, { desc = "Search diagnostic" })
