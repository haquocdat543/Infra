import * as pulumi from "@pulumi/pulumi";
import * as aws from "@pulumi/aws";

// Create a new VPC
const vpc = new aws.ec2.Vpc("my-vpc", {
    cidrBlock: "10.0.0.0/16",
    enableDnsHostnames: true,
    enableDnsSupport: true,
});

// Create a new subnet within the VPC
const subnet1 = new aws.ec2.Subnet("my-subnet1", {
    vpcId: vpc.id,
    cidrBlock: "10.0.0.0/24",
    availabilityZone: "ap-northeast-1a",
});

const subnet2 = new aws.ec2.Subnet("my-subnet2", {
    vpcId: vpc.id,
    cidrBlock: "10.0.1.0/24",
    availabilityZone: "ap-northeast-1d",
});

// Create a new security group for the EC2 instance
const securityGroup = new aws.ec2.SecurityGroup("my-security-group", {
    vpcId: vpc.id,
    ingress: [{ fromPort: 22, toPort: 22, protocol: "tcp", cidrBlocks: ["0.0.0.0/0"] },{ fromPort: 3306, toPort: 3306, protocol: "tcp", cidrBlocks: ["0.0.0.0/0"] }],
});

// Create an RDS subnet group
const rdsSubnetGroup = new aws.rds.SubnetGroup("my-rds-subnet-group", {
    subnetIds: [subnet1.id, subnet2.id],
    description: "My RDS Subnet Group",
});

// Create a new RDS instance
const rdsInstance = new aws.rds.Instance("my-rds-instance", {
    allocatedStorage: 20,               // Storage size in gigabytes
    engine: "mysql",                     // Database engine
    instanceClass: "db.t2.micro",        // Instance type
    dbSubnetGroupName: rdsSubnetGroup.name, // Database subnet group
    name: "mydatabase",                  // Database name
    username: "admin",                   // Database username
    password: "secretpassword",          // Database password
    publiclyAccessible: false,           // Set to true if you want the database to be publicly accessible
});

// Export the connection details
export const dbEndpoint = rdsInstance.endpoint;
export const dbUsername = rdsInstance.username;
export const dbPassword = rdsInstance.password;
