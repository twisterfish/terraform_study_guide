# Lab 9 - HCL

This lab is cloud provider independent. The only difference between the IBM and AWS versions is to use the same definitions for the VM that you used in Lab 6.

## Part One: Using `count`

Review the solution to Lab 6 and ensure that you can use `count` to create and destroy multiple VM.

## Part Two: Using `for_each`

Use the same list of VM names you used in the previous part
 
Instead of _count_ use *for_each=toset(var.names)*

Ensure each machine has the Name tag corresponding to a name in the names list

Run apply to confirm that the machine are created correctly

### Removing a VM

Remove the middle name from the list of names in the terraform.tfvars file

Run terraform plan and notice carefully which of the VMs is actually destroyed

### Clean up the resources

Run terraform destroy

