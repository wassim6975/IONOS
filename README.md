
```markdown
# Kubernetes Cluster Deployment with Terraform for IONOS Public Cloud by Wassim Ben Jabria

## Overview

This Terraform template enables the deployment of a Kubernetes cluster on the IONOS cloud platform. It includes the setup of a sample Nginx deployment.

## Prerequisites

### For Kubernetes:
- Ensure you have `kubectl` installed on your local machine.
- Access to a Kubernetes cluster.

### For Terraform:
- Ensure you have Terraform installed on your local machine.

## Usage

### Deploy the Kubernetes Cluster:

1. Clone this repository to your local machine.
2. Set your credentials:
   - Replace the placeholder values in the `main.tf` file with your IONOS cloud credentials.
   - Update the username and password in the provider block.
   
```hcl
provider "ionoscloud" {
  username = "your_username"
  password = "your_password"
}
```

3. Deploy the Kubernetes cluster:
   - Navigate to the directory containing the `main.tf` file.
   - Run `terraform init` to initialize the Terraform configuration.
   - Run `terraform plan` to check the Terraform changes
   - Run `terraform apply` to create the resources.

### Verify Deployment:

- Use `kubectl` commands to verify that the Kubernetes resources have been created successfully.

### Access Kubernetes Cluster:

- Use `kubectl` commands to interact with your Kubernetes cluster.
- For example, to get the nodes in the cluster:
  ```bash
  kubectl get nodes
  ```

### Credentials

- Username: Your IONOS cloud username
- Password: Your IONOS cloud password

## Author

Wassim Ben Jabria
```


# Command to get inside the pod 
kubectl exec -it <nginx-pod-name> -- /bin/bash

# Repository of the index.html
/usr/share/nginx/html

# Copy your local index.html and change the one in the pod 
cp index.html nginx-deployment-7c5ddbdf54-46v5g:/usr/share/nginx/html/index.html

# Change the index.html 
echo "<html><body><h1>Hello, world! It's Wassim Ben Jabria</h1></body></html>" > index.html

# Command to map your pod port to your local machine port 
kubectl port-forward service/nginx-service 6556:80

# Useful command to deply your terraform template
terraform init 
terraform plan
terraform apply 