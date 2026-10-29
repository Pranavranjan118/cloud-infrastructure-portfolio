output "vpc_id" {
  description = "ID of the portfolio VPC."
  value       = aws_vpc.portfolio.id
}

output "public_subnet_id" {
  description = "ID of the public subnet."
  value       = aws_subnet.public.id
}

output "instance_id" {
  description = "ID of the portfolio EC2 instance."
  value       = aws_instance.portfolio.id
}

output "instance_public_ip" {
  description = "Public IP of the portfolio EC2 instance."
  value       = aws_instance.portfolio.public_ip
}
