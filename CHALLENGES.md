# ⚠️ Challenges & Solutions – DevOps Assignment

## 📌 Overview

During this assignment, I encountered several real-world challenges across infrastructure provisioning, CI/CD setup, application deployment, and monitoring. Below are the key issues, their root causes, and how I resolved them.

---

## 1️⃣ Git Push Rejected (Non-Fast-Forward Error)

### ❌ Issue

While pushing code to GitHub:


failed to push some refs
Updates were rejected because the remote contains work that you do not have locally


### 🔍 Root Cause

- Remote repository already had existing commits  
- Local repository was not in sync with remote  

### ✅ Solution


git pull origin main --rebase
git push origin main


### 🎯 Learning

- Always sync with remote before pushing  
- Understanding rebase helps maintain clean commit history  

---

## 2️⃣ Hardcoded Password in Terraform

### ❌ Issue

Database password was initially written directly in variables.tf.

### 🔍 Problem

- Security risk  
- Not acceptable in production environments  
- Sensitive data exposed in version control  

### ✅ Solution

- Removed password from variables.tf  
- Created terraform.tfvars for local secrets  
- Added .tfvars to .gitignore  

### 🔐 Best Practice

- Use AWS Secrets Manager or SSM Parameter Store  

---

## 3️⃣ CloudWatch Not Capturing Docker Logs

### ❌ Issue

CloudWatch Agent was running, but application logs inside Docker container were not visible.

### 🔍 Root Cause

- CloudWatch Agent reads logs from host machine  
- Docker stores logs separately  

### ✅ Solution

Configured CloudWatch Agent to read Docker logs from:


/var/lib/docker/containers/<container-id>/<container-id>-json.log


### 🎯 Learning

- Container logs need explicit integration with monitoring tools  

---

## 4️⃣ CloudWatch Agent Configuration Issues

### ❌ Issue

Metrics were not appearing in CloudWatch.

### 🔍 Root Cause

- Incorrect or incomplete configuration  
- Missing metrics setup  

### ✅ Solution

Reconfigured agent using:


sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-config-wizard


- Validated JSON config  
- Restarted agent  

### 🎯 Learning

- Always validate agent config and check logs for debugging  

---

## 5️⃣ Database Connection Failure (RDS)

### ❌ Issue

Application was unable to connect to PostgreSQL database.

### 🔍 Root Cause

- Security group not allowing inbound DB access  
- Incorrect DB endpoint or credentials  

### ✅ Solution

- Allowed port 5432 from EC2 security group  
- Verified:
  - RDS endpoint  
  - Username/password  
  - Database name  

### 🎯 Learning

- Networking (security groups) is a common root cause  
- Always test connectivity step-by-step  

---

## 6️⃣ Terraform Drift (State vs Actual Infrastructure)

### ❌ Issue

Manual changes in AWS caused mismatch with Terraform state.

### 🔍 What Happened

After manually modifying a resource:


terraform plan


Terraform detected drift:


~ instance_type = "t3.micro" -> "t2.micro"


### ✅ Solution

*Option 1 (Recommended):*

terraform apply


*Option 2:*
- Update Terraform code to match changes  
- Apply again  

### 🎯 Learning

- Infrastructure should always be controlled via code  
- Drift detection is critical in production  

---

## 7️⃣ CI/CD Pipeline Issues (Jenkins)

### ❌ Issue

Pipeline failed during initial setup.

### 🔍 Root Cause

- Missing dependencies (Docker, permissions)  
- Incorrect pipeline configuration  

### ✅ Solution

- Installed required tools (Docker, plugins)  
- Fixed pipeline script and environment setup  
- Verified each stage individually  

### 🎯 Learning

- Debug pipelines step-by-step  
- Validate environment before automation  

---

## 8️⃣ Load Balancer (ALB) Access Issues

### ❌ Issue

Application was not accessible via Load Balancer DNS.

### 🔍 Root Cause

- Incorrect target group configuration  
- Health checks failing  
- Security group misconfiguration  

### ✅ Solution

- Verified target group port (8080)  
- Fixed health check path  
- Allowed HTTP traffic (port 80) in security group  

### 🎯 Learning

- ALB depends on correct health checks  
- Security groups must allow required traffic  

---

## 🎯 Key Takeaways

- Most issues were related to networking, configuration, and permissions  
- Debugging and troubleshooting are critical DevOps skills  
- Observability (logs + metrics) helps in faster issue resolution  

---

## 🚀 Conclusion

These challenges helped me strengthen my debugging skills, understand real-world infrastructure issues, and improve system reliability and security.  

This project reflects my ability to identify problems, analyze root causes, and implement effective solutions with ownership.
