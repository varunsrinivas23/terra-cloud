#security group
resource "aws_security_group" "webserver_access" {
        name = "webserver_access"
        description = "allow ssh and http"

        ingress {
                from_port = 80
                to_port = 80
                protocol = "tcp"
                cidr_blocks = ["0.0.0.0/0"]
        }

        ingress {
                from_port = 22
                to_port = 22
                protocol = "tcp"
                cidr_blocks = ["0.0.0.0/0"]
        }

        egress {
                from_port = 0
                to_port = 0
                protocol = "-1"
                cidr_blocks = ["0.0.0.0/0"]
        }


}
#security group end here

#create block storage
resource "aws_ebs_volume" "data_vol" {
        availability_zone = "ap-south-1a"
        size = 5
}

resource "aws_volume_attachment" "ourfirst-vol" {
        device_name = "/dev/sdc"
        volume_id = "${aws_ebs_volume.data_vol.id}"
        instance_id = "${aws_instance.ourfirst.id}"
}

#block storage end here
resource "aws_instance" "ourfirst" {
  ami           = "ami-01a4f99c4ac11b03c"
  availability_zone = "ap-south-1a"
  instance_type = "t2.micro"
  security_groups = ["${aws_security_group.webserver_access.name}"]
  user_data = filebase64("install_httpd.sh")
  key_name = "zoomkey"
  tags = {
    Name  = "ec2-test"
    Location = "Mumbai"
  }

}
