# git stash
# git checkout dev
git pull
cp .env.example .env
docker compose down
docker compose build app
docker compose up -d
docker compose exec app rm -rf vendor composer.lock
docker compose exec app composer install
docker compose exec app php artisan key:generate
docker compose exec app php artisan storage:link || true

docker compose exec app chmod -R 777 ./storage/ &&\
chmod -R 775 . &&\
chown -R www-data:www-data . &&\
chmod -R 777 ./storage/ &&\
semanage fcontext -a -t httpd_sys_rw_content_t './bootstrap/cache(/.*)?' || true &&\
semanage fcontext -a -t httpd_sys_rw_content_t './storage(/.*)?' || true &&\
restorecon -Rv '.' || true