data "scaleway_image" "ubuntu16" {
  architecture = "x86_64"
  name         = "Ubuntu Xenial"
}

data "scaleway_image" "debian8" {
  architecture = "x86_64"
  name         = "Debian Jessie"
}

data "scaleway_image" "docker" {
  architecture = "x86_64"
  name         = "Docker"
}