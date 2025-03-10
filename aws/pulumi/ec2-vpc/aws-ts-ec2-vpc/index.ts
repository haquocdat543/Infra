import * as pulumi from "@pulumi/pulumi";
import * as aws from "@pulumi/aws";

// Set Variable
const ami = "ami-0dfa284c9d7b2adad"
const key = "Window2"

// Set Userdata
const userData =
	`#!/bin/bash
sudo yum install nginx
sudo systemctl start nginx
sudo systemctl enable nginx
`;

// Create a new VPC
const vpc = new aws.ec2.Vpc("my-vpc", {
	cidrBlock: "10.0.0.0/16",
	enableDnsHostnames: true,
	enableDnsSupport: true,
});

// Create a new subnet within the VPC
const subnet = new aws.ec2.Subnet("my-subnet", {
	vpcId: vpc.id,
	cidrBlock: "10.0.0.0/24",
	availabilityZone: "ap-northeast-1a",
});

// Create a new security group for the EC2 instance
const securityGroup = new aws.ec2.SecurityGroup(
	"my-security-group",
	{
		vpcId: vpc.id,
		ingress: [
			{
				fromPort: 22,
				toPort: 22,
				protocol: "tcp",
				cidrBlocks:
					[
						"0.0.0.0/0"
					]
			},
			{
				fromPort: 80,
				toPort: 80,
				protocol: "tcp",
				cidrBlocks:
					[
						"0.0.0.0/0"
					]
			}
		],
	});

// Create a new EC2 instance within the subnet and security group
const ec2Instance = new aws.ec2.Instance(
	"my-ec2-instance",
	{
		ami: ami, // Replace with your desired AMI
		instanceType: "t2.micro",
		subnetId: subnet.id,
		vpcSecurityGroupIds: [
			securityGroup.id
		],
		keyName: key,
		userData: userData,              // start a simple web server
		tags: {
			Name: "MyEC2Instance",
		},
	});

// Export the instance's public IP address
export const publicIp = ec2Instance.publicIp;
