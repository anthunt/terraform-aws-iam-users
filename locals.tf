locals {

    user_accesskeys = {
        for accesskey in flatten([
            for name, user in var.users: [
                for index, accesskey in user.accesskeys: {
                    name    = name
                    index   = index
                    status  = accesskey.status
                }
            ]
        ]): "${accesskey.name}[${accesskey.index}]" => accesskey
    }

}