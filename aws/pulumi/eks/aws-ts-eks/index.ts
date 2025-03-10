// Copyright 2016-2019, Pulumi Corporation.  All rights reserved.

//##################################################################################################
// Import
//##################################################################################################
import * as awsx from "@pulumi/awsx";
import * as eks from "@pulumi/eks";

//##################################################################################################
// Configuration
//##################################################################################################
const local = {

	vpc: {
		name: "test",
		numberOfAvailabilityZones: 2,
	},

	eks: {
		name: "test",
		instanceType: "t2.medium",
		desiredCapacity: 2,
		minSize: 1,
		maxSize: 2,
	},

}

//##################################################################################################
// Resources
//##################################################################################################
// Create a VPC for our cluster.
const vpc = new awsx.ec2.Vpc(
	local.vpc.name,
	{
		numberOfAvailabilityZones: local.vpc.numberOfAvailabilityZones,
	}
);

// Create the EKS cluster itself and a deployment of the Kubernetes dashboard.
const cluster = new eks.Cluster(
	local.eks.name,
	{
		vpcId: vpc.vpcId,
		subnetIds: vpc.publicSubnetIds,
		instanceType: local.eks.instanceType,
		desiredCapacity: local.eks.desiredCapacity,
		minSize: local.eks.minSize,
		maxSize: local.eks.maxSize,
	});

//##################################################################################################
// Export output
//##################################################################################################
export const kubeconfig = cluster.kubeconfig;
