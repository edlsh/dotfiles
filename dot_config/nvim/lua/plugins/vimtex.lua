return {
  "lervag/vimtex",
  lazy = false, -- CRITICAL: don't lazy load VimTeX (breaks inverse-search)
  -- tag = "v2.15", -- uncomment to pin to a specific release
  init = function()
    -- VimTeX configuration goes here

    -- Viewer configuration
    -- Using Skim for forward/inverse search support
    vim.g.vimtex_view_method = "skim"

    -- Alternative viewers (uncomment if needed):
    -- vim.g.vimtex_view_general_viewer = "open"
    -- vim.g.vimtex_view_general_options = "-a Preview" -- macOS Preview
    -- vim.g.vimtex_view_method = "zathura" -- Linux: Zathura (brew install zathura)
    -- vim.g.vimtex_view_method = "mupdf" -- Cross-platform: MuPDF (brew install mupdf)

    -- Compiler configuration (latexmk is default and recommended)
    -- vim.g.vimtex_compiler_method = "latexmk" -- default
    -- vim.g.vimtex_compiler_method = "latexrun" -- alternative
    -- vim.g.vimtex_compiler_method = "tectonic" -- alternative

    -- Change the local leader key (default is '\')
    -- vim.g.maplocalleader = ","

    -- Disable some features if needed
    -- vim.g.vimtex_indent_enabled = 0 -- disable indentation
    -- vim.g.vimtex_imaps_enabled = 0 -- disable insert mode mappings
    -- vim.g.vimtex_complete_enabled = 0 -- disable completion

    -- Quickfix configuration
    vim.g.vimtex_quickfix_mode = 0 -- suppress quickfix window auto-open

    -- Syntax/conceal configuration
    vim.g.vimtex_syntax_enabled = 1
    -- vim.g.vimtex_syntax_conceal_disable = 1 -- disable conceal

    -- Folding
    -- vim.g.vimtex_fold_enabled = 1 -- enable folding (disabled by default)

    -- Additional useful settings
    vim.g.vimtex_compiler_latexmk = {
      build_dir = "",
      callback = 1,
      continuous = 1,
      executable = "latexmk",
      options = {
        "-pdf",
        "-verbose",
        "-file-line-error",
        "-synctex=1",
        "-interaction=nonstopmode",
      },
    }
  end,
}