IMAGE_NAME=butterfaces/quarkus-demo

docker-build-fast-jar:
	@echo "Remove docker image if already exists"
	docker rmi -f ${IMAGE_NAME}-fast-jar
	@echo "Build application"
	./mvnw package -Dquarkus.package.type=fast-jar
	@echo "Build fast-jar image"
	DOCKER_BUILDKIT=1 docker build -f src/main/docker/Dockerfile.fast-jar -t ${IMAGE_NAME}-fast-jar .

docker-run-fast-jar:
	docker run -i --rm -p 8080:8080 ${IMAGE_NAME}-fast-jar

docker-build-jvm:
	@echo "Remove docker image if already exists"
	docker rmi -f ${IMAGE_NAME}-jvm
	@echo "Build application"
	./mvnw package
	@echo "Build jvm image"
	DOCKER_BUILDKIT=1 docker build -f src/main/docker/Dockerfile.jvm -t ${IMAGE_NAME}-jvm .

docker-run-jvm:
	docker run -i --rm -p 8080:8080 ${IMAGE_NAME}-jvm

docker-build-native:
	@echo "Remove docker image if already exists"
	docker rmi -f ${IMAGE_NAME}-native
	@echo "Build application"
	./mvnw package -Pnative
	@echo "Build native image"
	DOCKER_BUILDKIT=1 docker build -f src/main/docker/Dockerfile.native -t ${IMAGE_NAME}-native .

docker-run-native:
	docker run -i --rm -p 8080:8080 ${IMAGE_NAME}-native

docker-build-scratch:
	@echo "Remove docker image if already exists"
	docker rmi -f ${IMAGE_NAME}-scratch
	@echo "Build native (scratch) image"
	DOCKER_BUILDKIT=1 docker build -f src/main/docker/Dockerfile.scratch -t ${IMAGE_NAME}-scratch .

docker-run-scratch:
	docker run -i --rm -p 8080:8080 ${IMAGE_NAME}-scratch

docker-remove-demo-images:
	docker rmi -f ${IMAGE_NAME}-fast-jar
	docker rmi -f ${IMAGE_NAME}-jvm
	docker rmi -f ${IMAGE_NAME}-native
	docker rmi -f ${IMAGE_NAME}-scratch

docker-remove-dangling:
	@echo "Remove dangling images"
	docker rmi -f $$(docker images --filter "dangling=true" -q --no-trunc)