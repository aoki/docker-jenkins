name = jenkins
user = ringo

# Build Container
build:
	docker build -t $(user)/$(name) .
.PHONY: build

# Publish Container
push:
	docker login -u $${DOCKER_HUB_USER} -p $${DOCKER_HUB_PASSWORD} && docker push $(user)/$(name)
.PHONY: push

# Run Container
run:
	docker run --rm -v /var/run/docker.sock:/var/run/docker.sock -p 8080:8080 -p 50000:50000 --name jenkins -d -u root $(user)/$(name)
.PHONY: run

# Stop container
stop:
	docker stop jenkins
.PHONY: stop

# Login container
login:
	docker exec -it jenkins /bin/bash
.PHONY: login

# Display log
log:
	docker logs -f jenkins
.PHONY: log
