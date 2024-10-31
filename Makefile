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
	# cd ory-kratos && docker-compose -f quickstart.yml -f quickstart-standalone.yml -f quickstart-latest.yml $(QUICKSTART_OPTIONS) up --build --force-recreate
	docker compose -f compose-dev.yml build --no-cache

kratos-push:
	# docker tag local/ory-kratos:latest scriptonbasestar/ory-kratos:latest
	# docker push scriptonbasestar/ory-kratos:latest
	docker push scriptonbasestar/kratos-selfservice-ui-node

kratos-down:
	docker compose -f compose-dev.yml down -v

kratos-up:
	docker compose -f compose-dev.yml up
