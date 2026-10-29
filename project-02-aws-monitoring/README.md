# Project 2 — AWS EC2 Monitoring and Incident Alerting

## Goal
Demonstrate an infrastructure monitoring workflow using CloudWatch CPU metrics, an alarm, and an SNS email notification.

## Architecture
EC2 instance → CloudWatch CPUUtilization alarm → SNS topic → email subscription

The template creates:
- A small EC2 instance (AMI ID is supplied by the deployer)
- An SNS topic
- An email subscription (requires confirmation)
- A CloudWatch CPU alarm

## Before deploying
1. Use a personal AWS sandbox/account only.
2. Confirm the AMI ID is valid in the selected region and compatible with the instance type.
3. Review EC2, EBS, CloudWatch, and SNS charges and your current Free Tier/credits.
4. Create a billing alert. It will notify you but will not automatically stop resources.
5. Choose a region and an AMI you are authorized to use.
6. Do not open inbound SSH in this template; use an approved access method such as Systems Manager where configured, or adapt it carefully for a tightly restricted lab.

## Deploy
```bash
aws cloudformation validate-template --template-body file://template.yaml

aws cloudformation create-stack \
  --stack-name portfolio-ec2-monitoring \
  --template-body file://template.yaml \
  --parameters \
    ParameterKey=ImageId,ParameterValue=ami-REPLACE_WITH_VALID_AMI \
    ParameterKey=NotificationEmail,ParameterValue=you@example.com \
  --capabilities CAPABILITY_IAM
```

Wait for the SNS subscription confirmation email and confirm it. Then inspect the CloudWatch alarm in the AWS console.

**Note:** Replace the placeholder AMI ID with a valid AMI for your chosen region. This starter template intentionally does not create an SSH ingress rule or an instance role. Add Systems Manager permissions and connectivity only if you understand and need them.

## Validate
- [ ] Stack reaches `CREATE_COMPLETE`.
- [ ] Confirm SNS email subscription.
- [ ] Inspect the alarm metric, threshold, evaluation period, and missing-data behavior.
- [ ] For a controlled test, temporarily lower the threshold and use an approved load test; restore the threshold afterward.
- [ ] Capture sanitized screenshots of the alarm state and notification.
- [ ] Delete the stack after testing.

## Cleanup
```bash
aws cloudformation delete-stack --stack-name portfolio-ec2-monitoring
aws cloudformation wait stack-delete-complete --stack-name portfolio-ec2-monitoring
```

Check the CloudFormation stack and AWS billing console to confirm all resources were removed. Manually created or retained resources may need separate cleanup.

## Interview / client talking points
- Why alert on CPU rather than only checking whether an instance is running?
- What do evaluation periods and datapoints-to-alarm control?
- How would you reduce noisy alerts?
- How would you route alerts to email, chat, or an incident management platform?
- What is the difference between detection, notification, diagnosis, and remediation?
