-- Initialize DevOps configuration
local M = {}

function M.setup()
  -- Load DevOps keymaps
  require("config.devops-keymaps").setup()

  -- Set up autocommands for DevOps file types
  local augroup = vim.api.nvim_create_augroup("DevOpsFileTypes", { clear = true })

  -- Auto-detect and set CloudFormation files
  vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    group = augroup,
    pattern = { "*.cfn.yaml", "*.cfn.yml", "*.cfn.json", "*cloudformation*.yaml", "*cloudformation*.yml", "*cloudformation*.json" },
    callback = function()
      if vim.fn.expand("%:e") == "json" then
        vim.bo.filetype = "json.cloudformation"
      else
        vim.bo.filetype = "yaml.cloudformation"
      end
    end,
  })

  -- Auto-detect Kubernetes files
  vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    group = augroup,
    pattern = { "*k8s*.yaml", "*k8s*.yml", "*kubernetes*.yaml", "*kubernetes*.yml", "*.k8s.yaml", "*.k8s.yml" },
    callback = function()
      vim.bo.filetype = "yaml.kubernetes"
    end,
  })

  -- Auto-detect Helm files
  vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    group = augroup,
    pattern = { "*/templates/*.yaml", "*/templates/*.yml", "*/charts/*/*.yaml", "*/charts/*/*.yml" },
    callback = function()
      vim.bo.filetype = "yaml.helm"
    end,
  })

  -- Auto-detect Docker Compose files
  vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    group = augroup,
    pattern = { "docker-compose*.yaml", "docker-compose*.yml", "compose*.yaml", "compose*.yml" },
    callback = function()
      vim.bo.filetype = "yaml.docker"
    end,
  })

  -- Auto-detect Ansible files
  vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    group = augroup,
    pattern = { "*playbook*.yaml", "*playbook*.yml", "*/ansible/*.yaml", "*/ansible/*.yml", "*/roles/*/tasks/*.yml" },
    callback = function()
      vim.bo.filetype = "yaml.ansible"
    end,
  })

  -- Auto-detect Terraform files
  vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    group = augroup,
    pattern = { "*.tf", "*.tfvars", "*.hcl" },
    callback = function()
      vim.bo.filetype = "terraform"
    end,
  })

  -- Set up folding for YAML files
  vim.api.nvim_create_autocmd("FileType", {
    group = augroup,
    pattern = { "yaml", "yaml.*" },
    callback = function()
      vim.opt_local.foldmethod = "indent"
      vim.opt_local.foldlevel = 2
    end,
  })
end

return M