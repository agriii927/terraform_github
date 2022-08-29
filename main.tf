provider "github" {
#Set your GITHUB_TOKEN variable using command 'export GITHUB_TOKEN='
}


resource "github_repository" "example" {
  #Can make multiple identical repos using for_each cycle
  # for_each = toset( ["1", "2", "3", "4"] )
  # name     = "Terraform_repo_${each.key}"

  # Or using count meta-argument - I prefer this one
  count = var.repo_count
  name = "Terraform-made_repo_${count.index+1}"

  #Third variant - using setproduct pairs - impossible, there are non-unique repetitive keys
  # for_each = {
  #   for repo in local.repo_branch_collection : "${repo.name}" => repo
  # }
  # name = each.value.name


  description = "One of my awesome repos made by Terraform"
  visibility = "public"

  has_issues = true
  has_projects = true
  has_downloads = true
  auto_init = true
  #Can't change attributes (for ex, branches)
  # branches = [{name = "master", protected=true}, 
  # {name = "production", protected=true}]
}

# TODO: посомтреть projectcard
resource "github_issue" "rewrite_readme" {
  repository       = github_repository.example[0].name
  title            = "Rewrite readme issue"
  body             = "Should add pictures to README"
  labels           = ["bug", "documentation"]
  assignees        = [var.admin]
  
}

resource "github_issue" "add_patterns_to_gitignore" {
  repository       = github_repository.example[0].name
  title            = "Add patterns to gitignore file"
  body             = "Need add following patterns to gitignore file: exclude .streamlit folder, venv and all file started from cred"
  labels           = ["bug", "optimisation"]
  #Can't assign to a user who doesn't accept an invitation
  # assignees        = [var.user_to_add]
  milestone_number = github_repository_milestone.step1.number
  
}

resource "github_issue_label" "optimisation_label" {
  repository = github_repository.example[0].name
  name       = "optimisation"
  color      = "000000"
  description = "Projects will work faster if this issues sre corrected"
}

resource "github_repository_milestone" "step1" {
  owner      = var.admin
  repository = github_repository.example[0].name
  title      = "v1.0.0"
  due_date = var.step1_till
}

resource "github_branch" "bugfixing" {
  count = var.repo_count
  repository = github_repository.example[count.index].name
  branch     = "bugfixing"
  source_branch = "development"
  depends_on = [
    github_branch.development
  ]
}

resource "github_branch" "development" {
  count = var.repo_count
  repository = github_repository.example[count.index].name
  branch     = "development"
}

resource "github_branch" "production" {
  count = var.repo_count
  repository = github_repository.example[count.index].name
  branch     = "production"
}

resource "github_branch_default" "default"{
  count = var.repo_count
  repository = github_repository.example[count.index].name
  branch     = github_branch.production[count.index].branch
}

resource "github_repository_file" "gitignore" {
  count = var.repo_count
  repository          = github_repository.example[count.index].name
  branch              = "production"
  file                = ".gitignore"
  content             = file(".gitignore") 
  commit_message      = "Made by Terraform"
  commit_author       = "Terraform User"
  commit_email        = "terraform@example.com"
  overwrite_on_create = true
}

resource "github_repository_file" "README" {
  count = var.repo_count
  repository          = github_repository.example[count.index].name
  # Should push README to branch which is set default 
  branch              = "production"
  file                = "README.md"
  # content = file("README.tpl") # without var substitution
  content = templatefile("README.tpl", {repo_number = count.index})
  commit_message      = "Made by Terraform"
  commit_author       = "Terraform User"
  commit_email        = "terraform@example.com"
  overwrite_on_create = true
}

resource "github_repository_collaborator" "a_repo_collaborator" {
  count = var.repo_count
  repository = github_repository.example[count.index].name
  username   = var.user_to_collaborate
  permission = var.collaborator_permission
}


# resource "github_team_repository" "example_team_repo" {
#   team_id    = github_team.example_team.id
#   repository = github_repository.example[0].name
#   permission = "pull"
# }
# this resource can only be used in the context of an organization, "agriii927" is a user
#  resource "github_team" "example_team" {
#   name = "Example team"
#  } 

# # Protect the main branch of the foo repository. Only allow a specific user to merge to the branch.
# #this resource can only be used in the context of an organization, "agriii927" is a user
# resource "github_branch_protection_v3" "prod" {
#   count = var.repo_count
#   repository     = github_repository.example[count.index].name
#   branch         = "production"

#   restrictions {
#     users = [var.admin]
#     # teams = [github_team.example_team.slug]
#   } 
