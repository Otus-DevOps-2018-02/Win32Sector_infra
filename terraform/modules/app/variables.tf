variable public_key_path {
  description = "Path to the public key used to connect to instance"
}

variable zone {
  description = "Zone"
}

variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-app-base"
}

variable private_key {
  description = "Path to the private key used for ssh access"
  default = "~/.ssh/appuser"
}

variable app_instance_name {
  description = "Name of reddit app instance"
  default     = "reddit-app"
}

variable app_machine_type {
  description = "GCP machine type for reddit app instance"
  default = "g1-small"
}
