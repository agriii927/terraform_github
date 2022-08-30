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
