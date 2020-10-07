variable "subnet_ids" {
    type = list(string)
    description = "(optional) describe your variable"
}
variable "node_subnets_ids" {
    type = list(string)
    description = "(optional) describe your variable"
}
variable "security_group_ids" {
    type = list(string)
    description = "(optional) describe your variable"
}
variable "endpoint_private_access" {
    type = bool
    description = "(optional) describe your variable"
}
variable "node_group_name" {
    type = string
    description = "(optional) describe your variable"
}
variable "launch_template_id" {
    type = string
    description = "(optional) describe your variable"
}
variable "launch_template_version" {
    type = number
    description = "(optional) describe your variable"
}
variable "desired_size" {
    type = number
    description = "(optional) describe your variable"
}
variable "max_size" {
    type = number
    description = "(optional) describe your variable"
}
variable "min_size" {
    type = number
    description = "(optional) describe your variable"
}