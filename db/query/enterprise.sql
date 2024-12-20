-- name: CreateEnterprise :one
-- name: CreateEnterprise :one
INSERT INTO "enterprise" (
  "title", 
  "phone", 
  "email", 
  "contact", 
  "contact_phone", 
  "files", 
  "address", 
  "web", 
  "is_authenticated",
  "status",
  "removable",
  "editable",
  "is_visible",
  "default",
  "created_at", 
  "created_by"
)
VALUES (
  $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, now(), $15
)
RETURNING *;


-- name: ListEnterprises :many
SELECT * FROM "enterprise";

-- name: GetEnterprise :one
SELECT * 
FROM "enterprise"
WHERE "id" = $1;

-- name: UpdateEnterprise :one
UPDATE "enterprise"
SET 
  "title" = COALESCE($1, "title"),
  "phone" = COALESCE($2, "phone"),
  "email" = COALESCE($3, "email"),
  "contact" = COALESCE($4, "contact"),
  "contact_phone" = COALESCE($5, "contact_phone"),
  "files" = COALESCE($6, "files"),
  "address" = COALESCE($7, "address"),
  "web" = COALESCE($8, "web"),
  "is_authenticated" = COALESCE($9, "is_authenticated"),
  "status" = COALESCE($10, "status"),
  "removable" = COALESCE($11, "removable"),
  "editable" = COALESCE($12, "editable"),
  "is_visible" = COALESCE($13, "is_visible"),
  "default" = COALESCE($14, "default"),
  "updated_at" = now(),
  "updated_by" = COALESCE($15, "updated_by")
WHERE 
  "id" = $16
RETURNING *;


-- name: DeleteEnterprise :one
UPDATE "enterprise"
SET 
  "status" = false,
  "deleted_at" = now(),
  "deleted_by" = $1
WHERE 
  "id" = $2
RETURNING *;
