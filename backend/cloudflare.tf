resource "cloudflare_zone" "cf_zone" {
  zone       = local.domain_name
  type       = "full"
  account_id = var.cloudflare_account_id
}

resource "cloudflare_record" "cf_record" {

  for_each = {
    for item in aws_acm_certificate.cert.domain_validation_options : item.domain_name => {
      name   = item.resource_record_name
      record = item.resource_record_value
      type   = item.resource_record_type
    }
  }

  zone_id         = cloudflare_zone.cf_zone.id
  allow_overwrite = true
  proxied         = false
  name            = each.value.name
  type            = each.value.type
  value           = trimsuffix(each.value.record, ".")
}

resource "cloudflare_record" "cf_cloudfront_record" {

  zone_id         = cloudflare_zone.cf_zone.id
  allow_overwrite = true
  proxied         = true
  name            = local.domain_name
  type            = "CNAME"
  value           = trimsuffix(aws_cloudfront_distribution.s3_distribution.domain_name, ".")
}