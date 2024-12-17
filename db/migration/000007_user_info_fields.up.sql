ALTER TABLE "users"
  ADD COLUMN "created_by" integer;

ALTER TABLE "users"
  ADD COLUMN "updated_by" integer;

ALTER TABLE "users"
  ADD COLUMN "deleted_by" integer;

ALTER TABLE "users"
  ADD CONSTRAINT fk_created_by FOREIGN KEY ("created_by") REFERENCES "users" ("id"),
  ADD CONSTRAINT fk_updated_by FOREIGN KEY ("updated_by") REFERENCES "users" ("id"),
  ADD CONSTRAINT fk_deleted_by FOREIGN KEY ("deleted_by") REFERENCES "users" ("id")
