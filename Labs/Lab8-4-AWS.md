# Lab 8-4 AWS  - Remote Backends

---


### Overview

In this lab, you will implement a S3 remote state backend

Once you are finished this lab, you will have the option of using the bucket you set up for all the rest of your work or continue using a local back end


### Step One - Creating the S3 bucked

There are two directories used that represent the two deployments

- There one labelled `backend` has the code to set up the S3 remote backend.  
- The other, labelled `root`, contains an EC2 instance resource that will use the S3 backend

Go into the backend directory
- In the s3 bucket definition, you need to supply a unique name for the bucket.
- In production, we would enable both `versioning` and `prevent-delete`, but this just makes it harder to clean up after the lab, so disable them for the lab.
- You also need to provide a unique name for the lock table
- Once this is done, run `terraform apply` and then confirm at the console that the bucket was created

```terraform
resource "aws_s3_bucket" "zippy" {
  bucket = "terraform-zippy-backend-state-883938"

  # Prevent accidental deletion of this S3 bucket
  # This is commented out for the lab because this will block terraform prevent_destroy
  
 # lifecycle {
 #   prevent_destroy = true 
 # }

  # Enable versioning so we can see the full revision history of our
  # state files
  versioning {
    enabled = true  # set to false in the lab
  }

  # Enable server-side encryption by default
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_dynamodb_table" "state-locks" {
  name         = "zippy-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

output "s3_bucket_arn" {
  value       = aws_s3_bucket.zippy.arn
  description = "The ARN of the S3 bucket"
}

output "dynamodb_table_name" {
  value       = aws_dynamodb_table.state-locks.name
  description = "The name of the DynamoDB table"
}
 
```
This is the deployment for the backend. This code should never appear in any other deployment that uses the back end otherwise a recursive loop will happen.


### Step Two - Using the s3 backend

The `root` directory represents a deployment that uses the remote back end just defined

In the `*providers.tf` the remote back end is specified

```terraform 
terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = ">= 3.0"
        }     
    }
    # Required version of terraform
    required_version = ">0.14"
      
}

terraform {
     backend "s3" {
        # Replace this with your bucket name!
        bucket         = "terraform-zippy-backend-state-883938"
        key            = "myproj/terraform.tfstate"
        region         = "us-east-1"

        # Replace this with your DynamoDB table name!
        dynamodb_table = "zippy-locks"
        encrypt        = true
  }
} 

provider aws {
    region = "us-east-1"
}
```

Ensure the names of the locktable and bucket are the same as the ones you created in step one

Replace "myproj" with your own key value. This is used in the bucket to uniquely identify the state for this module

Run `terraform init`

Examine the bucket to see your state file

The `main.tf` file is exactly what we have seen before

```terraform 

resource "aws_instance" "myVM" {
    ami = "ami-0c101f26f147fa7fd"
    instance_type = "t2.micro"
    tags = {
        Name = "MyVM"
    }
}

```

Run `terraform apply` and confirm the deployment



## Step Three - Reverting to a local back end

To stop using the S3 backend, remove the backend code from the providers.tf file in the code directory

Run `terraform init -migrate-state` and Terraform will transfer the state files down to your local directory

Confirm that there are now local state files

### Step Four - Clean up the resources

You can skip this step if you want to continue using your remote backend.

Go to the S3 console and delete the contents of your bucket. Terraform cannot delete the bucket unless it is empty.

Run terraform destroy in the backend directory to remove the remote backend bucket and lock table

### Done
