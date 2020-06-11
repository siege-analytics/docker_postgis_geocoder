up:
	docker-compose up -d

build:
	docker-compose stop
	docker-compose build && docker-compose up -d

# 1
prepare-database:
	docker-compose exec python \
		psql -f sql/prepare_database.sql

# 2

