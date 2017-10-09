variable "server_type" {
  default = "VC1M"
}

variable "image" {
  default = "Debian Jessie"
}

variable "volume_size" {
  type = "map"
  default = {
    VC1S = 0
    VC1M = 50
  }
}