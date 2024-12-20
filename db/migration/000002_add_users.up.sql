CREATE TABLE "users" (
  "id" serial PRIMARY KEY,
  "is_authenticated" boolean NOT NULL DEFAULT true,
  "email" varchar UNIQUE NOT NULL,
  "password" varchar NOT NULL,
  "phone" text UNIQUE DEFAULT null,
  "full_name" varchar NOT NULL,
  "username" varchar UNIQUE NOT NULL,
  "status" boolean NOT NULL DEFAULT true,
  "removable" boolean NOT NULL DEFAULT false,
  "editable" boolean NOT NULL DEFAULT false,
  "is_visible" boolean NOT NULL DEFAULT true,
  "default" boolean NOT NULL DEFAULT false,
  "password_changed_at" timestamptz,  
  "created_at" timestamptz DEFAULT now(),
  "updated_at" timestamptz DEFAULT null,
  "deleted_at" timestamptz DEFAULT null
);

ALTER TABLE "accounts" ADD FOREIGN KEY ("owner") REFERENCES "users" ("email");
ALTER TABLE "accounts" ADD CONSTRAINT "owner_currency_key" UNIQUE ("owner", "currency");