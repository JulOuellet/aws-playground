### Docker

To run the `docker-compose.yml` file and start localstack:
```
$ docker-compose up
```

### Localstack

These commands must be executed inside the docker in which localstack is running. The container can be accessed by running:
```
$ docker exec -it {container-id} bash
```

- To list S3 buckets:
```
# awslocal s3 ls
```

- To list lambda functions:
```
# awslocal lambda list-functions
```

- To run a lambda function:
```
# awslocal lambda invoke --function-name {function-name} output.json
```

This would run the lambda function and print the output to a file called output.json.

### Terraform

***All commands must be executed in the terraform directory at the root of the project.***

- To initialize the terraform directory (must be run at least once):
```
$ terraform init
```

- To see a preview of the changes that have been made in the configuration:
```
$ terraform plan
```

- To apply the changes shown by the plan:
```
$ terraform apply -auto-approve
```
