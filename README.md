# infra-iac

Infrastructure as Code (IaC) repository for provisioning and managing cloud infrastructure.

## Overview

This repository contains infrastructure definitions managed as code, enabling repeatable, version-controlled, and automated provisioning of cloud resources.

## Repository Structure

```
infra-iac/
├── modules/        # Reusable infrastructure modules
├── environments/   # Environment-specific configurations (dev, staging, prod)
├── scripts/        # Helper and automation scripts
└── README.md
```

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/downloads) >= 1.0
- Cloud provider CLI (e.g., AWS CLI, Azure CLI, or gcloud)
- Appropriate credentials configured for your target cloud environment

## Getting Started

1. **Clone the repository**
   ```bash
   git clone https://github.com/Anbazhagan-Ramesh/infra-iac.git
   cd infra-iac
   ```

2. **Initialize Terraform**
   ```bash
   terraform init
   ```

3. **Review the plan**
   ```bash
   terraform plan
   ```

4. **Apply the changes**
   ```bash
   terraform apply
   ```

## Environments

| Environment | Description              |
|-------------|--------------------------|
| `dev`       | Development environment  |
| `staging`   | Pre-production testing   |
| `prod`      | Production environment   |

## Branching Strategy

| Branch    | Purpose                              |
|-----------|--------------------------------------|
| `main`    | Stable, production-ready code        |
| `develop` | Integration branch for new features  |
| `feature/*` | Individual feature development     |

## Contributing

1. Create a feature branch from `main`
2. Make your changes and test locally
3. Open a Pull Request against `main`
4. Ensure all checks pass before merging

## License

This project is for personal learning and development purposes.
