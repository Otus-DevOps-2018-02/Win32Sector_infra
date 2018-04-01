variable public_key_path {
  description = "Path to the public key used to connect to instance"
}

variable zone {
  description = "Zone"
}

variable db_disk_image {
  description = "Disk image for reddit db"
  default     = "reddit-db-base"
}

variable db_instance_name {
  description = "Name of reddit db instance"
  default     = "reddit-db"
}

variable db_machine_type {
  description = "GCP machine type for reddit db instance"
  default = "g1-small"
}
