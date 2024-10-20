terraform {
  required_providers {
    incus = {
      source = "lxc/incus"
    }
  }
}

provider "incus" {
  remote {
    name = "local"
  }
}

resource "incus_image" "alpine" {
  source_image = {
    remote = "images"
    name   = "alpine/edge"
  }
}

resource "incus_instance" "instance1" {
  name  = "instance1"
  image = "images:ubuntu/22.04"

  config = {
    "boot.autostart" = true
  }

  limits = {
    cpu = 2
  }
}
