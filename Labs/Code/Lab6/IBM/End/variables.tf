variable "res_group" {
    description = "Resource group for this lab"
    type = string
}

variable "vm_image" {
    description = "Image used for vm"
    type = string
    default = "r006-bb322b53-e1b2-4968-bc60-60c99ac50729"
}

variable "vm_profile" {
    description = "Profile used for vm"
    type = string
}

variable "owners" {
  description = "Instance type for the VM"
  type        = list(string)
}

