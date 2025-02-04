

resource "aws_instance" "Matrix" {
    for_each = toset(var.VM_names)
    ami = "ami-0c101f26f147fa7fd"
    instance_type = "t2.micro"
    tags = {
        Name = "VM-${each.value}"
    }
}

variable "VM_names" {
    type = list(string)
    default = ["Neo",  "Morpheus", "Trinity"]
    #default = ["Neo",   "Trinity"]
} 





