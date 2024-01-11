// Copyright 2016-2021, Pulumi Corporation.  All rights reserved.

import * as aws from "@pulumi/aws";
import * as pulumi from "@pulumi/pulumi";

// Get the id for the latest Amazon Linux AMI
const ami = "ami-0dfa284c9d7b2adad"
const key = "Window2"

// create a new security group for port 80
const group = new aws.ec2.SecurityGroup("web-secgrp", {
    ingress: [
        { protocol: "tcp", fromPort: 22, toPort: 22, cidrBlocks: ["0.0.0.0/0"] },
    ],
});

// (optional) create a simple web server using the startup script for the instance
const userData =
`#!/bin/bash
sudo yum install nginx
sudo systemctl start nginx
sudo systemctl enable nginx
`;

const server = new aws.ec2.Instance("web-server-www", {
    tags: { "Name": "web-server-www" },
    instanceType: aws.ec2.InstanceType.T2_Micro, // t2.micro is available in the AWS free tier
    vpcSecurityGroupIds: [ group.id ], // reference the group object above
    ami: ami,
    keyName: key,
    userData: userData,              // start a simple web server
});

export const publicIp = server.publicIp;
export const publicHostName = server.publicDns;
