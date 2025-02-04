# Lab 0: Set Up

## Cloud Accounts

It is assumed that everyone will have their own cloud accounts, either their own personal AWS accounts or employee accounts provided by IBM.

If you need to get your own AWS or Google cloud accounts, go to the respective home pages for the services and follow the instructions. For both services, you will need to provide a credit card. You will receive a number of credits for opening a new accounts which will offset any costs you incur in the first year of use up to the amount of the credits.

In addition, certain services may be free within certain limits. AWS call these "free tier eligible".

#### Aws Free Tier Account

[Aws Signup Page](https://aws.amazon.com/free)

![](images/01%20AWS%20Signup.png?raw=true)


---

## Using the CLI Tools

This will be the approach that the instructor will be using in class.

This requires installing and configuring the CLI tools

#### AWS CLI

To install the CLI for AWS, refer to the documentation here:

[AWS CLI Installation](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

Confirm that the CLI is installed:

```console 
$ aws --version
aws-cli/2.15.26 Python/3.11.8 Linux/6.7.7-200.fc39.x86_64 exe/x86_64.fedora.39 prompt/off
```

Once the CLI is installed, you need to create an API key for youself in the IAM services.


#### Access keys

To create an access key, go to the `IAM` console in AWS

![](images/IAMCOnsole.png?raw=true)

Select the users option and select the user you want to generate the key for and go to the `security credentials tab`

![](images/IAMUser.png?raw=true)

Scroll down until you find the `Access Key` section

![](images/AccessKey1.png?raw=true)

Select `Create Key` and the `Command line Access" option on the dialogue box.

![](images/AccessKey2.png?raw=true)

Check the confirmation checkbox at the bottom and select `next`

Add an optional tag and then select `Create access key`

Download the `*csv` file. And then select `Done`

![](images/AccessKey3.png?raw=true)
 
The file will have a Key Id and the key itself (key truncated in image)




#### Installing the key

Now the key needs to installed in a config file.

Use the `aws configure` command to create the credentials file using the values from the file you downloaded.

```

Test it out by trying  `aws account list-regions`

```console
$ aws account list-regions
{
    "Regions": [
        {
            "RegionName": "af-south-1",
            "RegionOptStatus": "DISABLED"
        },
        {
            "RegionName": "ap-east-1",
            "RegionOptStatus": "DISABLED"
        },

```