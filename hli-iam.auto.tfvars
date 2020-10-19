aws = {
    region  = "ap-northeast-2"
    profile = "default"
}

users = {

    "test@test.com" = {
        path                  = "/"
        force_destroy         = false
        tags                  = {
            "Name" = "Test User"
        }
        groups                = ["HLI-IT-OPS"]
        pgp_key_path          = "./windows/hli-iam.user.terraform.gpg"
        password              = {
            password_length         = 10
            password_reset_required = true
        }
        accesskeys            = []
    }
}