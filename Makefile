NAME = inception

all: setup

setup:
	docker-compose -f srcs/docker-compose.yml up --build -d

clean:
	docker-compose -f srcs/docker-compose.yml down --volumes

fclean: clean
	sudo rm -rf /home/${USER}/data

re: fclean all
