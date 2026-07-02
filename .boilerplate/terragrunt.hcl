locals {
  local_vars  = yamldecode(file("./inputs.yaml"))
  spoke_vars  = yamldecode(file(find_in_parent_folders("spoke-inputs.yaml")))
  region_vars = yamldecode(file(find_in_parent_folders("region-inputs.yaml")))
  env_vars    = yamldecode(file(find_in_parent_folders("env-inputs.yaml")))
  global_vars = yamldecode(file(find_in_parent_folders("global-inputs.yaml")))

  local_tags  = jsondecode(file("./local-tags.json"))
  spoke_tags  = jsondecode(file(find_in_parent_folders("spoke-tags.json")))
  region_tags = jsondecode(file(find_in_parent_folders("region-tags.json")))
  env_tags    = jsondecode(file(find_in_parent_folders("env-tags.json")))
  global_tags = jsondecode(file(find_in_parent_folders("global-tags.json")))

  tags = merge(
    local.global_tags,
    local.env_tags,
    local.region_tags,
    local.spoke_tags,
    local.local_tags
  )
}

include "root" {
  path = find_in_parent_folders("{{ .RootFileName }}")
}

terraform {
  source = "{{ .sourceUrl }}"
}
{{ if .vpc_dependency_enabled }}
dependency "vpc" {
  config_path = "{{ .vpc_dependency_path }}"
  # Configure mock outputs for the `validate` command that are returned when there are no outputs available (e.g the
  # module hasn't been applied yet.
  mock_outputs_allowed_terraform_commands = ["validate", "destroy"]
  mock_outputs = {
    vpc_name = "sample-vpc"
    vpc_id   = "vpc-12345678901234"
    private_route_table_ids = [
      "rtb-1234567890",
      "rtb-1234567891",
      "rtb-1234567892",
    ]
    public_route_table_ids = [
      "rtb-1234567893",
      "rtb-1234567894",
    ]
    intra_route_table_ids = [
      "rtb-1234567895",
      "rtb-1234567896",
      "rtb-1234567897",
    ]
    database_route_table_ids = [
      "rtb-1234567898",
      "rtb-1234567899",
    ]
    private_subnets = [
      "subnet-01234567890123456",
      "subnet-01234567890123457",
      "subnet-01234567890123458",
    ]
    intra_subnets = [
      "subnet-01234567890123456",
      "subnet-01234567890123457",
      "subnet-01234567890123458",
    ]
    public_subnets = [
      "subnet-01234567890123456",
      "subnet-01234567890123457",
    ]
    database_subnets = [
      "subnet-abcdef123456789",
      "subnet-abcdef123456781",
      "subnet-abcdef123456782",
    ]
  }
}
{{ end }}
inputs = {
  is_hub     = {{ .is_hub }}
  org        = local.env_vars.org
  spoke_def  = local.spoke_vars.spoke
  {{- range .requiredVariables }}
  {{- if ne .Name "org" }}
  {{ .Name }} = local.local_vars.{{ .Name }}
  {{- end }}
  {{- end }}
  {{- range .optionalVariables }}
  {{- if not (eq .Name "extra_tags" "is_hub" "spoke_def" "org") }}
  {{- if and $.vpc_dependency_enabled (eq .Name "routing_table_ids" "subnet_ids") }}
  {{- if eq $.vpc_dependency_route_tables_from "route_tables" }}
  {{- if eq $.vpc_dependency_network_type "both" }}
  routing_table_ids = concat(dependency.vpc.outputs.private_route_table_ids, dependency.vpc.outputs.intra_route_table_ids)
  {{- else if eq $.vpc_dependency_network_type "three" }}
  routing_table_ids = concat(dependency.vpc.outputs.private_route_table_ids, dependency.vpc.outputs.intra_route_table_ids, dependency.vpc.outputs.database_route_table_ids)
  {{- else }}
  routing_table_ids = dependency.vpc.outputs.{{ $.vpc_dependency_network_type }}_route_table_ids
  {{- end }}
  {{- else }}
  {{- if eq $.vpc_dependency_network_type "both" }}
  subnet_ids = concat(dependency.vpc.outputs.private_subnets, dependency.vpc.outputs.intra_subnets)
  {{- else if eq $.vpc_dependency_network_type "three" }}
  subnet_ids = concat(dependency.vpc.outputs.private_subnets, dependency.vpc.outputs.intra_subnets, dependency.vpc.outputs.database_subnets)
  {{- else }}
  subnet_ids = dependency.vpc.outputs.{{ $.vpc_dependency_network_type }}_subnets
  {{- end }}
  {{- end }}
  {{- else }}
  {{ .Name }} = try(local.local_vars.{{ .Name }}, {{ .DefaultValue }})
  {{- end }}
  {{- end }}
  {{- end }}
  extra_tags = local.tags
}