variable "do_token" {
  type        = string
  description = "Your DigitalOcean API token. See https://cloud.digitalocean.com/account/api/tokens to generate a token."
}

variable ssh_pvt_key {
  type        = string
  description = "The private ssh certificate in the user's .ssh/ dir -> $HOME/.ssh/id_rsa"
}

variable runner_platform {
  type        = string
  default     = "linux/amd64"
  description = "Defines the runner architecture platform linux/amd64, linux/arm64, darwin/amd64"
}

variable runner_name {
  type        = string
  description = "The host name of the CircleCI Runner which is also the Droplet name."
}

variable runner_token {
  type        = string
  description = "The CircleCI Runner token from the CLI"
}

variable "region" {
  type        = string
  description = "The region where the assets should be assigned to"
  default     = "nyc3"
}

variable "node_size" {
  type        = string
  description = "defines the size of the compute node"
  default     = "s-4vcpu-8gb"
}

variable "image_name" {
  type        = string
  description = "defines the DigitalOcean image name to install to compute node"
  default     = "ubuntu-20-04-x64"
}
