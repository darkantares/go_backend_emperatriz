CREATE TABLE "enterprise" (
  "id" serial PRIMARY KEY,
  "title" varchar UNIQUE NOT NULL,
  "document_verification" varchar NOT NULL,
  "phone" varchar NOT NULL,
  "email" varchar UNIQUE NOT NULL,
  "contact" varchar,
  "contact_phone" varchar NOT NULL,
  "files" varchar NOT NULL,
  "address" varchar NOT NULL,
  "web" varchar NOT NULL,
  "is_authenticated" boolean NOT NULL DEFAULT false,
  
  --INFO FIELDS
  "status" boolean NOT NULL DEFAULT true,
  "removable" boolean NOT NULL DEFAULT false,
  "editable" boolean NOT NULL DEFAULT false,
  "is_visible" boolean NOT NULL DEFAULT true,
  "default" boolean NOT NULL DEFAULT false,
  "created_at" timestamptz DEFAULT now(),
  "updated_at" timestamptz DEFAULT null,
  "deleted_at" timestamptz DEFAULT null
);