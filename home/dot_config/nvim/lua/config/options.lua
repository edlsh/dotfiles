local opt = vim.opt

-- Display
opt.relativenumber = true
opt.number = true
opt.cursorline = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.signcolumn = "yes"
opt.wrap = false
opt.termguicolors = true

-- Editing
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true

-- System integration
opt.clipboard = "unnamedplus"
opt.undofile = true
opt.undolevels = 10000

-- Performance
opt.updatetime = 200
opt.timeoutlen = 300

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.inccommand = "nosplit"
