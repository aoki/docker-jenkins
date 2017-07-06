# Build Container
build:
	docker build -t ringo/jenkins .
.PHONY: build

# Publish Container
push:
	docker login -u $${DOCKER_HUB_USER} -p $${DOCKER_HUB_PASSWORD} && docker push ringo/jenkins
.PHONY: push

# Run Container
run:
	docker run --rm -v /var/run/docker.sock:/var/run/docker.sock -v /var/lib/jenkins:/var/jenkins_home -p 8080:8080 -p 50000:50000 --name jenkins -d -u root aoki/jenkins
.PHONY: run

# Login container
login:
	docker exec -it jenkins /bin/bash
.PHONY: login

# Display log
log:
	docker logs -f jenkins
.PHONY: log
