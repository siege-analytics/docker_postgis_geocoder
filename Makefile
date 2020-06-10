up:
	docker-compose up -d

build:
	docker-compose stop
	docker-compose build && docker-compose up -d

# 1
ensure-paths:
	docker-compose exec python \
		python3 python/ensure_paths.py

# 2
fetch-census:
	docker-compose exec python \
		python3 python/fetch_census.py

# 3
load-census:
	docker-compose exec python \
		python3 python/load_census.py

# 4
load-voters:
	docker-compose exec python \
		python3 python/load_voters.py

# 4
run-jobs:
	docker-compose exec python \
		python3 run_jobs.py

# 5
export-shapefiles:
	docker-compose exec python \
		python3 export_results.py

# Shouldn't be required
make-folders:
	mkdir -p data/census/county
	mkdir -p data/census/cd
	mkdir -p data/census/sldl
	mkdir -p data/census/sldu
	mkdir -p data/census/tabblock