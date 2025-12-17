return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local configs = require("lspconfig.configs")
      if not configs.cfn_lsp_extra then
        local util = require("lspconfig.util")
        local exe = vim.fn.exepath("cfn-lsp-extra")

        configs.cfn_lsp_extra = {
          default_config = {
            cmd = { exe ~= "" and exe or "cfn-lsp-extra" },
            filetypes = { "yaml.cloudformation", "json.cloudformation", "yaml.cfn", "json.cfn" },
            root_dir = function(fname)
              return util.find_git_ancestor(fname) or vim.loop.cwd()
            end,
            settings = {
              documentFormatting = false,
              validation = {
                enabled = true,
              },
              completion = {
                enabled = true,
              },
            },
          },
        }
      end

      opts.servers = opts.servers or {}
      opts.servers.cfn_lsp_extra = {
        capabilities = {
          textDocument = {
            completion = {
              completionItem = {
                snippetSupport = true,
              },
            },
          },
        },
      }
    end,
  },

  -- Auto-detect CloudFormation files
  {
    "b0o/SchemaStore.nvim",
    lazy = true,
    version = false,
  },

  -- CloudFormation snippets
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    opts = function(_, opts)
      local ls = require("luasnip")
      local s = ls.snippet
      local t = ls.text_node
      local i = ls.insert_node

      -- CloudFormation snippets
      ls.add_snippets("yaml", {
        s("cfntemplate", {
          t({
            "AWSTemplateFormatVersion: '2010-09-09'",
            "Description: "}), i(1, "Template description"),
          t({
            "",
            "",
            "Parameters:",
            "  "}), i(2),
          t({
            "",
            "",
            "Resources:",
            "  "}), i(3),
          t({
            "",
            "",
            "Outputs:",
            "  "}), i(4),
        }),
        s("cfnparam", {
          i(1, "ParameterName"), t({":"}),
          t({
            "",
            "  Type: "}), i(2, "String"),
          t({
            "",
            "  Description: "}), i(3, "Parameter description"),
          t({
            "",
            "  Default: "}), i(4, "default-value"),
        }),
        s("cfnresource", {
          i(1, "ResourceName"), t({":"}),
          t({
            "",
            "  Type: "}), i(2, "AWS::Service::Resource"),
          t({
            "",
            "  Properties:",
            "    "}), i(3),
        }),
      })
      return opts
    end,
  },
}
