-- name: CreateEnterprise :one
-- name: CreateEnterprise :one
INSERT INTO "enterprise" (
  "title", 
  "document_verification", 
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
  $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, now(), $16
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
  "document_verification" = COALESCE($2, "document_verification"),
  "phone" = COALESCE($3, "phone"),
  "email" = COALESCE($4, "email"),
  "contact" = COALESCE($5, "contact"),
  "contact_phone" = COALESCE($6, "contact_phone"),
  "files" = COALESCE($7, "files"),
  "address" = COALESCE($8, "address"),
  "web" = COALESCE($9, "web"),
  "is_authenticated" = COALESCE($10, "is_authenticated"),
  "status" = COALESCE($11, "status"),
  "removable" = COALESCE($12, "removable"),
  "editable" = COALESCE($13, "editable"),
  "is_visible" = COALESCE($14, "is_visible"),
  "default" = COALESCE($15, "default"),
  "updated_at" = now(),
  "updated_by" = COALESCE($16, "updated_by")
WHERE 
  "id" = $17
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
