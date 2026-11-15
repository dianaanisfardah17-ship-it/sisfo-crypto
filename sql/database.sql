CREATE DATABASE IF NOT EXISTS sisfo_crypto CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE sisfo_crypto;

-- Konfigurasi autentikasi: hash kunci simetris + public key RSA
CREATE TABLE IF NOT EXISTS auth_config (
  id INT PRIMARY KEY AUTO_INCREMENT,
  pass_hash VARCHAR(255) NOT NULL,
  public_key TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Data tersimpan dalam bentuk terenkripsi (judul & isi)
CREATE TABLE IF NOT EXISTS records (
  id INT PRIMARY KEY AUTO_INCREMENT,
  judul_enc TEXT NOT NULL,
  isi_enc TEXT NOT NULL,
  wrapped_key TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
