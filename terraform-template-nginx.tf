# terraform-template-nginx.tf
# This is a test - Wassim Ben Jabria 

provider "ionoscloud" {
  username = "your_username"
  password = "your_password!"
}

terraform {
  required_providers {
    ionoscloud = {
      source  = "ionos-cloud/ionoscloud"
      version = "6.4.15"
    }
  }
}

resource "ionoscloud_datacenter" "example" {
  name                  = "DataCenter_test_2"
  location              = "de/fra"
  description           = "test with terraform"
  sec_auth_protection   = false
}

resource "ionoscloud_k8s_cluster" "example" {
  name          = "TestCluster"
  location      = ionoscloud_datacenter.example.location
  k8s_version   = "1.29.4"
}

resource "ionoscloud_k8s_node_pool" "example" {
  datacenter_id       = ionoscloud_datacenter.example.id
  k8s_cluster_id      = ionoscloud_k8s_cluster.example.id
  name                = "TestNodePool"
  cpu_family          = "INTEL_XEON"
  storage_type        = "SSD"
  node_count          = 2
  cores_count         = 4
  ram_size            = 8192
  storage_size        = 50
  availability_zone   = "AUTO"
  k8s_version   = "1.29.4"
}
