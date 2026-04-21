# 🚀 Approach – DevOps Assignment

## 📌 Objective

The goal of this project was to design and implement a complete DevOps workflow covering:

- Infrastructure provisioning (IaC)
- Application deployment
- CI/CD pipeline
- Monitoring and logging
- Security best practices

The focus was on building a *production-like, scalable, and maintainable setup*, rather than just making things work.

---

## 🧠 Design Thinking

Before implementation, I focused on:

1. *Separation of Concerns*
   - Infrastructure, application, and pipeline are handled independently
   - Ensures modularity and easier debugging

2. *Infrastructure as Code (IaC)*
   - Used Terraform to ensure reproducibility and version control
   - Avoided manual AWS configurations as much as possible

3. *Scalability & Real-world Practices*
   - Used ALB instead of direct EC2 access
   - Used RDS instead of local DB
   - Structured networking (VPC, subnets)

---

## 🏗️ Infrastructure Approach

### Network Design

- Created a custom VPC (10.0.0.0/16)
- Public subnet for EC2 and ALB
- Private subnet reserved for secure components (like DB if needed)
- Internet Gateway for external access

### Compute Layer

- EC2 instance used for hosting application
- Chosen instance type: t3.micro (cost-effective)

### Database Layer

- Used Amazon RDS (PostgreSQL)
- Managed service reduces operational overhead

### Load Balancing

- Application Load Balancer used for:
  - High availability
  - Better traffic distribution
  - Clean public access via DNS

---

## ⚙️ Terraform Strategy

- Used main.tf for resource definitions
- Used variables.tf for flexibility
- Used outputs.tf for exposing important values

### Key Decisions

- Avoided hardcoded values
- Used variables for CIDR, instance type, DB credentials
- Sensitive values moved to .tfvars (not committed)

---

## 🐳 Application Deployment Strategy

- Used Docker to containerize application
- Deployed Tomcat container on EC2

### Why Docker?

- Consistent environment
- Easy deployment and rollback
- Industry standard practice

---

## 🔄 CI/CD Approach

Used Jenkins for pipeline automation.

### Pipeline Flow

1. Code pushed to repository
2. Jenkins pipeline triggered
3. Build process executed
4. Docker image created
5. Deployment to EC2
6. Manual approval before production (control step)

### Key Decisions

- Automated repetitive tasks
- Added manual approval for safety
- Designed pipeline to be extendable

---

## 📊 Monitoring Approach

Used AWS CloudWatch for monitoring and logging.

### Infrastructure Monitoring

- CPU usage
- Memory usage (via CloudWatch Agent)
- Disk usage

### Application Monitoring

- Docker container logs
- Tomcat logs

### Logging Strategy

- Centralized logs in CloudWatch
- Used CloudWatch Agent on EC2

---

## 🔍 Drift Detection Strategy

To ensure infrastructure consistency:

- Intentionally modified AWS resources manually
- Ran terraform plan to detect drift
- Validated Terraform's ability to identify differences

### Resolution Strategy

- Either revert using terraform apply
- Or update Terraform code to match real state

---

## 🔐 Security Approach

- No hardcoded credentials in code
- Used .gitignore to exclude sensitive files
- Recommended use of:
  - AWS Secrets Manager
  - SSM Parameter Store

- Security Groups:
  - Only required ports opened
  - Restricted unnecessary access

---

## 💰 Cost Optimization Approach

- Used minimal instance size (t3.micro)
- Limited unnecessary services
- Controlled log retention in CloudWatch
- Avoided over-provisioning

---

## 🧩 Version Control Strategy

- Used Git for version control
- Structured repository with clear separation
- Maintained clean commit history

---

## ⚠️ Trade-offs

- Used single EC2 instance (not auto-scaling) to keep setup simple
- Local Terraform state (can be improved with remote backend)
- Basic CI/CD (can be enhanced with multi-stage environments)

---

## 🚀 Future Improvements

- Use S3 + DynamoDB for remote Terraform state
- Implement Auto Scaling Group
- Use ECR for Docker image storage
- Fully automate CI/CD (no manual steps)
- Integrate Secrets Manager for credentials
- Add alerting in CloudWatch

---

## 🎯 Conclusion

The approach focused on:

- Real-world DevOps practices
- Clean and maintainable infrastructure
- Security and scalability
- Observability and reliability

This project demonstrates my ability to design, implement, and manage a complete DevOps lifecycle with ownership
