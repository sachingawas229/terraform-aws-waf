output "web_acl_arn" {
  description = "The ARN of the WAF WebACL."
  value       = aws_wafv2_web_acl.acl.arn
}

output "web_acl_id" {
  description = "The ID of the WAF WebACL."
  value       = aws_wafv2_web_acl.acl.id
}

output "web_acl_name" {
  description = "The Name of the WAF WebACL."
  value       = aws_wafv2_web_acl.acl.name
}
