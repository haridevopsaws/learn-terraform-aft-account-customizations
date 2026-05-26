variable "custom_fields" {
  description = "Custom configuration fields"
  type        = map(string)

  default = {
    create_vpc = "false"
  }
}
