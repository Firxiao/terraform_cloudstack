## add instance
resource "cloudstack_instance" "example-instance" {
    name = "example-instance"
    service_offering= "Medium Instance"
    network_id = "${cloudstack_network.example-network.id}"
    template = "CentOS-7-x86_64"
    zone = "${var.zone_name}"
    depends_on = ["cloudstack_network.example-network"]
    depends_on = ["cloudstack_template.CentOS"]
}
##  add multiple instances
resource "cloudstack_instance" "example-instances" {
    name = "${format("example-instance%02d", count.index + 1)}"
    service_offering= "Medium Instance"
    network_id = "${cloudstack_network.example-network.id}"
    template = "CentOS-7-x86_64"
    zone = "${var.zone_name}"
    expunge = "true"
    depends_on = ["cloudstack_network.example-network"]
    depends_on = ["cloudstack_template.CentOS"]
    count = 3
}
