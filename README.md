# Terraform Infrastructure Setup

## 🚀 Overview
This repository contains Terraform configurations to deploy infrastructure on Proxmox. It includes the necessary files for defining providers, variables, credentials, and the main execution logic.

## 📁 Project Structure
```
.
├── provider.tf          # Defines the Proxmox provider configuration
├── vars.tf              # Declares input variables used in the Terraform stack
├── terraform.tfvars     # Stores sensitive credentials (DO NOT COMMIT)
├── main.tf              # Main Terraform configuration file
├── README.md            # Project documentation
```

## 🔧 Prerequisites
Ensure you have the following installed:
- [Terraform](https://developer.hashicorp.com/terraform/downloads)
- Proxmox API credentials

## 🛠 Setup & Usage
1. **Initialize Terraform**
   ```sh
   terraform init
   ```
2. **Plan the deployment**
   ```sh
   terraform plan -var-file="credentials.tfvars"
   ```
3. **Apply the configuration**
   ```sh
   terraform apply -var-file="credentials.tfvars" -auto-approve
   ```
4. **Destroy the resources (Cleanup)**
   ```sh
   terraform destroy -var-file="credentials.tfvars" -auto-approve
   ```

## 🔒 Security Best Practices
- **Do not commit `credentials.tfvars` to Git** ❌
- Use `.gitignore` to exclude sensitive files:
  ```sh
  echo "terraform.tfvars" >> .gitignore
  ```
- Consider using environment variables for credentials:
  ```sh
  export TF_VAR_proxmox_prod_secret_token="your-secret-token"
  ```

## 📜 License
This project is licensed under the MIT License.

## 📩 Contact
For any issues, feel free to open an issue or reach out!

---

### 📌 Notes
- Always validate changes with `terraform plan` before applying.
- Use `terraform state list` to inspect current state if needed.
- Regularly update Terraform to benefit from security and performance improvements.
- Check out my **Terraform Cheatsheet** for quick command references: [Terraform Cheatsheet](https://secsys.pages.dev/posts/tfcheat/)

