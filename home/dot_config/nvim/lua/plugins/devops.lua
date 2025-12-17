-- DevOps-focused plugins for AWS, Kubernetes, Docker, Terraform, etc.
return {
  -- CloudFormation documentation in Neovim
  {
    "alxcombo/cfn-docs.nvim",
    cmd = { "CfnDocs", "CfnDocsToggle" },
    keys = {
      { "<leader>Dc", "<cmd>CfnDocs<cr>", desc = "CloudFormation Docs" },
    },
    config = true,
  },

  -- Kubernetes utilities
  {
    "h4ckm1n-dev/kube-utils-nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = {
      "KubeApply",
      "KubeDelete",
      "KubeGet",
      "KubeDescribe",
      "KubeExec",
      "KubeLogs",
      "KubePortForward",
      "KubeRestart",
      "KubeScale",
      "KubeEdit",
    },
    keys = {
      { "<leader>ka", "<cmd>KubeApply<cr>", desc = "Kubernetes Apply" },
      { "<leader>kg", "<cmd>KubeGet<cr>", desc = "Kubernetes Get" },
      { "<leader>kd", "<cmd>KubeDescribe<cr>", desc = "Kubernetes Describe" },
      { "<leader>kl", "<cmd>KubeLogs<cr>", desc = "Kubernetes Logs" },
      { "<leader>kr", "<cmd>KubeRestart<cr>", desc = "Kubernetes Restart" },
    },
    config = function()
      require("kube-utils-nvim").setup({
        default_namespace = "default",
        kubeconfig = vim.fn.expand("~/.kube/config"),
      })
    end,
  },

  -- Helm support
  {
    "towolf/vim-helm",
    ft = { "helm", "yaml.helm" },
  },

  -- Enhanced YAML support with CloudFormation detection
  {
    "cuducos/yaml.nvim",
    ft = { "yaml", "yml" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim",
    },
  },

  -- Ansible support
  {
    "pearofducks/ansible-vim",
    ft = { "yaml.ansible", "ansible", "ansible_hosts", "jinja2" },
    config = function()
      vim.g.ansible_unindent_after_newline = 1
      vim.g.ansible_yamlKeyName = "yamlKey"
      vim.g.ansible_attribute_highlight = "ob"
      vim.g.ansible_name_highlight = "b"
      vim.g.ansible_extra_keywords_highlight = 1
    end,
  },

  -- Docker support
  {
    "ekalinin/Dockerfile.vim",
    ft = { "Dockerfile", "dockerfile" },
  },

  -- tmux navigator for better terminal integration
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
    },
    keys = {
      { "<c-h>", "<cmd>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd>TmuxNavigateRight<cr>" },
    },
  },

  -- Better diagnostics display
  {
    "folke/trouble.nvim",
    opts = {},
    cmd = { "TroubleToggle", "Trouble" },
    keys = {
      { "<leader>xx", "<cmd>TroubleToggle<cr>", desc = "Toggle Trouble" },
      { "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics" },
      { "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics" },
    },
  },

  -- AWS SDK snippets
  {
    "rafamadriz/friendly-snippets",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load({
        paths = { "./snippets/aws" },
      })
    end,
  },

  -- Additional LSP configurations for DevOps tools
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local lspconfig = require("lspconfig")

      -- Docker LSP
      opts.servers = opts.servers or {}
      opts.servers.dockerls = {}
      opts.servers.docker_compose_language_service = {}

      -- Helm LSP
      opts.servers.helm_ls = {
        settings = {
          ["helm-ls"] = {
            yamlls = {
              path = "yaml-language-server",
            },
          },
        },
      }

      -- Ansible LSP
      opts.servers.ansiblels = {
        settings = {
          ansible = {
            validation = {
              enabled = true,
              lint = {
                enabled = true,
              },
            },
          },
        },
      }

      -- Enhanced terraform-ls settings
      opts.servers.terraformls = {
        settings = {
          terraform = {
            experimentalFeatures = {
              prefillRequiredFields = true,
              validateOnSave = true,
            },
          },
        },
      }

      return opts
    end,
  },

  -- nvim-lint for additional linting
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        yaml = { "cfn-lint", "yamllint" },
        json = { "cfn-lint", "jsonlint" },
        dockerfile = { "hadolint" },
        terraform = { "tflint" },
        ansible = { "ansible-lint" },
      }

      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },

  -- Which-key registration moved to devops-keymaps.lua
}