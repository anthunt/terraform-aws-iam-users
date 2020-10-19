$Users = Invoke-Expression -Command "terraform output -json users" |
ConvertFrom-Json |
Select -expand test@test.com

$Decoded_Password = [System.Text.Encoding]::Unicode.GetString([System.Convert]::FromBase64String($Users.encrypted_password))

$Users.encrypted_password > temp_encoded.data

gpg -o decrypted.txt --local-user hli-iam --decrypt temp_encoded.data