# Frictionless IaC Demo

This repository contains the source code and CI/CD pipeline for the "Frictionless IaC" demonstration. It showcases how to integrate security, cost estimation, and visualization directly into the developer workflow for Infrastructure as Code (IaC).

The goal is to "shift-left" these critical checks, providing developers with immediate, actionable feedback within their pull requests. This approach helps catch issues early, reduces risk, and fosters a culture of accountability and collaboration.

## The "Frictionless" Workflow

This demo uses a single GitHub Actions workflow (`.github/workflows/iac-demo.yml`) to orchestrate three powerful open-source tools on every pull request against Terraform code:

1.  🛡️ **[Checkov](https://www.checkov.io/)**: Performs static analysis to find security vulnerabilities and misconfigurations.
2.  💰 **[Infracost](https://www.infracost.io/)**: Generates a cost estimate to show the financial impact of infrastructure changes.
3.  🗺️ **[Rover](https://im2nguyen.github.io/rover/)**: Creates an interactive visualization of the Terraform plan, making changes easier to understand.

When a pull request is opened, the workflow runs and posts the results as comments, giving developers and reviewers a comprehensive overview before merging.

![Frictionless IaC Workflow](https://user-images.githubusercontent.com/843981/236894717-9b4b8a7e-3bbf-4f9f-9a2c-8a5a0a8b8d1e.png)

## Repository Structure

```
infra-iac/
├── .github/
│   └── workflows/
│       └── iac-demo.yml      # The core GitHub Actions workflow
├── terraform/
│   ├── main.tf               # Sample Terraform configuration
│   └── ...
└── README.md
```

## Getting Started

To see the workflow in action, you can fork this repository and open a pull request with a change to any of the files in the `terraform/` directory.

### Prerequisites

- A GitHub account.
- An [Infracost API Key](https://www.infracost.io/docs/cloud_pricing/get_api_key/) (the free tier is sufficient). Add this as a repository secret named `INFRACOST_API_KEY`.

### Running the Demo

1.  **Fork this repository.**
2.  **Add the `INFRACOST_API_KEY` secret** to your forked repository's Settings > Secrets and variables > Actions.
3.  **Create a new branch** and make a change to `terraform/main.tf`. For example, you could change the machine type of a VM or add a new resource.
4.  **Push the branch and open a pull request.**

Once the pull request is open, the `iac-checks` workflow will trigger automatically. After a few minutes, you will see comments on your pull request from Checkov and Infracost, and a link to the Rover visualization will be available in the workflow summary artifacts.

## Presentation

This repository supports the "Frictionless Infrastructure: Transforming the IaC Experience" presentation. The slides can be viewed [here](https://anbazhagan-ramesh.github.io/infra-iac/presentation.html).

## License

This project is for personal learning and development purposes.
