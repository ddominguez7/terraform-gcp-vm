# Deploy Cost-Effective Spot Instances for Testing Environments in GCP with Terraform

### Objectives

- **Infrastructure as Code with Terraform**: Automate the creation and configuration of infrastructure.
- **Custom VM Deployment**: Set up a VM instance tailored for testing with the required features.
- **Tool and Application Installation**: Pre-install all necessary tools and applications efficiently.
- **Instance Removal**: Ensure easy removal of the instance to optimize resource usage and minimize costs.

### What is a Spot Instance?

Spot instances are low-cost virtual machines offered by cloud providers like GCP, AWS, and Azure. They are ideal for fault-tolerant workloads and can be significantly cheaper than on-demand instances.

**Key Features:**
- **Cost Savings**: Up to 70-90% cheaper than on-demand instances.
- **Variable Availability**: Based on demand and supply.
- **Interruption Notice**: Short notice reclaim by the provider (e.g., 2-minute warning).
- **Ideal Use Cases**: Batch processing, big data analysis, scientific computing, rendering, financial modeling, and more.
- **Pricing and Bidding**: Fluctuates based on market conditions, with the option to set a maximum price.
- **Service Integration**: Compatible with auto-scaling, container orchestration, etc.

### Directory Structure

```plaintext
terraform-gcp-vm/
├── provider.tf
├── variables.tf
├── vm.tf
├── output.tf
└── configs/
    └── startup.sh
```

With the following configuration in the variables, you can create any number of instances with different characteristics, as the code is being reused for efficient use.

```plaintext
vm = {
  vm_01 = {
    name         = "vm-laboratory"
    machine_type = "custom-1-2048"
    boot_disk = {
      initialize_params = {
        image = "ubuntu-os-cloud/ubuntu-2204-lts"
        size  = 15
        type  = "pd-standard"
      }
    }
    network_interface = {
      network = "default"
    }
    scheduling = {
      preemptible        = true
      automatic_restart  = false
      provisioning_model = "SPOT"
    }
    tags                      = ["ansible", "infrastructure", "ssh", "docker"]
    allow_stopping_for_update = true
    desired_status            = "RUNNING"
  }
  vm_02 = {
	  //.......
  }
  vm_03 = {
	  //.......
  }
}

GOOGLE_CREDENTIALS = "service-account.json"
```
