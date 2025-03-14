
🏗️ Inception

📖 Overview
Inception is a project from the 42 curriculum focused on creating a secure and scalable containerized environment using Docker and Docker Compose. The goal is to set up a multi-service infrastructure that includes a WordPress site served over HTTPS and managed with a reverse proxy.

🚀 Features
✅ Dockerized environment using Docker Compose  
✅ Reverse proxy with NGINX  
✅ Secure HTTPS connection using SSL/TLS  
✅ WordPress site configured with a MySQL database  
✅ Persistent storage for data integrity across container restarts  
✅ Scalable architecture with container orchestration  

🏗️ Project Structure
inception/
├── srcs/
│   ├── nginx/             # NGINX configuration files
│   ├── wordpress/         # WordPress setup and configuration
│   ├── mariadb/           # MariaDB setup and configuration
│   ├── Dockerfile         # Dockerfile for building the container
├── .env                   # Environment variables
├── docker-compose.yml     # Docker Compose configuration
└── README.md              # Project documentation

🛠️ Setup and Usage
1. Clone the Repository:
git clone https://github.com/ahmadfa-lb/inception.git
cd inception

2. Create a .env file:
DOMAIN_NAME=xxxxxx.42.fr
MYSQL_HOSTNAME=mariadb
MYSQL_ROOT_PASSWORD=root@123
MYSQL_DATABASE=wordpress
MYSQL_USER=myname
MYSQL_PASSWORD=pass123@
NGINX_PORT=443
MYSQL_PORT=3306
MYSQL_ADDRESS=0.0.0.0

WP_ADMIN=tryagain
WP_ADMIN_PASSWORD=tryagain12345@
WP_ADMIN_EMAIL=xxxx@email.com

WP_USER_EMAIL=xxxx@email.com

3. Build and Start the Containers:
docker-compose up --build

4. Access the WordPress Site:
- Open your browser and visit:  
  👉 https://xxxxx.42.fr

🧪 Testing and Debugging
- To view running containers:
docker ps

- To stop all containers:
run: make setup

- To check logs:
docker-compose logs -f

🏆 Achievements
- Learned how to set up a secure Dockerized environment  
- Gained hands-on experience with container orchestration  
- Configured NGINX as a reverse proxy for HTTPS  

