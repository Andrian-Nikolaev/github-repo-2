# github-repo-2
## This github repo contains solutions for challenge from 5 to 9
- Multiple provider configurations -> The aws provider is configured twice for two different regions (us-east-1, us-east-2) and passed to the child module with aliases
- Resources in 2 different regions -> Two aws_instances are created in two separate regions (us-east-1, us-east-2) using the two different provider blocks, through their aliases
- Child modules -> Custom module called ec2-instance is defined and used by the root module
## What does the configuration do
This Terraform configuration creates a total of 4 aws_instances, two in each mentioned region of AWS. This is done by two implementation of aws providers and passing them explicitly to the ec2-instance child module or to a simple aws_instance resource.
The child module ec2-instance is called twice by the root module and applies the two different provider configuration using their different aliases. The child module ec2-instance has a terraform.tf file where the provider requirements are specified. Their you can find the configuration_aliases argument which is needed because the child mode is called by the root using provider aliases, thus they need to be set up so the child expects to be called with an alias provider.

