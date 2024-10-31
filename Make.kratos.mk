
kratos-build:
	# cd ory-kratos && docker build -f .docker/Dockerfile-build -t local/ory-kratos:latest ${PLATFORM_OPTS} .
	docker compose -f compose.yml build --no-cache

kratos-push:
	# docker tag local/ory-kratos:latest scriptonbasestar/ory-kratos:latest
	# docker push scriptonbasestar/ory-kratos:latest
	docker push scriptonbasestar/kratos-selfservice-ui-node

kratos-down:
	docker compose -f compose.yml down -v

kratos-up:
	# docker compose -f compose-standalone.yml up --build --force-recreate
	docker compose -f compose.yml up
