# Sistem Informasi Terenkripsi (PHP + MySQL)

Aplikasi sistem informasi berbasis PHP. Landing page mengarah ke halaman admin, dan login admin **tidak memakai username/password**, melainkan input **kunci simetris** (passphrase) dan **kunci asimetris** (private key RSA). Data disimpan dalam bentuk terenkripsi, dan halaman admin menampilkan seluruh data hasil enkripsi tersebut.

## Teknologi
- PHP 8 + MySQL/MariaDB (PDO)
- Enkripsi simetris: AES-256-GCM
- Enkripsi asimetris: RSA-2048 (OAEP)
- Skema hibrida: kunci data dibungkus AES (dari passphrase), lalu RSA (public key)

## Kebutuhan
- [Laragon](https://laragon.org) (Apache/Nginx + MySQL + PHP)
- Ekstensi PHP `openssl` aktif (biasanya sudah aktif di Laragon)

## Instalasi (Laragon)
1. Salin folder project ke `C:\laragon\www\`, sehingga jalurnya `C:\laragon\www\sisfo-crypto\index.php`.
2. Buka Laragon, klik **Start All** (Apache dan MySQL harus berjalan).
3. Import database. Buka **Terminal** Laragon, lalu jalankan:
   ```
   cd C:\laragon\www\sisfo-crypto
   mysql -u root < sql\database.sql
   ```
   Alternatif: klik tombol **Database** (HeidiSQL), lalu **File > Run SQL file** dan pilih `sql\database.sql`.
4. Konfigurasi database ada di `config.php`. Bawaan Laragon (user `root`, password kosong) sudah sesuai, jadi tidak perlu diubah.
5. Buka di browser: `http://sisfo-crypto.test` atau `http://localhost/sisfo-crypto/`.

> Jika alamat `.test` tidak bisa dibuka, klik kanan ikon Laragon lalu **Apache > Reload**, atau gunakan alamat `localhost/sisfo-crypto/`.

## Cara Penggunaan
1. Di landing page, klik **Masuk Halaman Admin**.
2. **Setup kunci (sekali saja).** Isi passphrase (minimal 8 karakter), klik **Generate Kunci**, lalu **unduh `private_key.pem`**. Private key hanya ditampilkan sekali dan tidak disimpan di server.
3. **Login.** Isi passphrase (kunci simetris) dan unggah `private_key.pem` (kunci asimetris), atau tempel isinya. Login berhasil hanya jika **kedua kunci benar**.
4. **Halaman admin.** Tambah data lewat form (dienkripsi sebelum disimpan). Tabel menampilkan ciphertext judul, ciphertext isi, wrapped key, dan plaintext hasil dekripsi.

## Database
- `sql/database.sql`: struktur kosong (tabel `auth_config` dan `records`).
- `sql/database_dengan_data.sql` (jika ada): struktur beserta contoh data terenkripsi. Untuk membukanya dibutuhkan passphrase dan private key demo yang tercantum di lampiran laporan.

## Struktur File
| File | Fungsi |
|---|---|
| `index.php` | Landing page |
| `setup.php` | Setup kunci pertama kali (generate RSA) |
| `login.php` | Login dengan kunci simetris dan asimetris |
| `admin.php` | Halaman admin: tambah, lihat, dan hapus data terenkripsi |
| `logout.php` | Menghapus sesi |
| `crypto.php` | Fungsi AES-256-GCM, RSA, dan pembungkusan kunci |
| `config.php` | Koneksi database dan fungsi bantu |
| `seed.php` | (Opsional) mengisi 5 data contoh. Hapus setelah dipakai |
| `style.css` | Tampilan |

## Pemecahan Masalah
- **"Gagal generate RSA"**: pastikan ekstensi `openssl` tercentang di menu Laragon **PHP > Extensions**, lalu restart Apache.
- **HTTP 500**: jalankan `php -l crypto.php` di Terminal Laragon untuk melihat baris yang error.
- **Lupa passphrase atau private key**: data lama tidak bisa dibuka lagi. Reset dengan:
  ```
  mysql -u root sisfo_crypto -e "DELETE FROM auth_config; DELETE FROM records;"
  ```
  lalu lakukan setup kunci dari awal.

## Keamanan
- **Jangan upload `private_key.pem` ke repository.** Tambahkan `*.pem` ke `.gitignore`.
- Passphrase dan private key disimpan di session server selama login agar data dapat didekripsi. Cukup untuk keperluan tugas, belum dirancang untuk produksi.
