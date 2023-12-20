terraform {
  backend s3{
    bucket = "varun12345jenkinsmodule"
    key = "remote.tfstate"
    region = "ap-south-1"
  }
}
