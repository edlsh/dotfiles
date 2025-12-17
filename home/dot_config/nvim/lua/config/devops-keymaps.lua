-- DevOps-specific keymaps
local M = {}

function M.setup()
  local wk = require("which-key")

  -- DevOps keybindings (new spec format)
  wk.add({
    -- DevOps group
    { "<leader>D", group = "devops" },
    { "<leader>Dc", "<cmd>CfnDocs<cr>", desc = "CloudFormation Docs" },
    { "<leader>Dv", "<cmd>!cfn-lint %<cr>", desc = "Validate CloudFormation" },
    { "<leader>Df", "<cmd>!terraform fmt %<cr>", desc = "Format Terraform" },
    { "<leader>Dp", "<cmd>!terraform plan<cr>", desc = "Terraform Plan" },
    { "<leader>Di", "<cmd>!terraform init<cr>", desc = "Terraform Init" },
    { "<leader>Ds", "<cmd>!aws cloudformation validate-template --template-body file://%<cr>", desc = "Validate Stack" },

    -- Kubernetes group
    { "<leader>k", group = "kubernetes" },
    { "<leader>ka", "<cmd>KubeApply<cr>", desc = "Apply Resource" },
    { "<leader>kg", "<cmd>KubeGet<cr>", desc = "Get Resources" },
    { "<leader>kd", "<cmd>KubeDescribe<cr>", desc = "Describe Resource" },
    { "<leader>kl", "<cmd>KubeLogs<cr>", desc = "View Logs" },
    { "<leader>kr", "<cmd>KubeRestart<cr>", desc = "Restart Pod" },
    { "<leader>ke", "<cmd>KubeEdit<cr>", desc = "Edit Resource" },
    { "<leader>kx", "<cmd>KubeDelete<cr>", desc = "Delete Resource" },
    { "<leader>kp", "<cmd>KubePortForward<cr>", desc = "Port Forward" },
    { "<leader>ks", "<cmd>KubeScale<cr>", desc = "Scale Deployment" },
    { "<leader>kv", "<cmd>!kubectl apply --dry-run=client -f % -o yaml | kubectl diff -f -<cr>", desc = "Validate K8s" },

    -- AWS/Ansible group
    { "<leader>A", group = "aws/ansible" },
    { "<leader>Ac", "<cmd>!aws configure list<cr>", desc = "AWS Config" },
    { "<leader>As", "<cmd>!aws sts get-caller-identity<cr>", desc = "AWS Identity" },
    { "<leader>Al", "<cmd>!aws cloudformation list-stacks --stack-status-filter CREATE_COMPLETE UPDATE_COMPLETE<cr>", desc = "List Stacks" },
    { "<leader>Ap", "<cmd>!ansible-playbook %<cr>", desc = "Run Playbook" },
    { "<leader>Av", "<cmd>!ansible-lint %<cr>", desc = "Lint Ansible" },
    { "<leader>Ai", "<cmd>!ansible-inventory --list<cr>", desc = "List Inventory" },
    { "<leader>Ag", "<cmd>!ansible-galaxy collection list<cr>", desc = "Galaxy Collections" },

    -- Terraform group
    { "<leader>T", group = "terraform" },
    { "<leader>Ti", "<cmd>!terraform init<cr>", desc = "Init" },
    { "<leader>Tp", "<cmd>!terraform plan<cr>", desc = "Plan" },
    { "<leader>Ta", "<cmd>!terraform apply<cr>", desc = "Apply" },
    { "<leader>Td", "<cmd>!terraform destroy<cr>", desc = "Destroy" },
    { "<leader>Tv", "<cmd>!terraform validate<cr>", desc = "Validate" },
    { "<leader>Tf", "<cmd>!terraform fmt<cr>", desc = "Format" },
    { "<leader>To", "<cmd>!terraform output<cr>", desc = "Output" },
    { "<leader>Ts", "<cmd>!terraform state list<cr>", desc = "State List" },
    { "<leader>Tr", "<cmd>!terraform refresh<cr>", desc = "Refresh" },

    -- Docker group (changed from g to avoid git conflict)
    { "<leader>K", group = "docker (kontainer)" },
    { "<leader>Kb", "<cmd>!docker build -t ${PWD##*/} .<cr>", desc = "Build Image" },
    { "<leader>Kr", "<cmd>!docker run -it ${PWD##*/}<cr>", desc = "Run Container" },
    { "<leader>Kp", "<cmd>!docker ps<cr>", desc = "List Containers" },
    { "<leader>Ki", "<cmd>!docker images<cr>", desc = "List Images" },
    { "<leader>Kl", "<cmd>!docker logs -f $(docker ps -q | head -1)<cr>", desc = "View Logs" },
    { "<leader>Ke", "<cmd>!docker exec -it $(docker ps -q | head -1) /bin/bash<cr>", desc = "Exec Into Container" },
    { "<leader>Kc", "<cmd>!docker-compose up<cr>", desc = "Compose Up" },
    { "<leader>Kd", "<cmd>!docker-compose down<cr>", desc = "Compose Down" },
  })

  -- Quick file type specific commands
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "yaml.cloudformation", "json.cloudformation" },
    callback = function()
      vim.keymap.set("n", "<localleader>v", "<cmd>!cfn-lint %<cr>", { buffer = true, desc = "Validate CFN" })
      vim.keymap.set("n", "<localleader>d", "<cmd>CfnDocs<cr>", { buffer = true, desc = "CFN Docs" })
    end,
  })

  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "terraform" },
    callback = function()
      vim.keymap.set("n", "<localleader>f", "<cmd>!terraform fmt %<cr>", { buffer = true, desc = "Format TF" })
      vim.keymap.set("n", "<localleader>v", "<cmd>!terraform validate<cr>", { buffer = true, desc = "Validate TF" })
    end,
  })

  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "yaml.kubernetes" },
    callback = function()
      vim.keymap.set("n", "<localleader>a", "<cmd>KubeApply<cr>", { buffer = true, desc = "Apply K8s" })
      vim.keymap.set("n", "<localleader>v", "<cmd>!kubectl apply --dry-run=client -f %<cr>", { buffer = true, desc = "Validate K8s" })
    end,
  })

  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "dockerfile" },
    callback = function()
      vim.keymap.set("n", "<localleader>b", "<cmd>!docker build -t ${PWD##*/} .<cr>", { buffer = true, desc = "Build Docker" })
      vim.keymap.set("n", "<localleader>l", "<cmd>!hadolint %<cr>", { buffer = true, desc = "Lint Dockerfile" })
    end,
  })

  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "yaml.ansible" },
    callback = function()
      vim.keymap.set("n", "<localleader>r", "<cmd>!ansible-playbook %<cr>", { buffer = true, desc = "Run Playbook" })
      vim.keymap.set("n", "<localleader>v", "<cmd>!ansible-lint %<cr>", { buffer = true, desc = "Lint Ansible" })
    end,
  })
end

return M