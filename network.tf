# add network
resource "cloudstack_network" "example-network" {
    name = "example-network"
    cidr = "10.1.1.0/24"
    network_offering = "DefaultIsolatedNetworkOfferingWithSourceNatService"
    zone = "${var.zone_name}"
}

# get public_ip
resource "cloudstack_ipaddress" "example-public_ip" {
  network_id = "${cloudstack_network.example-network.id}"
  depends_on = ["cloudstack_network.example-network"]
}

# port forward
resource "cloudstack_port_forward" "example-instance" {
  ip_address_id = "${cloudstack_ipaddress.example-public_ip.id}"
  depends_on = ["cloudstack_instance.example-instance"]

  forward {
    protocol = "tcp"
    private_port = "22"
    public_port = "22"
    virtual_machine_id = "${cloudstack_instance.example-instance.id}"
  }
  forward {
    protocol = "tcp"
    private_port = "8080"
    public_port = "8080"
    virtual_machine_id = "${cloudstack_instance.example-instance.id}"
  }
}

# ingress firewall
resource "cloudstack_firewall" "example-firewall" {
  ip_address_id = "${cloudstack_ipaddress.example-public_ip.id}"
  rule {
    cidr_list = ["0.0.0.0/0"]
    protocol  = "tcp"
    ports     = ["22", "8080"]
  }
  rule {
    cidr_list = ["0.0.0.0/0"]
    protocol  = "icmp"
    icmp_type = "-1"
    icmp_code = "-1"
  }
}

# egress firwall
resource "cloudstack_egress_firewall" "example-nat" {
  network_id = "${cloudstack_network.example-network.id}"

  rule {
    cidr_list = ["10.1.1.0/24"]
    protocol  = "tcp"
    ports     = ["1-65535"]
  }
  rule {
    cidr_list = ["10.1.1.0/24"]
    protocol  = "udp"
    ports     = ["1-65535"]
  }
  rule {
    cidr_list = ["10.1.1.0/24"]
    protocol  = "icmp"
    icmp_type = "-1"
    icmp_code = "-1"
  }
}
