variable project {
  description = "Project ID"
}

variable region {
  description = "Region"
  default     = "europe-west1"
}

variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable disk_image {
  description = "Disk image"
}

variable private_key {
  description = "Path to the private key used for ssh access"
}

variable zone {
  description = "The zone that the machine should be created in"
  default     = "europe-west1-b"
}

variable public_keys {
  description = "File with other user's public keys"
}
variable "instance_names" {
    description = "Names for created several instances"
    default = {
        "0" = "reddit-app"
        "1" = "reddit-app2"
    }
}
