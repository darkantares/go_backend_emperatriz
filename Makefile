DB_PASSWORD=JrUH60jUA44F5Sgnp90hMgp3ELliTklrOwoKzcP
DB_URL=postgresql://postgres:"${DB_PASSWORD}"@127.0.0.1:5432/emperatriz?sslmode=disable
DB_CONTAINER_NAME=go_backend_emperatriz
DB_USER=postgres
DB_NAME=emperatriz
SEED_FILE=db/seed/seeds.sql

postgres:
	docker run --name go_backend_emperatriz -p 5432:5432 -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD="${DB_PASSWORD}" -d postgres:latest

createdb:
	docker exec -it go_backend_emperatriz createdb --username=postgres --owner=postgres emperatriz

dropdb:
	docker exec -it go_backend_emperatriz dropdb: --username=postgres emperatriz

migrateup: 
	migrate --path db/migration --database "${DB_URL}" --verbose up

migratedown: 
	migrate --path db/migration --database "${DB_URL}" --verbose down

migrateup1:
	migrate -path db/migration -database "$(DB_URL)" -verbose up 1

migratedown1:
	migrate -path db/migration -database "$(DB_URL)" -verbose down 1

sqlc:
	sqlc generate

server:
	go run main.go

mock:
	mockgen -package mockdb -destination db/mock/store.go github.com/darkantares/go_backend_emperatriz/db/sqlc Store
	
run_seeds:
	@echo "Seeding enterprises..."
	docker exec -i $(DB_CONTAINER_NAME) psql -U $(DB_USER) -d $(DB_NAME) < $(SEED_FILE)
	@echo "Seed data inserted successfully!"

.PHONY: postgres createdb dropdb migrateup migratedown sqlc server migrateup1 migratedown1 run_seeds