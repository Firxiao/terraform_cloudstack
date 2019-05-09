# add centos template
resource "cloudstack_template" "CentOS-7-x86_64" {
  name = "CentOS-7-x86_64"
  display_text = "CentOS-7-x86_64"
  format = "QCOW2"
  password_enabled = "false"
  is_featured = "false"
  is_public = "true"
  hypervisor = "KVM"
  os_type = "CentOS 7"
  url = "${var.centos7_template}"
  zone = "${var.zone_name}"
}