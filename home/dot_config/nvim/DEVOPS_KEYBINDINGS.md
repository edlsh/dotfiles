# DevOps Keybindings Configuration Update

## Summary of Changes

Fixed which-key configuration issues:
1. Updated to new which-key spec format (using `wk.add()` instead of `wk.register()`)
2. Resolved keymap conflicts by using uppercase letters for DevOps groups
3. Removed duplicate which-key registrations

## New Key Mappings

### DevOps Tools (`<leader>D`)
- `<leader>Dc` - CloudFormation Docs
- `<leader>Dv` - Validate CloudFormation
- `<leader>Df` - Format Terraform
- `<leader>Dp` - Terraform Plan
- `<leader>Di` - Terraform Init
- `<leader>Ds` - Validate Stack

### Kubernetes (`<leader>k`)
- `<leader>ka` - Apply Resource
- `<leader>kg` - Get Resources
- `<leader>kd` - Describe Resource
- `<leader>kl` - View Logs
- `<leader>kr` - Restart Pod
- `<leader>ke` - Edit Resource
- `<leader>kx` - Delete Resource
- `<leader>kp` - Port Forward
- `<leader>ks` - Scale Deployment
- `<leader>kv` - Validate K8s

### AWS/Ansible (`<leader>A`)
- `<leader>Ac` - AWS Config
- `<leader>As` - AWS Identity
- `<leader>Al` - List Stacks
- `<leader>Ap` - Run Playbook
- `<leader>Av` - Lint Ansible
- `<leader>Ai` - List Inventory
- `<leader>Ag` - Galaxy Collections

### Terraform (`<leader>T`)
- `<leader>Ti` - Init
- `<leader>Tp` - Plan
- `<leader>Ta` - Apply
- `<leader>Td` - Destroy
- `<leader>Tv` - Validate
- `<leader>Tf` - Format
- `<leader>To` - Output
- `<leader>Ts` - State List
- `<leader>Tr` - Refresh

### Docker/Container (`<leader>K`)
Note: Using `K` for "Kontainer" to avoid conflict with git (`g`)
- `<leader>Kb` - Build Image
- `<leader>Kr` - Run Container
- `<leader>Kp` - List Containers
- `<leader>Ki` - List Images
- `<leader>Kl` - View Logs
- `<leader>Ke` - Exec Into Container
- `<leader>Kc` - Compose Up
- `<leader>Kd` - Compose Down

## Conflict Resolution

Previous conflicts resolved:
- `<leader>d` (debug vs devops) → DevOps now uses `<leader>D`
- `<leader>t` (test vs terraform) → Terraform now uses `<leader>T`
- `<leader>a` (ai vs aws/ansible) → AWS/Ansible now uses `<leader>A`
- `<leader>g` (git vs docker) → Docker now uses `<leader>K` (Kontainer)

## Files Modified

1. `/Users/enzolucchesi/.config/nvim/lua/config/devops-keymaps.lua` - Updated to new spec format
2. `/Users/enzolucchesi/.config/nvim/lua/plugins/devops.lua` - Removed duplicate which-key registration

## Reload Configuration

After these changes, restart Neovim or reload the configuration:
```vim
:source %
:Lazy reload
```