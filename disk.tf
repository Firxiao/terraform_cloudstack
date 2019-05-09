# add disk to example-instance
resource "cloudstack_disk" "example-disk" {
  name               = "example-disk"
  attach             = "true"
  disk_offering      = "Custom"
  size               = 100
  virtual_machine_id = "${cloudstack_instance.example-instance.id}"
  zone               = "${var.zone_name}"
}

