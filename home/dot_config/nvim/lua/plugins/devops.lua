-- DevOps plugins: CloudFormation, Kubernetes, Terraform, Docker, Ansible
return {
  -- CloudFormation LSP (native vim.lsp.config for LazyVim 15.x)
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        cfn_lsp_extra = {
          cmd = { "cfn-lsp-extra" },
          filetypes = { "yaml.cloudformation", "json.cloudformation", "yaml.cfn", "json.cfn" },
          settings = { documentFormatting = false, validation = { enabled = true }, completion = { enabled = true } },
        },
        dockerls = {},
        docker_compose_language_service = {},
        helm_ls = { settings = { ["helm-ls"] = { yamlls = { path = "yaml-language-server" } } } },
        ansiblels = { settings = { ansible = { validation = { enabled = true, lint = { enabled = true } } } } },
        terraformls = { settings = { terraform = { experimentalFeatures = { prefillRequiredFields = true, validateOnSave = true } } } },
      },
    },
  },

  -- CloudFormation docs
  {
    "alxcombo/cfn-docs.nvim",
    cmd = { "CfnDocs", "CfnDocsToggle" },
    keys = { { "<leader>Dc", "<cmd>CfnDocs<cr>", desc = "CloudFormation Docs" } },
    config = true,
  },

  -- Kubernetes utilities
  {
    "h4ckm1n-dev/kube-utils-nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "KubeApply", "KubeDelete", "KubeGet", "KubeDescribe", "KubeExec", "KubeLogs", "KubePortForward", "KubeRestart", "KubeScale", "KubeEdit" },
    keys = {
      { "<leader>ka", "<cmd>KubeApply<cr>", desc = "Kubernetes Apply" },
      { "<leader>kg", "<cmd>KubeGet<cr>", desc = "Kubernetes Get" },
      { "<leader>kd", "<cmd>KubeDescribe<cr>", desc = "Kubernetes Describe" },
      { "<leader>kl", "<cmd>KubeLogs<cr>", desc = "Kubernetes Logs" },
      { "<leader>kr", "<cmd>KubeRestart<cr>", desc = "Kubernetes Restart" },
    },
    opts = { default_namespace = "default", kubeconfig = vim.fn.expand("~/.kube/config") },
  },

  -- Filetype plugins
  { "towolf/vim-helm", ft = { "helm", "yaml.helm" } },
  { "pearofducks/ansible-vim", ft = { "yaml.ansible", "ansible", "jinja2" } },

  -- tmux integration
  {
    "christoomey/vim-tmux-navigator",
    keys = {
      { "<c-h>", "<cmd>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd>TmuxNavigateRight<cr>" },
    },
  },

  -- Linting for DevOps files
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("lint").linters_by_ft = {
        yaml = { "cfn-lint", "yamllint" },
        json = { "cfn-lint", "jsonlint" },
        dockerfile = { "hadolint" },
        terraform = { "tflint" },
        ansible = { "ansible-lint" },
      }
      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function() require("lint").try_lint() end,
      })
    end,
  },
}
