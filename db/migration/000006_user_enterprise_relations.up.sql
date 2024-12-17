-- Agregar claves foráneas a la tabla "users"
ALTER TABLE "users"
  ADD COLUMN "enterprise_id" integer;

ALTER TABLE "users"
  ADD CONSTRAINT fk_enterprise FOREIGN KEY ("enterprise_id") REFERENCES "enterprise"("id");

-- Agregar claves foráneas a la tabla "enterprise"
ALTER TABLE "enterprise"
  ADD COLUMN "created_by" integer,
  ADD COLUMN "updated_by" integer,
  ADD COLUMN "deleted_by" integer;

ALTER TABLE "enterprise"
  ADD CONSTRAINT fk_created_by FOREIGN KEY ("created_by") REFERENCES "users"("id"),
  ADD CONSTRAINT fk_updated_by FOREIGN KEY ("updated_by") REFERENCES "users"("id"),
  ADD CONSTRAINT fk_deleted_by FOREIGN KEY ("deleted_by") REFERENCES "users"("id");
