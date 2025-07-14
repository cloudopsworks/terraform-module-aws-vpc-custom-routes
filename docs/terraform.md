## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 6.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.3.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_tags"></a> [tags](#module\_tags) | cloudopsworks/tags/local | 1.0.9 |

## Resources

| Name | Type |
|------|------|
| [aws_route.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_route_table.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route_table) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags) | Extra tags to add to the resources | `map(string)` | `{}` | no |
| <a name="input_is_hub"></a> [is\_hub](#input\_is\_hub) | Is this a hub or spoke configuration? | `bool` | `false` | no |
| <a name="input_org"></a> [org](#input\_org) | Organization details | <pre>object({<br/>    organization_name = string<br/>    organization_unit = string<br/>    environment_type  = string<br/>    environment_name  = string<br/>  })</pre> | n/a | yes |
| <a name="input_routes"></a> [routes](#input\_routes) | A list of routes to be added to the routing table. | <pre>list(object({<br/>    cidr_block                      = string<br/>    nat_gateway_id                  = optional(string, null)<br/>    transit_gateway_id              = optional(string, null)<br/>    vpc_peering_connection_id       = optional(string, null)<br/>    egress_only_internet_gateway_id = optional(string, null)<br/>    network_interface_id            = optional(string, null)<br/>    vpc_endpoint_id                 = optional(string, null)<br/>  }))</pre> | `[]` | no |
| <a name="input_routing_table_id"></a> [routing\_table\_id](#input\_routing\_table\_id) | The ID of the routing table to which the NAT gateway will be associated. Required if subnet\_id is not provided. | `string` | `""` | no |
| <a name="input_spoke_def"></a> [spoke\_def](#input\_spoke\_def) | Spoke ID Number, must be a 3 digit number | `string` | `"001"` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The ID of the subnet to which the NAT gateway will be associated. Required if routing\_table\_id is not provided. | `string` | `""` | no |

## Outputs

No outputs.
