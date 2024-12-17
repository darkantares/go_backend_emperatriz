-- DO $$ DECLARE
--     tbl RECORD;
-- BEGIN
--     -- Itera sobre todas las tablas en el esquema 'public'
--     FOR tbl IN
--         SELECT tablename
--         FROM pg_tables
--         WHERE schemaname = 'public'
--     LOOP
--         -- Elimina cada tabla y sus dependencias
--         EXECUTE format('DROP TABLE IF EXISTS %I CASCADE', tbl.tablename);
--     END LOOP;
-- END $$;

CREATE TABLE "info_table" (
  "id" integer PRIMARY KEY,
  "status" enum DEFAULT 'Active',
  "removable" boolean DEFAULT false,
  "editable" boolean DEFAULT false,
  "is_visible" boolean DEFAULT true,
  "default" boolean DEFAULT false,
  "created_at" datetime DEFAULT 'now()',
  "created_by" string,
  "updated_at" datetime DEFAULT null,
  "updated_by" string,
  "deleted_at" datetime,
  "deleted_by" string
);

CREATE TABLE "enterprise" (
  "id" integer PRIMARY KEY,
  "title" string UNIQUE,
  "document_verification" string,
  "phone" string,
  "email" string UNIQUE,
  "contact" string,
  "contact_phone" string,
  "files" string,
  "address" string,
  "web" string,
  "is_authenticated" boolean DEFAULT false,
  "info_table_id" integer UNIQUE
);

CREATE TABLE "user" (
  "id" integer PRIMARY KEY,
  "isActive" boolean DEFAULT true,
  "is_authenticated" boolean DEFAULT true,
  "email" text UNIQUE,
  "title" text,
  "password" text,
  "phone" text UNIQUE,
  "firstname" text,
  "lastname" text,
  "info_table_id" integer UNIQUE,
  "enterprise_id" integer
);

CREATE TABLE "brand" (
  "id" integer PRIMARY KEY,
  "title" string UNIQUE,
  "info_table_id" integer UNIQUE,
  "enterprise_id" integer
);

ALTER TABLE "enterprise" ADD FOREIGN KEY ("info_table_id") REFERENCES "info_table" ("id");

ALTER TABLE "user" ADD FOREIGN KEY ("info_table_id") REFERENCES "info_table" ("id");

ALTER TABLE "brand" ADD FOREIGN KEY ("info_table_id") REFERENCES "info_table" ("id");

ALTER TABLE "user" ADD FOREIGN KEY ("enterprise_id") REFERENCES "enterprise" ("id");

ALTER TABLE "brand" ADD FOREIGN KEY ("enterprise_id") REFERENCES "enterprise" ("id");
