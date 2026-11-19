<?php
// Isi data contoh (terenkripsi). Harus login dulu. Hapus file ini setelah dipakai.
require 'config.php'; require 'crypto.php';
require_login();
if (!is_full()) die('Seed hanya bisa jika kedua kunci benar.');
$cfg = $pdo->query('SELECT public_key FROM auth_config ORDER BY id LIMIT 1')->fetch();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_check();
    $data = [
        ['Nilai UAS Keamanan Data dan Informasi', 'Budi: 90, Siti: 85, Cantik: 95, Andi: 88'],
        ['Daftar Anggota HMIF', 'Ketua: Rizki; Sekretaris: Cantik; Bendahara: Dewi; Divisi Kominfo: Fajar'],
        ['Notulen Rapat Himpunan', 'Rapat 12 November 2026 membahas agenda seminar nasional dan pembagian panitia.'],
        ['Akun Server Laboratorium', 'host: 192.168.1.10, user: admin_lab, password: Lab#2026!'],
        ['Catatan Bimbingan Skripsi', 'Revisi Bab 2: tambahkan kajian pustaka tentang AES-256 dan RSA-2048.'],
    ];
    $st = $pdo->prepare('INSERT INTO records (judul_enc, isi_enc, wrapped_key) VALUES (?,?,?)');
    foreach ($data as [$judul, $isi]) {
        $r = encrypt_record($judul, $isi, $_SESSION['pass'], $cfg['public_key']);
        $st->execute([$r['judul_enc'], $r['isi_enc'], $r['wrapped_key']]);
    }
    header('Location: admin.php'); exit;
}
?>
<!DOCTYPE html><html lang="id"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>Seed Data</title><link rel="stylesheet" href="style.css"></head>
<body class="auth"><div class="auth-wrap"><div class="auth-card">
  <h2>Isi Data Contoh</h2>
  <p class="sub">Menambahkan 5 data contoh, dienkripsi dengan kunci yang sedang dipakai login.</p>
  <form method="post"><input type="hidden" name="csrf" value="<?= csrf_token() ?>">
    <button class="btn btn-block">Tambah 5 Data Contoh</button>
    <a class="btn btn-ghost btn-block" href="admin.php">Kembali</a>
  </form>
</div></div></body></html>
