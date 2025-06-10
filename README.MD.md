#  Terraform AWS IAM Users, Groups, and Policies

This project uses **Terraform** to create and manage **IAM users, groups, and policies** in AWS. It showcases how to implement a basic **role-based access control (RBAC)** setup using only IaC (Infrastructure as Code).

---

###   What This Code Does

### 1. **Creates IAM Groups**
- `CloudOps_L1`
- `CloudAdmins`
- `Developers`


### 2. **Creates IAM Users**
- `cloud_ops`
- `cloud_admin`
- `developer`

### 3. **Assigns Users to Groups**
- Each user is associated with their respective group using `aws_iam_user_group_membership`.

### 4. **Defines Custom IAM Policies**
Policies are defined inline using `jsonencode()` in Terraform:

- `CloudOpsL1Policy`  
  ➤ Allows: Start/Stop EC2, Describe Logs, Describe EC2 Instances

- `CloudAdminPolicy`  
  ➤ Allows: Full EC2 & VPC Access, IAM PassRole

- `DeveloperPolicy`  
  ➤ Allows: S3 Get/Put, EC2 Describe, CodeDeploy full access

### 5. **Attaches Policies to Groups**
- Each policy is attached to its corresponding IAM group using `aws_iam_group_policy_attachment`.

---

## Below are the IAC code execute via command steps & its result

# IAC IAM user code in VS Code  
![VS Code](IAC-vs code.png)

## Terraform Init command    
![Init Screenshot](Terraform-init.png)

## Terraform Plan command   
![Plan Screenshot 1](Terraform-plan-1.png)  
![Plan Screenshot 2](Terraform-plan-2.png)

## Terraform Apply command    
![Apply Screenshot 1](Terraform-apply-1.png)  
![Apply Screenshot 2](Terraform-apply-2.png)

## Terraform Apply Result    
![Apply Result](Terraform-apply-result.png)

## Final Result on IAM Dashboard (Users)  
![IAM 1](iam-dashboard-1.png)  
![IAM 2](iam-dashboard-2.png)  
![IAM 3](iam-dashboard-3.png)  














