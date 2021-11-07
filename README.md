# mcp-waf-module

This repo contains terraform  code with resources to deploy of waf.

## Deploy Example
<pre>
    <code>
module "cloudfront_wafv2" {
  source  = "trussworks/wafv2/aws"
  version = "0.0.1"

  name  = "cloudfront-web-acl"
  scope = "CLOUDFRONT"
}
}
    </code>
</pre>

## Deploy Example With ALB
<pre>
    <code>
module "alb_wafv2" {
  source  = "trussworks/wafv2/aws"
  version = "0.0.1"

  name  = "alb-web-acl"
  scope = "REGIONAL"

  resource-arns       = [aws_lb.lb.arn]
  associate_alb = true
}
    </code>
</pre>

## Usage blocking IP Sets
<pre>
    <code>
resource "aws_wafv2_ip_set" "ipset" {
  name = "blocked_ips"

  scope              = "REGIONAL"
  ip_address_version = "IPV4"

  addresses = [
    "1.2.3.4/32",
    "5.6.7.8/32"
  ]
}

module "wafv2" {
  source = "../../"

  name   = "wafv2"
  scope = "REGIONAL"

  ip_sets_rule = [
    {
      name       = "blocked_ips"
      action     = "block"
      priority   = 1
      ip_set_arn = aws_wafv2_ip_set.ipset.arn
    }
  ]
}
    </code>
</pre>

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_wafv2_web_acl.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_web_acl) | resource |
| [aws_wafv2_web_acl_association.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_web_acl_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alb_arn"></a> [alb\_arn](#input\_alb\_arn) | ARN of the ALB to be associated with the WAFv2 ACL. | `string` | `""` | no |
| <a name="input_associate_alb"></a> [associate\_alb](#input\_associate\_alb) | Whether to associate an ALB with the WAFv2 ACL. | `bool` | `false` | no |
| <a name="input_default_action"></a> [default\_action](#input\_default\_action) | The action to perform if none of the rules contained in the WebACL match. | `string` | `"allow"` | no |
| <a name="input_filtered_header_rule"></a> [filtered\_header\_rule](#input\_filtered\_header\_rule) | HTTP header to filter . Currently supports a single header type and multiple header values. | <pre>object({<br>    header_types = list(string)<br>    priority     = number<br>    header_value = string<br>    action       = string<br>  })</pre> | <pre>{<br>  "action": "block",<br>  "header_types": [],<br>  "header_value": "",<br>  "priority": 1<br>}</pre> | no |
| <a name="input_group_rules"></a> [group\_rules](#input\_group\_rules) | List of WAFv2 Rule Groups. | <pre>list(object({<br>    name            = string<br>    arn             = string<br>    priority        = number<br>    override_action = string<br>    excluded_rules  = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_ip_rate_based_rule"></a> [ip\_rate\_based\_rule](#input\_ip\_rate\_based\_rule) | A rate-based rule tracks the rate of requests for each originating IP address, and triggers the rule action when the rate exceeds a limit that you specify on the number of requests in any 5-minute time span | <pre>object({<br>    name     = string<br>    priority = number<br>    limit    = number<br>    action   = string<br>  })</pre> | `null` | no |
| <a name="input_ip_rate_url_based_rules"></a> [ip\_rate\_url\_based\_rules](#input\_ip\_rate\_url\_based\_rules) | A rate and url based rules tracks the rate of requests for each originating IP address, and triggers the rule action when the rate exceeds a limit that you specify on the number of requests in any 5-minute time span | <pre>list(object({<br>    name                  = string<br>    priority              = number<br>    limit                 = number<br>    action                = string<br>    search_string         = string<br>    positional_constraint = string<br>  }))</pre> | `[]` | no |
| <a name="input_ip_sets_rule"></a> [ip\_sets\_rule](#input\_ip\_sets\_rule) | A rule to detect web requests coming from particular IP addresses or address ranges. | <pre>list(object({<br>    name       = string<br>    priority   = number<br>    ip_set_arn = string<br>    action     = string<br>  }))</pre> | `[]` | no |
| <a name="input_managed_rules"></a> [managed\_rules](#input\_managed\_rules) | List of Managed WAF rules. | <pre>list(object({<br>    name            = string<br>    priority        = number<br>    override_action = string<br>    excluded_rules  = list(string)<br>  }))</pre> | <pre>[<br>  {<br>    "excluded_rules": [],<br>    "name": "AWSManagedRulesCommonRuleSet",<br>    "override_action": "none",<br>    "priority": 10<br>  },<br>  {<br>    "excluded_rules": [],<br>    "name": "AWSManagedRulesAmazonIpReputationList",<br>    "override_action": "none",<br>    "priority": 20<br>  },<br>  {<br>    "excluded_rules": [],<br>    "name": "AWSManagedRulesKnownBadInputsRuleSet",<br>    "override_action": "none",<br>    "priority": 30<br>  },<br>  {<br>    "excluded_rules": [],<br>    "name": "AWSManagedRulesSQLiRuleSet",<br>    "override_action": "none",<br>    "priority": 40<br>  },<br>  {<br>    "excluded_rules": [],<br>    "name": "AWSManagedRulesLinuxRuleSet",<br>    "override_action": "none",<br>    "priority": 50<br>  },<br>  {<br>    "excluded_rules": [],<br>    "name": "AWSManagedRulesUnixRuleSet",<br>    "override_action": "none",<br>    "priority": 60<br>  }<br>]</pre> | no |
| <a name="input_name"></a> [name](#input\_name) | A friendly name of the WebACL. | `string` | n/a | yes |
| <a name="input_scope"></a> [scope](#input\_scope) | The scope of this Web ACL. Valid options: CLOUDFRONT, REGIONAL. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the WAFv2 ACL. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_web_acl_id"></a> [web\_acl\_id](#output\_web\_acl\_id) | The ARN of the WAF WebACL. |
