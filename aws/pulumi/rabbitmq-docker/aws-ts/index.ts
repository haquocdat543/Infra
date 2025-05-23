import * as pulumi from "@pulumi/pulumi";
import * as aws from "@pulumi/aws";

// Create an AWS resource (EC2 Security Group)
let group = new aws.ec2.SecurityGroup(
	"web-secgrp",
	{
		ingress: [
			{
				protocol: "tcp",
				fromPort: 22,
				toPort: 22,
				cidrBlocks:
					[
						"0.0.0.0/0"
					]
			},
		],
	});

let userData =
	`#!/bin/bash
# Install Docker and Rabbitmq
sudo apt-get update
sudo apt-get install docker.io -y
sudo usermod -aG docker ubuntu
newgrp docker
sudo chmod 777 /var/run/docker.sock
docker run -d --name rabbitmq -p 5672:5672 -p 15672:15672 rabbitmq:3.12-management
`;

// Create an AWS resource (EC2 Instance) 
let server = new aws.ec2.Instance(
	"web-server",
	{
		instanceType: "t2.micro",
		securityGroups: [
			group.name
		], // reference the group object above
		ami: "ami-07c589821f2b353aa", // this is an ID for an AMI that contains Amazon Linux
		userData: userData, // our user data script to install RabbitMQ
	});

// Export the name of the bucket
export const securityGroupName = group.name;
export const publicIp = server.publicIp;
export const publicDns = server.publicDns;

