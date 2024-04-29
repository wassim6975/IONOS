# terraform-template-nginx.tf
# This is a test - Wassim Ben Jabria 

provider "ionoscloud" {
  username = "xxx" # to be completed 
  password = "xxx" # to be completed 
}

resource "ionoscloud_datacenter" "example" {
  name                  = "DataCenter_test"
  location              = "de/txl"
  description           = "test for interview"
  sec_auth_protection   = false
}

resource "ionoscloud_k8s_cluster" "example" {
  name          = "Test"
  location      = "de/txl"
  k8s_version   = "1.29.4"
  
  maintenance_window {
    day_of_the_week     = "Sunday"
    time                = "01:15:11Z"
  }
}

resource "ionoscloud_k8s_node_pool" "example" {
  cluster_id          = ionoscloud_k8s_cluster.example.id
  k8s_version         = ionoscloud_k8s_cluster.example.k8s_version
  name                = "testNodePool"
  flavor              = "CLOUDING_FS21"
  
  maintenance_window {
    day_of_the_week     = "Saturday"
    time                = "08:39:07Z"
  } 
  
  cpu_family          = "INTEL_XEON"
  storage_type        = "SSD"
  node_count          = 2
  cores_count         = 4
  ram_size            = 8000
  storage_size        = 25
  availability_zone   = "AUTO"
  
  lans {
    id                  = ionoscloud_lan.example.id
    dhcp                = true
    
    routes {
      network           = "85.215.242.151/24"
      gateway_ip        = "85.215.242.1"
    }
  }  
}

resource "ionoscloud_k8s_deployment" "nginx_deployment" {
  cluster_id = ionoscloud_k8s_cluster.example.id
  name       = "nginx-deployment"

  spec {
    replicas = 3

    selector {
      match_labels = {
        app = "nginx"
      }
    }

    template {
      metadata {
        labels = {
          app     = "nginx"
          updated = "true"  # to update
        }
      }

      spec {
        container {
          name  = "nginx"
          image = "nginx:latest"

          port {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "ionoscloud_k8s_service" "nginx_service" {
  cluster_id = ionoscloud_k8s_cluster.example.id
  name       = "nginx-service"

  spec {
    selector = {
      app = "nginx"
    }

    port {
      protocol    = "TCP"
      port        = 80
      target_port = 80
    }
  }
}
