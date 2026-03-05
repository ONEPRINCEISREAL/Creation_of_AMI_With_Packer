# Creation of Custom AMI using Packer

##  Project Overview

This project demonstrates how to create a **custom Amazon Machine Image (AMI)** using **HashiCorp Packer** on AWS.
The AMI is built automatically by launching a temporary EC2 instance, provisioning it with required software, and then creating a reusable machine image.

In this project, an **Ubuntu-based AMI** is created with **Nginx installed automatically** using a Packer shell provisioner.

---

#  Technologies Used

* **HashiCorp Packer**
* **AWS EC2**
* **Ubuntu Server 20.04**
* **Nginx**
* **HCL (HashiCorp Configuration Language)**
* **Git & GitHub**

---

# 📁 Project Structure

```
Custom_AMI_Packer
│
├── ami-Creation
│   ├── aws-ubuntu.pkr.hcl
│   ├── variables.pkr.hcl
│   ├── devvariables.pkrvars.hcl
│   └── prodvariables.pkrvars.hcl
│
├── .gitignore
└── README.md
```

---

#  Packer Template Explanation

### aws-ubuntu.pkr.hcl

Defines the configuration for building the AMI.

Key components:

* **Builder (amazon-ebs)** → Launches a temporary EC2 instance
* **Source AMI filter** → Finds the latest Ubuntu AMI
* **Provisioner** → Installs Nginx automatically
* **Subnet configuration** → Specifies where the EC2 instance will launch

Example provisioner used:

```
provisioner "shell" {
  inline = [
    "echo Installing Updates",
    "sudo apt-get update -y",
    "sudo apt-get install -y nginx"
  ]
}
```

---

#  Variables Configuration

### variables.pkr.hcl

Defines reusable variables for the Packer template:

* AMI name
* Instance type
* AWS region
* SSH username

---

### devvariables.pkrvars.hcl

Used for **development AMI builds**.

Example:

```
ami_name = "dev-packer-linux-aws-ubuntu"
instance_type = "t2.micro"
region = "ap-south-1"
ssh_username = "ubuntu"
```

---

### prodvariables.pkrvars.hcl

Used for **production AMI builds**.

Example:

```
ami_name = "prod-packer-linux-aws-ubuntu"
instance_type = "t2.micro"
region = "ap-south-1"
ssh_username = "ubuntu"
```

---

#  How the AMI Build Works

Packer performs the following steps:

1. Authenticate with AWS
2. Launch a temporary EC2 instance
3. Connect using SSH
4. Run provisioning scripts
5. Install Nginx
6. Create a custom AMI
7. Terminate the temporary instance

---

#  How to Run the Project

### Initialize Packer plugins

```
packer init .
```

### Validate the template

```
packer validate .
```

### Build AMI using development variables

```
packer build -var-file="devvariables.pkrvars.hcl" .
```

### Build AMI using production variables

```
packer build -var-file="prodvariables.pkrvars.hcl" .
```

---

#  Output

After the build completes successfully:

* A **new AMI will be created in AWS**
* The temporary EC2 instance will be terminated
* The AMI can be used to launch new EC2 instances with **Nginx pre-installed**

---

#  Example Output

```
amazon-ebs: AMI created: ami-xxxxxxxxxxxx
```

You can view the AMI in:

```
AWS Console → EC2 → AMIs
```

---

#  Key Benefits of Using Packer

* Automates AMI creation
* Ensures consistent environments
* Reduces manual configuration
* Supports Infrastructure as Code (IaC)

---

#  Author

**Prince Singh Chauhan**

Cloud & DevOps Enthusiast
Focused on AWS, DevOps tools, and Infrastructure Automation.

---
