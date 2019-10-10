#data "aws_route_tables" "this_vpc_rts" {
#  vpc_id   =  tolist(aws_vpc.this.*.id)[0]
#}

output "vpc_route_table_ids" {
  value       = ["${concat(aws_route_table.public.*.id, aws_route_table.private.*.id)}"]
#  value       = [data.aws_route_tables.this_vpc_rts.*.ids]
#  depends_on = ["aws_route_table.public", "aws_route_table.private"]
}
