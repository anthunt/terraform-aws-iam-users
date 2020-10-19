output "users" {
    value = {
        for user in aws_iam_user.users : user.name => {
            arn         = user.arn
            name        = user.name
            unique_id   = user.unique_id
            groups      = aws_iam_user_group_membership.groups[user.name].groups
            encrypted_password    = aws_iam_user_login_profile.login_profiles[user.name].encrypted_password
            access_keys = [for key in keys(local.user_accesskeys) : aws_iam_access_key.access_keys[key]]
        }
    }
}