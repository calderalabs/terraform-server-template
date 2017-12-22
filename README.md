# Terraform Server Template

## How to Bootstrap

- `git clone git@github.com:calderalabs/terraform-server-template.git`
- Configure the `app_name` in `settings.json` and `terraform/config.tf`
- Configure `AWS_ACCESS_KEY_ID`, `AWS_SECRET_KEY`, `TF_VAR_aws_ssh_public_key` and `TF_VAR_aws_ssh_private_key` in an `.env` file (if you use autoenv)
- Run `./bin/terraform init && ./bin/terraform apply`
- Get the public IP with `./bin/terraform output public_ip`
- Add the Dokku remote with `git remote add production dokku@PUBLIC_IP:YOUR_APP_NAME`
- Deploy with `git push production master`
