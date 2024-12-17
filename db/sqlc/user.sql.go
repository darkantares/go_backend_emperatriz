// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.27.0
// source: user.sql

package db

import (
	"context"
)

const createUser = `-- name: CreateUser :one
INSERT INTO users (
  username,
  password,
  full_name,
  email
) VALUES (
  $1, $2, $3, $4
) RETURNING id, "is_authenticated", email, password, phone, full_name, username, password_changed_at, info_table_id, enterprise_id
`

type CreateUserParams struct {
	Username string `json:"username"`
	Password string `json:"password"`
	FullName string `json:"full_name"`
	Email    string `json:"email"`
}

func (q *Queries) CreateUser(ctx context.Context, arg CreateUserParams) (User, error) {
	row := q.db.QueryRow(ctx, createUser,
		arg.Username,
		arg.Password,
		arg.FullName,
		arg.Email,
	)
	var i User
	err := row.Scan(
		&i.ID,
		&i.IsAuthenticated,
		&i.Email,
		&i.Password,
		&i.Phone,
		&i.FullName,
		&i.Username,
		&i.PasswordChangedAt,
		&i.InfoTableID,
		&i.EnterpriseID,
	)
	return i, err
}

const getUser = `-- name: GetUser :one
SELECT id, "is_authenticated", email, password, phone, full_name, username, password_changed_at, info_table_id, enterprise_id FROM users
WHERE email = $1 LIMIT 1
`

func (q *Queries) GetUser(ctx context.Context, email string) (User, error) {
	row := q.db.QueryRow(ctx, getUser, email)
	var i User
	err := row.Scan(
		&i.ID,
		&i.IsAuthenticated,
		&i.Email,
		&i.Password,
		&i.Phone,
		&i.FullName,
		&i.Username,
		&i.PasswordChangedAt,
		&i.InfoTableID,
		&i.EnterpriseID,
	)
	return i, err
}