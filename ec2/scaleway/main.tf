provider "scaleway" {
  organization = "9e75a463-96c6-4653-8913-32544a01fd94"
  token        = "e201cee1-68b1-4a62-ae78-a8578e2eebeb"
  region       = "par1"
}


resource "scaleway_server" "server" {
  name  = "test"
  image = "${data.scaleway_image.docker.id}"
  type  = "${var.server_type}"
  dynamic_ip_required = true
  volume {
    size_in_gb = "${lookup(var.volume_size, var.server_type)}"
    type       = "l_ssd"
  }
}