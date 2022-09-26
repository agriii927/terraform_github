resource "github_issue" "rewrite_readme" {
  repository = github_repository.example[0].name
  title      = "Rewrite readme issue"
  body       = "Should add pictures to README"
  labels     = ["bug", "documentation"]
  assignees  = [var.admin]

}

resource "github_issue" "add_patterns_to_gitignore" {
  repository = github_repository.example[0].name
  title      = "Add patterns to gitignore file"
  body       = "Need add following patterns to gitignore file: exclude .streamlit folder, venv and all file started from cred"
  labels     = ["bug", "optimisation"]
  #Can't assign to a user who doesn't accept an invitation
  # assignees        = [var.user_to_add]
  milestone_number = github_repository_milestone.step1.number

}

resource "github_issue_label" "optimisation_label" {
  repository  = github_repository.example[0].name
  name        = "optimisation"
  color       = "000000"
  description = "Projects will work faster if this issues sre corrected"
}