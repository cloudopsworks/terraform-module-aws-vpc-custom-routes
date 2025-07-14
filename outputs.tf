##
# (c) 2021-2025
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

data "aws_route_table" "this" {
  subnet_id = var.subnet_id
}

resource "aws_route" "this" {
  count                     = length(var.routes)
  route_table_id            = var.routing_table_id != "" ? var.routing_table_id : data.aws_route_table.this.id
  destination_cidr_block    = var.routes[count.index].cidr_block
  nat_gateway_id            = var.routes[count.index].nat_gateway_id
  transit_gateway_id        = var.routes[count.index].transit_gateway_id
  vpc_peering_connection_id = var.routes[count.index].vpc_peering_connection_id
  egress_only_gateway_id    = var.routes[count.index].egress_only_internet_gateway_id
  network_interface_id      = var.routes[count.index].network_interface_id
  vpc_endpoint_id           = var.routes[count.index].vpc_endpoint_id
}