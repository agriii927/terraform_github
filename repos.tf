resource "github_repository" "example" {
  count         = var.repo_count
  name          = "Terraform-made_repo_${count.index + 1}"
  description   = "One of my awesome repos made by Terraform"
  visibility    = "public"
  has_issues    = true
  has_projects  = true
  has_downloads = true
  auto_init     = true
}

resource "github_repository_file" "gitignore" {
  count               = var.repo_count
  repository          = github_repository.example[count.index].name
  branch              = "production"
  file                = ".gitignore"
  content             = file(".gitignore")
  commit_message      = "Made by Terraform"
  commit_author       = "Terraform User"
  commit_email        = "terraform@example.com"
  overwrite_on_create = true
  depends_on = [github_repository.example, github_branch.production]
}

resource "github_repository_file" "README" {
  count      = var.repo_count
  repository = github_repository.example[count.index].name
  # Should push README to branch which is set default 
  branch = "production"
  file   = "README.md"
  # content = file("README.tpl") # without var substitution
  content             = templatefile("README.tpl", { repo_number = count.index })
  commit_message      = "Made by Terraform"
  commit_author       = "Terraform User"
  commit_email        = "terraform@example.com"
  overwrite_on_create = true
  depends_on = [github_repository.example, github_branch.production]
}

resource "github_repository_collaborator" "a_repo_collaborator" {
  count      = var.repo_count
  repository = github_repository.example[count.index].name
  username   = var.user_to_collaborate
  permission = var.collaborator_permission
}

resource "github_repository_milestone" "step1" {
  owner      = var.admin
  repository = github_repository.example[0].name
  title      = "v1.0.0"
  due_date   = var.step1_till
}