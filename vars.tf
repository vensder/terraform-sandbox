variable "aws_region" {
  default = "us-east-1"
  /// default = "us-east-2"
  /// default = "us-west-2"
  /// default = "eu-central-1"
  /// default = "eu-west-1" /// too expensive
  /// default = "eu-west-2"
  /// default = "eu-west-3"
  /// default = "eu-north-1"
  /// default = "ca-central-1"
  /// default = "ap-southeast-1"
  /// default = "change-me-1"
}

# https://cloud-images.ubuntu.com/locator/ec2/
variable "ami" {
  type = map(string)
  default = {
    ap-east-1      = "ami-9f793dee"
    ap-northeast-1 = "ami-03344c819e1ac354d"
    ap-south-1     = "ami-0c28d7c6dd94fb3a7"
    ap-southeast-1 = "ami-0ca13b3dabeb6c66d"
    ca-central-1   = "ami-0f06e521718460abf"
    eu-central-1   = "ami-03d8059563982d7b0"
    eu-north-1     = "ami-017ad30b324faed9b"
    eu-west-1      = "ami-0f630a3f40b1eb0b8"
    me-south-1     = "ami-0df89c0ad05708804"
    sa-east-1      = "ami-0a16d0952a2a7b0ce"
    us-east-1      = "ami-08bc77a2c7eb2b1da"
    us-west-1      = "ami-094f0176b0d009d9f"
    ap-northeast-2 = "ami-0c5a717974f63b04c"
    ap-southeast-2 = "ami-02d7e25c1cfdd5695"
    eu-west-2      = "ami-0a590332f9f499197"
    us-east-2      = "ami-08cec7c429219e339"
    us-west-2      = "ami-02d0ea44ae3fe9561"
    ap-northeast-3 = "ami-03f0ddd1562f1b937"
    eu-west-3      = "ami-051ebe9615b416c15"
  }
}
