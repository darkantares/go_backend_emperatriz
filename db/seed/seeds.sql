INSERT INTO "users" (  "is_authenticated",   "email",   "password",   "phone",   "full_name",   "username",   "password_changed_at",   "status",   "removable",   "editable",   "is_visible",   "default",   "created_at",   "updated_at",   "deleted_at",   "created_by",   "updated_by",   "deleted_by",   "enterprise_id"
) VALUES (
  true,'john.doe@example.com','hashedpassword123','+1234567890','John Doe','johndoe','2024-01-01 00:00:00',true,false,true,true,true,NOW(),NULL,NULL,NULL,NULL,NULL,NULL                           
);

INSERT INTO "enterprise" (
  "title",   "document_verification",   "phone",   "email",   "contact",   "contact_phone",   "files",   "address",   "web",   "is_authenticated",   "status",   "removable",   "editable",   "is_visible",   "default",   "created_at",   "updated_at",   "deleted_at",   "created_by",   "updated_by",   "deleted_by"
) VALUES (
  'TechCorp Solutions','DOC-123456789','+1234567890','info@techcorp.com','John Doe','+9876543210','documents/techcorp_files.zip','123 Tech Street, Silicon Valley','https://www.techcorp.com',true,true,true,true,true,true,NOW(),NULL,NULL,1,NULL,NULL                              
);

UPDATE "users" SET "enterprise_id" = 1;

INSERT INTO "brand" (  "title",   "status",   "removable",   "editable",   "is_visible",   "default",   "created_at",   "updated_at",   "deleted_at",   "created_by",   "updated_by",   "deleted_by",   "enterprise_id") 
VALUES (
  'Marca Generica', true, false, false, true, true, now(), null, null, 1, 1, 1, 1
);



