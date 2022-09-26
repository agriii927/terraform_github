resource "github_branch" "bugfixing" {
  count         = var.repo_count
  repository    = github_repository.example[count.index].name
  branch        = "bugfixing"
  source_branch = "development"
  depends_on = [
    github_branch.development
  ]
}

resource "github_branch" "development" {
  count      = var.repo_count
  repository = github_repository.example[count.index].name
  branch     = "development"
}

resource "github_branch" "production" {
  count      = var.repo_count
  repository = github_repository.example[count.index].name
  branch     = "production"
}

resource "github_branch_default" "default" {
  count      = var.repo_count
  repository = github_repository.example[count.index].name
  branch     = github_branch.production[count.index].branch
}