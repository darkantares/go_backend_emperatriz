INSERT INTO enterprise (
  title, document_verification, phone, email, contact, contact_phone, files, address, web, is_authenticated
) VALUES 
  ('Company A', 'Verified', '123456789', 'companya@example.com', 'John Doe', '987654321', 'file1.pdf', '123 Main St', 'www.companya.com', true)
ON CONFLICT DO NOTHING;