# resource "aws_internet_gateway" "igw" {
#   vpc_id = aws_vpc.main.id
# }
# 
# resource "aws_route" "public_internet_access" {
#   route_table_id         = aws_route_table.public.id
#   destination_cidr_block = "0.0.0.0/0"
#   gateway_id             = aws_internet_gateway.igw.id
# }