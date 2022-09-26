# Quick GitHub infrastructure built by Terraform
Terraform IaC to automatically build GitHub infrastructure. In this project you can set the number of repositories you want to made, copy README and .gitignore files, create 3 additional branches in it (production, bugfixing, development). 
[Here](https://github.com/agriii927/Terraform-made_repo_1) you can see the example repo.

## To run this terraform script use following commands:
1. Generate OAuth token in GitHub
2. Set the environmental variable:
```bash
export GITHUB_TOKEN="your_oath_token"
```
3. Run Terraform commands:
```bash
terraform init
terraform apply
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.8 |
| <a name="requirement_github"></a> [github](#requirement\_github) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_github"></a> [github](#provider\_github) | 4.30.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [github_branch.bugfixing](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch) | resource |
| [github_branch.development](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch) | resource |
| [github_branch.production](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch) | resource |
| [github_branch_default.default](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch_default) | resource |
| [github_issue.add_patterns_to_gitignore](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/issue) | resource |
| [github_issue.rewrite_readme](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/issue) | resource |
| [github_issue_label.optimisation_label](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/issue_label) | resource |
| [github_repository.example](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository) | resource |
| [github_repository_collaborator.a_repo_collaborator](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_collaborator) | resource |
| [github_repository_file.README](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [github_repository_file.gitignore](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [github_repository_milestone.step1](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_milestone) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin"></a> [admin](#input\_admin) | n/a | `string` | `"agriii927"` | no |
| <a name="input_collaborator_permission"></a> [collaborator\_permission](#input\_collaborator\_permission) | n/a | `string` | `"pull"` | no |
| <a name="input_repo_count"></a> [repo\_count](#input\_repo\_count) | Number of repos to made in GitHub | `number` | `2` | no |
| <a name="input_step1_till"></a> [step1\_till](#input\_step1\_till) | n/a | `string` | `"2022-09-01"` | no |
| <a name="input_token"></a> [token](#input\_token) | Token to authentificate | `string` | n/a | yes |
| <a name="input_user_to_collaborate"></a> [user\_to\_collaborate](#input\_user\_to\_collaborate) | n/a | `string` | `"Jasstkn"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->