<?php require 'config.php'; $dest = is_configured($pdo) ? 'login.php' : 'setup.php'; ?>
<!DOCTYPE html><html lang="id"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>Sistem Informasi Terenkripsi</title><link rel="stylesheet" href="style.css"></head>
<body class="auth"><div class="landing">
  <div class="logo"><svg viewBox="0 0 24 24" width="28" height="28" fill="none" stroke="#fff" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="4" y="11" width="16" height="10" rx="2"/><path d="M8 11V7a4 4 0 0 1 8 0v4"/></svg></div>
  <h1>Sistem Informasi Terenkripsi</h1>
  <p class="lead">Data disimpan sebagai ciphertext. Akses admin tidak memakai username dan password, tetapi kombinasi <b>kunci simetris</b> dan <b>kunci asimetris</b>.</p>
  <a class="btn btn-light" href="<?= $dest ?>">Masuk Halaman Admin &rarr;</a>
  <div class="features">
    <div class="feat"><b>Kunci Simetris</b><span>Isi data dienkripsi dengan AES-256-GCM. Kunci diturunkan dari passphrase.</span></div>
    <div class="feat"><b>Kunci Asimetris</b><span>Kunci data dibungkus RSA-2048. Hanya pemilik private key yang bisa membukanya.</span></div>
    <div class="feat"><b>Login Dua Kunci</b><span>Masuk hanya jika kedua kunci benar. Salah satu salah, akses ditolak.</span></div>
  </div>
</div></body></html>
