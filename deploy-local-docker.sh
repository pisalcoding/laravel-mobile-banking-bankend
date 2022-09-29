# This is the starting point for deployment
# Run bash deploy.sh to deploy/update application
# Feel free to modify the script
cp .env.example.docker.local .env
docker compose down app
docker volume rm laravel-mobile-banking-bankend_mysql-data
docker compose -f docker-compose-local.yml build app
docker compose up app -d
