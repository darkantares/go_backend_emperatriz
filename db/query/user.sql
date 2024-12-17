-- name: CreateUser :one
INSERT INTO "users" (
  "is_authenticated", "email", "password", "phone", "full_name", 
  "username", "password_changed_at", "status", "removable", 
  "editable", "is_visible", "default", "created_at", "created_by", 
  "updated_at", "updated_by", "deleted_at", "deleted_by", "enterprise_id"
) 
VALUES (
  $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18
)
RETURNING *;

-- name: GetUser :one
SELECT * FROM users
WHERE email = $1 LIMIT 1;

-- name: UpdateUser :one
UPDATE users
SET
  password = COALESCE(sqlc.narg(password), password),
  password_changed_at = COALESCE(sqlc.narg(password_changed_at), password_changed_at),
  full_name = COALESCE(sqlc.narg(full_name), full_name),
  email = COALESCE(sqlc.narg(email), email),
  is_email_verified = COALESCE(sqlc.narg(is_email_verified), is_email_verified)
WHERE
  username = sqlc.arg(username)
RETURNING *;

-- name: UpdateUser :one
UPDATE "users"
SET 
  "is_authenticated" = COALESCE($1, "is_authenticated"),
  "email" = COALESCE($2, "email"),
  "password" = COALESCE($3, "password"),
  "phone" = COALESCE($4, "phone"),
  "full_name" = COALESCE($5, "full_name"),
  "username" = COALESCE($6, "username"),
  "password_changed_at" = COALESCE($7, "password_changed_at"),
  "status" = COALESCE($8, "status"),
  "removable" = COALESCE($9, "removable"),
  "editable" = COALESCE($10, "editable"),
  "is_visible" = COALESCE($11, "is_visible"),
  "default" = COALESCE($12, "default"),
  "updated_at" = COALESCE($13, "updated_at"),
  "updated_by" = COALESCE($14, "updated_by"),
  "deleted_at" = COALESCE($15, "deleted_at"),
  "deleted_by" = COALESCE($16, "deleted_by"),
  "enterprise_id" = COALESCE($17, "enterprise_id")
WHERE 
  "id" = $18
RETURNING *;


-- name: DeleteUser :one
UPDATE "users"
SET 
  "status" = false,  -- Asumiendo que 'Deleted' es el estado para marcar un usuario como eliminado
  "deleted_at" = now(),
  "deleted_by" = $1  -- El ID del usuario que realiza la eliminación
WHERE 
  "id" = $2
RETURNING *;
