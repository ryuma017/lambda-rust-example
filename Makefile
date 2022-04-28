build-HelloWorldFunction:
	cargo lambda build --release --target x86_64-unknown-linux-gnu
	cp ./target/lambda/bootstrap/bootstrap $(ARTIFACTS_DIR)