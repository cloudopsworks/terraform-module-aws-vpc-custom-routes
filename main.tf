##
# (c) 2021-2025
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

locals {
  route_mappings_by_subnet = merge([
    for routes in var.routes : {
      for rt in data.aws_route_table.from_subnets : "${rt.subnet_id}_${routes.cidr_block}" => {
        route_table_id            = rt.id
        destination_cidr_block    = routes.cidr_block
        nat_gateway_id            = routes.nat_gateway_id
        transit_gateway_id        = routes.transit_gateway_id
        vpc_peering_connection_id = routes.vpc_peering_connection_id
        egress_only_gateway_id    = routes.egress_only_internet_gateway_id
        network_interface_id      = routes.network_interface_id
        vpc_endpoint_id           = routes.vpc_endpoint_id
      }
    }
  ])
  route_mappings_by_route_table = merge([
    for routes in var.routes : {
      for rt in data.aws_route_table.from_route_tables : "${rt.subnet_id}_${routes.cidr_block}" => {
        route_table_id            = rt.id
        destination_cidr_block    = routes.cidr_block
        nat_gateway_id            = routes.nat_gateway_id
        transit_gateway_id        = routes.transit_gateway_id
        vpc_peering_connection_id = routes.vpc_peering_connection_id
        egress_only_gateway_id    = routes.egress_only_internet_gateway_id
        network_interface_id      = routes.network_interface_id
        vpc_endpoint_id           = routes.vpc_endpoint_id
      }
    }
  ])
  route_mappings = merge(local.route_mappings_by_subnet, local.route_mappings_by_route_table)
}

data "aws_route_table" "from_subnets" {
  for_each  = toset(var.subnet_ids)
  subnet_id = each.value
}

data "aws_route_table" "from_route_tables" {
  for_each       = toset(var.routing_table_ids)
  route_table_id = each.value
}

resource "aws_route" "this" {
  for_each                  = local.route_mappings
  route_table_id            = each.value.route_table_id
  destination_cidr_block    = each.value.cidr_block
  nat_gateway_id            = each.value.nat_gateway_id
  transit_gateway_id        = each.value.transit_gateway_id
  vpc_peering_connection_id = each.value.vpc_peering_connection_id
  egress_only_gateway_id    = each.value.egress_only_internet_gateway_id
  network_interface_id      = each.value.network_interface_id
  vpc_endpoint_id           = each.value.vpc_endpoint_id
}