output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.new_vpc.id
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = [for subnet in aws_subnet.private_subnet : subnet.id]
}
