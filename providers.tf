provider "gsuite" {
  # It is strongly recommended to configure this provider through the
  # environment variables described above for "credentials" and
  # "impersonated_user_email", so that each user can have separate credentials
  # set in the environment.
  oauth_scopes = [
    "https://www.googleapis.com/auth/admin.directory.group",
    "https://www.googleapis.com/auth/apps.groups.settings",
    "https://www.googleapis.com/auth/admin.directory.user",
    "https://www.googleapis.com/auth/admin.directory.userschema",
  ]
  # Oauth scopes do not need to be set when using a personal admin account.
}

terraform {
  required_providers {
    gsuite = {
      source = "DeviaVir/gsuite"
      version = "0.1.54"
    }
  }
}
