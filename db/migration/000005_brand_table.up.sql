CREATE TABLE "brand" (
  "id" serial PRIMARY KEY,
  "title" varchar UNIQUE NOT NULL,
  "status" boolean NOT NULL DEFAULT true,
  "removable" boolean NOT NULL DEFAULT false,
  "editable" boolean NOT NULL DEFAULT false,
  "is_visible" boolean NOT NULL DEFAULT true,
  "default" boolean NOT NULL DEFAULT false,
  "created_at" timestamptz DEFAULT now(),
  "updated_at" timestamptz DEFAULT null,
  "deleted_at" timestamptz DEFAULT null,

  "created_by" integer REFERENCES "users"("id"),
  "updated_by" integer REFERENCES "users"("id"),
  "deleted_by" integer REFERENCES "users"("id"),
  "enterprise_id" integer REFERENCES "enterprise"("id"),

  CONSTRAINT fk_created_by FOREIGN KEY ("created_by") REFERENCES "users" ("id"),
  CONSTRAINT fk_updated_by FOREIGN KEY ("updated_by") REFERENCES "users" ("id"),
  CONSTRAINT fk_deleted_by FOREIGN KEY ("deleted_by") REFERENCES "users" ("id"),
  CONSTRAINT fk_enterprise_table FOREIGN KEY ("enterprise_id") REFERENCES "enterprise" ("id")
);
