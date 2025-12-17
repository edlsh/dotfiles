vim.filetype.add({
  extension = {
    -- Terraform
    tf = "terraform",
    tfvars = "terraform",
    tfstate = "json",
    -- Kubernetes
    yaml = function(path, bufnr)
      local content = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
      local content_str = table.concat(content, "\n")
      -- Check for Kubernetes resources
      if content_str:match("apiVersion:") and content_str:match("kind:") then
        return "yaml.kubernetes"
      end
      return "yaml"
    end,
    -- Docker
    dockerfile = "dockerfile",
    Dockerfile = "dockerfile",
    -- Ansible
    yml = function(path, bufnr)
      if path:match("playbook") or path:match("ansible") then
        return "yaml.ansible"
      end
      return "yaml"
    end,
  },
  filename = {
    ["Dockerfile"] = "dockerfile",
    ["docker-compose.yml"] = "yaml.docker",
    ["docker-compose.yaml"] = "yaml.docker",
    ["Jenkinsfile"] = "groovy",
    [".gitlab-ci.yml"] = "yaml.gitlab",
    ["ansible.cfg"] = "ini",
    ["inventory"] = "ansible_hosts",
  },
  pattern = {
    [".*"] = {
      priority = math.huge,
      function(path, bufnr)
        local line1 = vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)[1] or ""
        local line2 = vim.api.nvim_buf_get_lines(bufnr, 1, 2, false)[1] or ""

        -- CloudFormation detection
        if vim.regex([[^AWSTemplateFormatVersion]]):match_str(line1) ~= nil
          or vim.regex([[AWS::Serverless-2016-10-31]]):match_str(line1) ~= nil
          or vim.regex([[Transform: AWS::Serverless-2016-10-31]]):match_str(line1) ~= nil
          or vim.regex([[Transform: AWS::Serverless-2016-10-31]]):match_str(line2) ~= nil
        then
          return "yaml.cloudformation"
        elseif vim.regex([[['"]AWSTemplateFormatVersion]]):match_str(line1) ~= nil
          or vim.regex([[['"]AWSTemplateFormatVersion]]):match_str(line2) ~= nil
          or vim.regex([[AWS::Serverless-2016-10-31]]):match_str(line1) ~= nil
          or vim.regex([[AWS::Serverless-2016-10-31]]):match_str(line2) ~= nil
        then
          return "json.cloudformation"
        end

        -- Helm charts detection
        if path:match("templates/") and path:match("%.yaml$") then
          return "yaml.helm"
        end

        -- Ansible detection by content
        local content = vim.api.nvim_buf_get_lines(bufnr, 0, 10, false)
        local content_str = table.concat(content, "\n")
        if content_str:match("- hosts:") or content_str:match("- name:.*\n.*tasks:") then
          return "yaml.ansible"
        end
      end,
    },
  },
})
