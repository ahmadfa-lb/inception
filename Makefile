NAME = inception

all: setup

setup:
	mkdir -p /home/afarachi/data/mariadb
	mkdir -p /home/afarachi/data/wordpress
	docker-compose -f srcs/docker-compose.yml up --build -d

clean:
	docker-compose -f srcs/docker-compose.yml down --volumes

fclean:
	docker-compose -f srcs/docker-compose.yml down --rmi all --volumes --remove-orphans
	docker system prune -a --volumes -f
	sudo rm -rf /home/afarachi/data/mariadb
	sudo rm -rf /home/afarachi/data/wordpress

show_all:
	docker images
	@echo "\n======================================\n"
	docker container ls
	@echo "\n======================================\n"
	docker network ls
	@echo "\n======================================\n"
	docker volume ls

re: fclean all
