terraform {
  backend "gcs" {
    bucket  = "storage-bucket-win32sector1"
    prefix  = "terraform/state"
  }
}
