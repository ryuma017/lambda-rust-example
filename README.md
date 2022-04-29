# Rust on AWS-Lambda
This repository is a example of AWS Lambda function written in Rust.

## Setup the cross-compilation environment
Add target for x86_64 Lambda functions:

```
$ rustup target add x86_64-unknown-linux-gnu
```

install `cargo-lambda`:

```
$ cargo install cargo-lambda
```

## Build for Amazon Linux 2 runtimes

```
$ cargo lambda build --release --target x86_64-unknown-linux-gnu
```

## Test

Start a local server that emulates the AWS Lambda control plane provided by `cargo-lambda`

```
$ cargo lambda start
```

Send requests to the control plane emulator

```
$ cargo lambda invoke --data-ascii '{"firstName: "ryuma017"}'
```

## Deploy with the SAM CLI
create a `template.yaml` file:

```yaml
AWSTemplateFormatVersion: '2010-09-09'
Transform: AWS::Serverless-2016-10-31

Resources:
  HelloWorldFunction:
    Type: AWS::Serverless::Function
    Properties:
      FunctionName: rust-lambda-test
      Architectures: ["x86_64"]
      Runtime: provided.al2
      Handler: bootstrap
      CodeUri: .
    Metadata:
      BuildMethod: makefile
```

create a `Makefile` file:

```makefile
build-HelloWorldFunction:
	cargo lambda build --release --target x86_64-unknown-linux-gnu
	cp ./target/lambda/bootstrap/bootstrap $(ARTIFACTS_DIR)
```

deploy:

```
$ sam deploy --guided
```
