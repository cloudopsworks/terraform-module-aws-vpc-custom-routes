##
# (c) 2021-2026
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

# subnet_ids: # (Optional) List of subnet IDs used to discover their associated route tables. Default: []
#   - "subnet-01234567890123456" # (Optional) Subnet ID. The route table associated to each subnet is resolved automatically.
variable "subnet_ids" {
  description = "(Optional) List of subnet IDs whose associated route tables will receive the custom routes. The route table for each subnet is discovered automatically. Required if routing_table_ids is not provided. Default: []"
  type        = list(string)
  default     = []
}

# routing_table_ids: # (Optional) List of route table IDs that will receive the custom routes. Default: []
#   - "rtb-01234567890123456" # (Optional) Route table ID targeted directly, no discovery is performed.
variable "routing_table_ids" {
  description = "(Optional) List of route table IDs that will receive the custom routes directly. Required if subnet_ids is not provided. Default: []"
  type        = list(string)
  default     = []
}

# routes: # (Optional) List of custom routes added to every resolved route table. Exactly one target must be set per route. Default: []
#   - cidr_block: "10.100.0.0/16"                       # (Required) Destination IPv4 or IPv6 CIDR block for the route.
#     nat_gateway_id: "nat-0123456789abcdef0"           # (Optional) NAT Gateway ID target. Default: null
#     transit_gateway_id: "tgw-0123456789abcdef0"       # (Optional) Transit Gateway ID target. Default: null
#     vpc_peering_connection_id: "pcx-0123456789abcdef0" # (Optional) VPC Peering Connection ID target. Default: null
#     egress_only_internet_gateway_id: "eigw-0123456789abcdef0" # (Optional) Egress-only Internet Gateway ID target (IPv6 destinations only). Default: null
#     network_interface_id: "eni-0123456789abcdef0"     # (Optional) Network Interface (ENI) ID target. Default: null
#     vpc_endpoint_id: "vpce-0123456789abcdef0"         # (Optional) Gateway Load Balancer VPC Endpoint ID target. Default: null
variable "routes" {
  description = "(Optional) List of custom routes to add to every resolved route table. Each entry requires a destination cidr_block and exactly one target (NAT Gateway, Transit Gateway, VPC Peering Connection, Egress-only Internet Gateway, Network Interface or VPC Endpoint). Default: []"
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
