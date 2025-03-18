# Task 2 - Terraform and Cloud: create the infrastructure to host your container.

Using Terraform, create the following infrastructure in AWS (or equivalent):

- Server-based:
    - A VPC with 2 public and 2 private subnets.
    - An ECS/EKS or equivalent cluster deployed to that VPC.
    - A ECS/EKS task/service resource to run your container
    - The tasks and/nodes must be on the private subnets only.
    - A load balancer deployed in the public subnets to offer the service.
---

# Solution:
