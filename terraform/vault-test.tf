provider "vault" {
	address = "http://192.168.9.23:8200/"
	token = "s.BRndMLkpJwZTwFbFhzJTnduy"
}

resource "vault_policy" "test" {
	name = "test-policy"

	policy = <<EOF
path "secret/test-policy" {
	capabilities = ["read"]	
}
EOF
}

resource "vault_jwt_auth_backend_role" "example" {
  backend         = "jwt"
  role_name       = "developers-role"
  token_policies  = ["test-policy"]


  bound_claims_type = "glob"
  bound_claims = {
    color = "red,green,blue"
  }
  user_claim      = "user_email"
  role_type       = "jwt"
}

resource "vault_jwt_auth_backend_role" "example2" {
  backend         = "jwt"
  role_name       = "developers-role-role"
  token_policies  = ["test-policy"]


  bound_claims_type = "glob"
  bound_claims = {
    color = "dev"
  }
  user_claim      = "user_email"
  role_type       = "jwt"
}

resource "vault_jwt_auth_backend_role" "example1" {
  backend         = "jwt"
  role_name       = "developers-role-aboba"
  token_policies  = ["test-policy"]


  bound_claims_type = "glob"
  bound_claims = {
    color = "red,green,blue"
  }
  user_claim      = "user_email"
  role_type       = "jwt"
}

resource "vault_policy" "developers_policy" {
	name = "developer_policy"

	policy = file("./developers_policy.hcl")
}

resource "vault_mount" "developers" {
	path = "developers"
	type = "kv-v2"
	description = "KV-v2 secrets"
}

resource "vault_generic_secret" "developers_secret" {
	path = "${vault_mount.developers.path}/test_secret"

	data_json = <<EOT
	{
		"username": "username",
		"password": "password" 
	}
	EOT
  
}

# resource "vault_jwt_auth_backend" "jwt" {
#   path = "jwt"
# }
