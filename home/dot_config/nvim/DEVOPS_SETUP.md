# DevOps Neovim Configuration

## Overview
Your Neovim is now configured with comprehensive DevOps tooling for AWS, Kubernetes, Docker, Terraform, and Ansible.

## Installation Requirements

### Required CLI Tools
Install these tools for full functionality:

```bash
# CloudFormation
pip install cfn-lint
npm install -g cfn-lsp-extra

# Terraform
brew install terraform terraform-ls tflint

# Kubernetes
brew install kubernetes-cli helm kubectl kubectx

# Docker
brew install docker hadolint docker-compose

# Ansible
pip install ansible ansible-lint

# AWS CLI
brew install awscli
```

## Key Features

### 1. CloudFormation Support
- **Auto-detection**: YAML/JSON files with CloudFormation content
- **LSP**: Full language server with `cfn-lsp-extra`
- **Snippets**: Type `cfntemplate`, `cfnparam`, `cfnresource`
- **Documentation**: `<leader>dc` for inline CloudFormation docs
- **Validation**: `<leader>dv` to validate templates

### 2. Terraform Support
- **LSP**: Enhanced terraform-ls with experimental features
- **Commands**:
  - `<leader>ti` - terraform init
  - `<leader>tp` - terraform plan
  - `<leader>ta` - terraform apply
  - `<leader>tf` - terraform fmt
  - `<leader>tv` - terraform validate

### 3. Kubernetes Support
- **Plugin**: kube-utils-nvim for in-editor K8s management
- **Commands**:
  - `<leader>ka` - Apply resource
  - `<leader>kg` - Get resources
  - `<leader>kd` - Describe resource
  - `<leader>kl` - View logs
  - `<leader>kr` - Restart pod

### 4. Docker Support
- **Syntax**: Dockerfile highlighting
- **LSP**: Docker and docker-compose language servers
- **Commands**:
  - `<leader>gb` - Build image
  - `<leader>gr` - Run container
  - `<leader>gp` - List containers
  - `<leader>gc` - Compose up

### 5. Ansible Support
- **Syntax**: Enhanced YAML with Ansible keywords
- **LSP**: ansible-ls for completion and validation
- **Commands**:
  - `<leader>ap` - Run playbook
  - `<leader>av` - Lint playbook
  - `<leader>ai` - List inventory

## AWS Snippets
Type these triggers in CloudFormation YAML files:
- `ec2` - EC2 Instance template
- `s3` - S3 Bucket with encryption
- `lambda` - Lambda Function
- `vpc` - VPC configuration
- `sg` - Security Group
- `iamrole` - IAM Role with policies
- `rds` - RDS Database
- `dynamodb` - DynamoDB Table

In Terraform files:
- `awsprovider` - AWS Provider config
- `awsec2` - EC2 Instance
- `awss3` - S3 Bucket with versioning

## File Type Detection
Automatic detection for:
- `*.cfn.yaml/yml` - CloudFormation
- `*k8s*.yaml` - Kubernetes
- `docker-compose*.yaml` - Docker Compose
- `*playbook*.yaml` - Ansible
- `*/templates/*.yaml` - Helm charts
- `*.tf` - Terraform

## Troubleshooting

### Plugins Not Loading
```vim
:Lazy sync
:checkhealth
```

### LSP Not Working
Ensure language servers are installed:
```bash
which cfn-lsp-extra terraform-ls ansible-language-server
```

### Missing Keybindings
Check which-key mappings:
```vim
:WhichKey <leader>d
:WhichKey <leader>k
:WhichKey <leader>t
```

## AWS Cantrill Course Tips
1. Use `cfntemplate` snippet to quickly scaffold CloudFormation templates
2. `<leader>dc` opens CloudFormation docs for the resource under cursor
3. Split panes with tmux integration (`<C-h/j/k/l>` to navigate)
4. Use `:KubeApply` to test K8s manifests directly from nvim
5. Terraform files auto-format on save

## Next Steps
1. Open nvim and run `:Lazy sync` to install all plugins
2. Restart nvim for full configuration load
3. Test with: `nvim test.cfn.yaml` and type `cfntemplate`
4. Check `:checkhealth` for any missing dependencies