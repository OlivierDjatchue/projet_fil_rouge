# This script will list the active AWS resources in the account


# List the following AWS resources
# 1. EC2 instances
# 2. S3 buckets
# 3. IAM users
# 4. EKS clusters


# Check if the AWS CLI is installed
if ! command -v aws &> /dev/null; then
    echo "AWS CLI is not installed"
    exit 1
fi

# List EC2 instances
echo "EC2 instances:"
aws ec2 describe-instances --query 'Reservations[*].Instances[*].[InstanceId,InstanceType,State.Name,PublicIpAddress,PrivateIpAddress]' --output table

# List S3 buckets
echo "S3 buckets:"
aws s3api list-buckets --query 'Buckets[*].Name' --output table

# List IAM users
echo "IAM users:"

# List EKS clusters
echo "EKS clusters:"
aws eks list-clusters --query 'clusters' --output table

# End of script
# Save the script and make it executable with the following command:
# chmod +x aws_resource_list.sh
# Run the script with the following command:

# ./aws_resource_list.sh
# The script will list the active AWS resources in the account, including EC2 instances, S3 buckets, IAM users, and EKS clusters. You can customize the script to include additional AWS resources as needed.
