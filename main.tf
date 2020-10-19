resource "aws_iam_user" "users" {
    for_each                = var.users
    name                    = each.key
    path                    = each.value.path
    force_destroy           = each.value.force_destroy
    tags                    = each.value.tags
}

resource "aws_iam_user_group_membership" "groups" {
    for_each    = var.users
    user        = each.key
    groups      = each.value.groups

    depends_on = [
        aws_iam_user.users
    ]
}

resource "aws_iam_user_login_profile" "login_profiles" {
    for_each                    = var.users
    user                        = each.key
    pgp_key                     = (
        length(each.value.pgp_key_path) > 8 ? (
            substr(each.value.pgp_key_path, 0, 8) == "keybase:" ? each.value.pgp_key_path : file(each.value.pgp_key_path)
        ) : file(each.value.pgp_key_path)
    )
    password_length             = each.value.password.password_length
    password_reset_required     = each.value.password.password_reset_required
    
    depends_on = [
        aws_iam_user.users
    ]
}

resource "aws_iam_access_key" "access_keys" {
    for_each    = local.user_accesskeys
    user        = each.value.name
    pgp_key     = file(var.users[each.value.name].pgp_key_path)
    status      = each.value.status
}