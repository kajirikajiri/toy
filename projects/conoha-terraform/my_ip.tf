data "http" "myip" {
  url = "https://ipv4.icanhazip.com"
}

locals {
  my_ip = "${chomp(data.http.myip.response_body)}/32"
}

