PLATFORM_OPTS := --platform linux/amd64,linux/arm64

.PHONY: docker-builder-setup
docker-builder-setup:
	docker buildx create --use --platform=linux/arm64,linux/amd64 --name multi-platform-builder
	docker buildx inspect --bootstrap

docker-builder-teardown:
	docker buildx rm multi-platform-builder

setup: docker-builder-setup
	git clone https://github.com/ory/kratos.git ory-kratos
	git clone https://github.com/ScriptonBasestar-containers/ory-kratos-selfservice-ui-react-nextjs.git
	git clone https://github.com/ScriptonBasestar-containers/ory-kratos-selfservice-ui-node.git

teardown: docker-builder-teardown
	rm -rf ory-kratos
	rm -rf ory-kratos-selfservice-ui-react-nextjs
	rm -rf ory-kratos-selfservice-ui-node

include Make.kratos.mk
