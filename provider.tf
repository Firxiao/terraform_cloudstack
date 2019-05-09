provider "cloudstack" {
 api_url   = "http://${var.ms_host}:8080/client/api"
 api_key = "${var.access_key}"
 secret_key = "${var.secret_key}"
 timeout = "500"
}

