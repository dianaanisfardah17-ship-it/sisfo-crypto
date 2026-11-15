# Sistem Informasi Terenkripsi (PHP + MySQL)
1. Taruh folder di htdocs (XAMPP), jalankan Apache + MySQL, pastikan `extension=openssl` aktif.
2. Import `sql/database.sql` lewat phpMyAdmin. Sesuaikan `config.php` bila perlu.
3. Buka http://localhost/sisfo-crypto/ lalu klik Masuk Admin, lakukan setup kunci sekali.
4. Simpan private_key.pem. Login = passphrase (simetris) + private key (asimetris).
