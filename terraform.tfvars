clusters = [
  {
    env_type_id               = "non-prod",
    load_balancer             = "FIXME",
    load_balancer_hosted_zone = "FIXME",
    name                      = "eks-vc1-non-prod",
    aws_region                = "us-east-1",
    cloud_account = {
      aws_role    = "AWS-ROLE-1"
      external_id = "EXTERNAL-ID-1"
    }
  },
  {
    env_type_id               = "prod",
    load_balancer             = "FIXME",
    load_balancer_hosted_zone = "FIXME",
    name                      = "eks-vc1-prod",
    aws_region                = "us-east-1",
    cloud_account = {
      aws_role    = "AWS-ROLE-2"
      external_id = "EXTERNAL-ID-2"
    }
  },
]

apps = [
  {
    id : "sail-sharp",
    name : "sail-sharp",
    viewer_users : []
  },
  {
    id : "online-boutique",
    name : "online-boutique",
    viewer_users : []
  },
]