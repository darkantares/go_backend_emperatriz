package main

import (
	"context"
	"log"

	"github.com/darkantares/go_backend_emperatriz/api"
	db "github.com/darkantares/go_backend_emperatriz/db/sqlc"
	"github.com/darkantares/go_backend_emperatriz/util"
	"github.com/jackc/pgx/v5/pgxpool"
)

func main() {
	config, err := util.LoadConfig(".")
	if err != nil {
		log.Fatal("cannot load config")
	}

	connPool, err := pgxpool.New(context.Background(), config.DBSource)
	if err != nil {
		log.Fatal("cannot connect to database:", err)
	}

	store := db.NewStore(connPool)

	server, err := api.NewServer(config, store)
	if err != nil {
		log.Fatal("cannot create server", err)
	}

	err = server.Start(config.HTTPServerAddress)
	if err != nil {
		log.Fatal("cannot star server", err)
	}
}
