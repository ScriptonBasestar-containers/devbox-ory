PLATFORM_OPTS := --platform linux/amd64,linux/arm64

.PHONY: docker-builder-setup
docker-builder-setup:
	docker buildx create --use --platform=linux/arm64,linux/amd64 --name multi-platform-builder
	docker buildx inspect --bootstrap

prepare: docker-builder-setup
	git clone https://github.com/ory/kratos.git ory-kratos
	git clone https://github.com/ScriptonBasestar-containers/ory-kratos-selfservice-ui-react-nextjs.git
	git clone https://github.com/ScriptonBasestar-containers/ory-kratos-selfservice-ui-node.git

kratos-build:
	# cd ory-kratos && docker build -f .docker/Dockerfile-build -t local/ory-kratos:latest ${PLATFORM_OPTS} .
	docker compose -f compose-standalone.yml build --no-cache

kratos-push:
	# docker tag local/ory-kratos:latest scriptonbasestar/ory-kratos:latest
	# docker push scriptonbasestar/ory-kratos:latest
	docker push scriptonbasestar/kratos-selfservice-ui-node

kratos-down:
	docker compose -f compose-standalone.yml down -v

kratos-up:
	# docker compose -f compose-standalone.yml up --build --force-recreate
	docker compose -f compose-standalone.yml up
