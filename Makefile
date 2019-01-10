build:
	docker-compose -f docker-compose.yml build

up:
	docker-compose -f docker-compose.yml -f docker-compose.binding.yml up -d

up-codeigniter:
	docker-compose -f docker-compose.yml -f docker-compose.binding.yml up -d
	sh setup.sh	
