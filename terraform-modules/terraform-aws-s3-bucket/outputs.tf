output "id" {
  description = "The name of the bucket."
  value       = element(concat(aws_s3_bucket.this.*.id, list("")), 0)
}

output "arn" {
  description = "The ARN of the bucket. Will be of format arn:aws:s3:::bucketname."
  value       = element(concat(aws_s3_bucket.this.*.arn, list("")), 0)
}


output "bucket_domain_name" {
  description = "The bucket domain name. Will be of format bucketname.s3.amazonaws.com."
  value       = element(concat(aws_s3_bucket.this.*.bucket_domain_name, list("")), 0)
}

output "bucket_regional_domain_name" {
  description = "The bucket region-specific domain name. The bucket domain name including the region name, please refer here for format. Note: The AWS CloudFront allows specifying S3 region-specific endpoint when creating S3 origin, it will prevent redirect issues from CloudFront to S3 Origin URL."
  value       = element(concat(aws_s3_bucket.this.*.bucket_regional_domain_name, list("")), 0)
}

output "hosted_zone_id" {
  description = "The Route 53 Hosted Zone ID for this bucket's region."
  value       = element(concat(aws_s3_bucket.this.*.hosted_zone_id, list("")), 0)
}

output "region" {
  description = "The AWS region this bucket resides in."
  value       = element(concat(aws_s3_bucket.this.*.region, list("")), 0)
}

output "website_endpoint" {
  description = "The website endpoint, if the bucket is configured with a website. If not, this will be an empty string."
  value       = element(concat(aws_s3_bucket.this.*.website_endpoint, list("")), 0)
}

output "website_domain" {
  description = "The domain of the website endpoint, if the bucket is configured with a website. If not, this will be an empty string. This is used to create Route 53 alias records. "
  value       = element(concat(aws_s3_bucket.this.*.website_domain, list("")), 0)
}
