variable "token" {
  type        = string
  description = "Token to authentificate"
}

variable "repo_count" {
  default     = 2
  description = "Number of repos to made in GitHub"
}

variable "admin" {
  default = "agriii927"
}

variable "user_to_collaborate" {
  default = "Jasstkn"
}

variable "collaborator_permission" {
  default = "pull"
}

variable "step1_till" {
  default = "2022-09-01"
}