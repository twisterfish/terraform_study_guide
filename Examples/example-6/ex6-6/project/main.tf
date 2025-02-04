
module "vm" {
    count = length(var.names)
    source = "../modules/EC2"
    ami_type = var.amis[count.index]
    inst_type = var.insts[count.index]
    VM_name = var.names[count.index]
    sg_groups = module.SG.secgps
  }



module "SG" {
  source = "../modules/SGroup"
  access_port = 8080
  sg_name = "My Demo"
}
