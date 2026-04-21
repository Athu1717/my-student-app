🚀 DevOps End-to-End Project (Terraform + Jenkins + Docker + AWS)

📌 Project Overview

This project demonstrates a complete end-to-end DevOps workflow including:

- Infrastructure provisioning using Terraform
- Application deployment using Docker
- CI/CD pipeline using Jenkins
- Monitoring using AWS CloudWatch
- Drift detection using Terraform

The focus is on real-world DevOps practices, not application development.

---

🏗️ Architecture

The system is deployed on AWS with the following components:

- VPC ("10.0.0.0/16")
- Public Subnet ("10.0.1.0/24")
- Private Subnet ("10.0.3.0/24")
- Internet Gateway & Route Tables
- EC2 Instance (t2.micro / t3.micro)
- Dockerized Tomcat Application
- RDS PostgreSQL Database
- Application Load Balancer (ALB)
- Security Groups
- CloudWatch Monitoring & Logging

---

⚙️ Tools & Technologies

- Terraform (Infrastructure as Code)
- AWS (EC2, VPC, RDS, ALB, CloudWatch)
- Docker (Tomcat container)
- Jenkins (CI/CD)
- Git & GitHub

---

🛠️ Infrastructure Provisioning (Terraform)

Infrastructure is fully automated using Terraform.

Resources Created:

- VPC and Subnets
- EC2 Instance
- RDS PostgreSQL
- Application Load Balancer
- Security Groups

Commands:

terraform init
terraform plan
terraform apply

Notes:

- Variables managed in "variables.tf"
- Outputs defined in "outputs.tf"
- Sensitive values moved to ".tfvars" (not committed)

---

🐳 Application Deployment

- Application deployed using Docker on EC2
- Tomcat container used for Java application

Run container:

docker run -d -p 8080:8080 tomcat

---

🔄 CI/CD Pipeline (Jenkins)

CI/CD pipeline automates build and deployment.

Pipeline Flow:

1. Code pushed to GitHub
2. Jenkins pipeline triggered
3. Build process starts
4. Docker image created
5. Application deployed to EC2
6. Manual approval before production


Features:

- Automated deployment
- Continuous integration
- Manual approval gate

---

📊 Monitoring & Logging (CloudWatch)

Monitoring is implemented using AWS CloudWatch.

Infrastructure Monitoring:

- CPU Utilization
- Memory Usage (via CloudWatch Agent)
- Disk Usage

Application Monitoring:

- Tomcat logs
- Docker container logs

Logging Setup:

- Centralized logging using CloudWatch Logs
- Logs collected from:
  - System logs
  - Docker container logs

Important Implementation:

CloudWatch Agent configured to read Docker logs from:

/var/lib/docker/containers/<container-id>/<container-id>-json.log

---

📈 Dashboards

Two dashboards were created:

1. Infrastructure Dashboard

- CPU usage
- Memory usage
- Disk usage

2. Application Dashboard

- Log monitoring
- Error tracking

---

🔍 Drift Detection (Terraform)

📌 What is Drift?

Drift occurs when infrastructure is changed manually outside Terraform, causing mismatch between:

- Terraform state
- Actual AWS infrastructure

---

🛠️ Implementation

1. Manually modified AWS resource (EC2 / Security Group)
2. Ran:

terraform plan

---

⚠️ Result

Terraform detected differences between expected and actual state:

~ instance_type = "t3.micro" -> "t2.micro"

---

✅ Resolution

Option 1: Revert Changes

terraform apply

Option 2: Accept Changes

- Update Terraform code
- Apply again

---

🎯 Importance

- Ensures infrastructure consistency
- Prevents configuration mismatch
- Critical in production environments

---

🔐 Security Best Practices

- No hardcoded credentials in code
- ".tfvars" excluded using ".gitignore"
- IAM roles used instead of credentials
- Recommended:
  - AWS Secrets Manager
  - SSM Parameter Store

---

💰 Cost Optimization

- Used small instance types (t2.micro / t3.micro)
- Limited log retention
- Avoided unnecessary resources

---

⚠️ Challenges & Solutions

1. Git Push Rejected

Issue:

failed to push some refs

Reason:
Remote repository already had commits

Solution:

git pull origin main --rebase
git push origin main

---

2. Hardcoded Password

Issue:
Password stored in Terraform code

Solution:

- Removed default value
- Used ".tfvars"
- Added to ".gitignore"

---

3. Docker Logs Not Visible in CloudWatch

Issue:
Logs inside container not accessible

Solution:
Used Docker host log path:

/var/lib/docker/containers/

---

4. CloudWatch Agent Issues

Issue:
Agent not collecting logs properly

Solution:

- Reconfigured agent
- Validated JSON config

---

5. Database Connection Issues

Issue:
Application not connecting to RDS

Solution:

- Fixed configuration
- Verified schema and connection using logs

---

▶️ How to Run the Project

1. Clone repository
2. Run Terraform:

terraform init
terraform apply

3. Deploy Docker container
4. Setup Jenkins pipeline
5. Access app via Load Balancer


🌐 Live Application

The application is accessible via AWS Application Load Balancer:

http://app-lb-1259709467.eu-north-1.elb.amazonaws.com/app/

✔ Verification

- Application is running on EC2 via Docker
- Traffic is routed through ALB
- Infrastructure provisioned using Terraform

---

📁 Project Structure

terraform/
│── main.tf
│── variables.tf
│── outputs.tf
│── terraform.tfvars (ignored)
│── .gitignore

---

📌 Future Improvements

- CI/CD automation without manual steps
- Remote Terraform backend (S3 + DynamoDB)
- Auto drift detection using pipelines
- Auto-scaling setup
- Full container orchestration (ECS/EKS)

---

📦 Deliverables

- Terraform scripts
- CI/CD pipeline
- Monitoring setup
- GitHub repository
- Documentation

---

👨‍💻 Author

Atharva Awajekar

