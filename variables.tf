variable "aws" {
  type = object({
    region  = string
    profile = string
  })
}

variable "users" {
  type = map(object({
    path                  = string
    force_destroy         = bool
    tags                  = map(string)

    groups                = list(string)
    pgp_key_path          = string
    password              = object({
      password_length         = number
      password_reset_required = bool
    })
    accesskeys            = list(object({
      status = string
    }))
  }))
}
