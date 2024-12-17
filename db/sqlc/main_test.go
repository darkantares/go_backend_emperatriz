package db

import (
	"context"
	"log"
	"os"
	"testing"

	"github.com/jackc/pgx/v5/pgxpool"
)

const (
	dbSource = "postgresql://postgres:JrUH60jUA44F5Sgnp90hMgp3ELliTklrOwoKzcP@127.0.0.1:5432/emperatriz?sslmode=disable"
)

var testQueries *Queries

func TestMain(m *testing.M) {
	// Crear un pool de conexiones usando pgx
	connPool, err := pgxpool.New(context.Background(), dbSource)
	if err != nil {
		log.Fatal("cannot connect to database:", err)
	}
	defer connPool.Close()

	testQueries = New(connPool)

	os.Exit(m.Run())
}
