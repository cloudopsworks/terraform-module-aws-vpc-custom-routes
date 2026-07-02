## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 6.35 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 6.35 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_tags"></a> [tags](#module\_tags) | cloudopsworks/tags/local | 1.0.9 |

## Resources

| Name | Type |
|------|------|
| [aws_route.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_route_table.from_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route_table) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags) | Extra tags to add to the resources | `map(string)` | `{}` | no |
| <a name="input_is_hub"></a> [is\_hub](#input\_is\_hub) | Is this a hub or spoke configuration? | `bool` | `false` | no |
| <a name="input_org"></a> [org](#input\_org) | Organization details | <pre>object({<br/>    organization_name = string<br/>    organization_unit = string<br/>    environment_type  = string<br/>    environment_name  = string<br/>  })</pre> | n/a | yes |
| <a name="input_routes"></a> [routes](#input\_routes) | (Optional) List of custom routes to add to every resolved route table. Each entry requires a destination cidr\_block and exactly one target (NAT Gateway, Transit Gateway, VPC Peering Connection, Egress-only Internet Gateway, Network Interface or VPC Endpoint). Default: [] | <pre>list(object({<br/>    cidr_block                      = string<br/>    nat_gateway_id                  = optional(string, null)<br/>    transit_gateway_id              = optional(string, null)<br/>    vpc_peering_connection_id       = optional(string, null)<br/>    egress_only_internet_gateway_id = optional(string, null)<br/>    network_interface_id            = optional(string, null)<br/>    vpc_endpoint_id                 = optional(string, null)<br/>  }))</pre> | `[]` | no |
| <a name="input_routing_table_ids"></a> [routing\_table\_ids](#input\_routing\_table\_ids) | (Optional) List of route table IDs that will receive the custom routes directly. Required if subnet\_ids is not provided. Default: [] | `list(string)` | `[]` | no |
| <a name="input_spoke_def"></a> [spoke\_def](#input\_spoke\_def) | Spoke ID Number, must be a 3 digit number | `string` | `"001"` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | (Optional) List of subnet IDs whose associated route tables will receive the custom routes. The route table for each subnet is discovered automatically. Required if routing\_table\_ids is not provided. Default: [] | `list(string)` | `[]` | no |

## Outputs

No outputs.
