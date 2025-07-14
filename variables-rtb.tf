##
# (c) 2021-2025
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

variable "subnet_id" {
  description = "The ID of the subnet to which the NAT gateway will be associated. Required if routing_table_id is not provided."
  type        = string
  default     = ""
}
variable "routing_table_id" {
  description = "The ID of the routing table to which the NAT gateway will be associated. Required if subnet_id is not provided."
  type        = string
  default     = ""
}

variable "routes" {
  description = "A list of routes to be added to the routing table."
  type = list(object({
    cidr_block                      = string
    nat_gateway_id                  = optional(string, null)
    transit_gateway_id              = optional(string, null)
    vpc_peering_connection_id       = optional(string, null)
    egress_only_internet_gateway_id = optional(string, null)
    network_interface_id            = optional(string, null)
    vpc_endpoint_id                 = optional(string, null)
  }))
  default = []
}