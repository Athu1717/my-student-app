# 🚀 DevOps Project – End-to-End Implementation

## 📌 Project Overview

This project demonstrates a complete end-to-end DevOps workflow including:

- Infrastructure provisioning using Terraform  
- Application deployment using Docker  
- CI/CD pipeline using Jenkins  
- Monitoring and logging using AWS CloudWatch  

The focus of this project is to implement real-world DevOps practices such as automation, scalability, and observability.

---

## 🏗️ Architecture

The application is deployed on AWS using the following components:

- VPC with custom CIDR (10.0.0.0/16)
- Public Subnet for application hosting
- EC2 instance to run Docker container
- Dockerized Tomcat application
- RDS PostgreSQL database
- Application Load Balancer (ALB) for public access
- Security Groups for controlled access
- CloudWatch for monitoring and logging

---

## ⚙️ Infrastructure (Terraform)

Infrastructure is provisioned using Terraform (Infrastructure as Code).

### Resources Created:
- VPC and Subnets  
- EC2 Instance  
- RDS PostgreSQL  
- Application Load Balancer  
- Security Groups  

### Commands:

bash
terraform init
terraform plan
terraform apply


### Configuration:
- Variables managed in variables.tf
- Outputs defined in outputs.tf
- Sensitive values handled using .tfvars (not committed)

---

## 🐳 Application Deployment

- Application is containerized using Docker  
- Tomcat is used as the application server  

### Run container:

bash
docker run -d -p 8080:8080 tomcat


- Application runs on EC2 instance  
- Exposed via Load Balancer  

---

## 🔄 CI/CD Pipeline (Jenkins)

A Jenkins pipeline is used to automate deployment.

### Pipeline Flow:

1. Code pushed to GitHub  
2. Jenkins pipeline triggered  
3. Build process executed  
4. Docker image created  
5. Application deployed to EC2  
6. Manual approval step before production  

### Key Features:

- Automated deployment  
- Continuous integration  
- Controlled production release  

---

## 📊 Monitoring & Logging

Monitoring is implemented using AWS CloudWatch.

### Infrastructure Monitoring:
- CPU utilization  
- Memory usage (via CloudWatch Agent)  
- Disk usage  

### Application Monitoring:
- Tomcat logs  
- Docker container logs  

### Logging:
- Centralized logging using CloudWatch Logs  
- Logs collected from:
  - System logs  
  - Docker container logs  

---

## 📈 Dashboards

Two dashboards are created:

### Infrastructure Dashboard:
- CPU usage  
- Memory usage  
- Disk usage  

### Application Dashboard:
- Log monitoring  
- Error tracking  

---

## 🔐 Security

- Security groups restrict access to required ports only  
- IAM roles used instead of hardcoded credentials  
- Sensitive data not stored in repository  

---

## 💰 Cost Optimization

- Used minimal instance type (t2.micro / t3.micro)  
- Limited log retention  
- Avoided unnecessary resources  

---

## 🌐 Live Application

Application is accessible via AWS Load Balancer:


http://app-lb-1259709467.eu-north-1.elb.amazonaws.com/app/


---

## ▶️ How to Run

1. Clone repository  
2. Run Terraform:
   bash
   terraform init
   terraform apply
   
3. Deploy Docker container  
4. Access application via Load Balancer  

---

## 👨‍💻 Author

Atharva Awajekar
