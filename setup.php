<?php
require 'config.php'; require 'crypto.php';
if (is_configured($pdo)) { header('Location: login.php'); exit; }
$err = ''; $privKey = null;
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_check();
    $pass = $_POST['pass'] ?? '';
    if (strlen($pass) < 8) $err = 'Kunci simetris minimal 8 karakter.';
    else {
        $kp = generate_rsa();
        if (!$kp) $err = 'Gagal generate RSA. Cek ekstensi/konfigurasi OpenSSL PHP.';
        else {
            $pdo->prepare('INSERT INTO auth_config (pass_hash, public_key) VALUES (?, ?)')
                ->execute([password_hash($pass, PASSWORD_DEFAULT), $kp['public']]);
            $privKey = $kp['private'];
        }
    }
}
?>
<!DOCTYPE html><html lang="id"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>Setup Kunci</title><link rel="stylesheet" href="style.css"></head>
<body class="auth"><div class="auth-wrap"><div class="auth-card">
  <div class="logo dark"><svg viewBox="0 0 24 24" width="28" height="28" fill="none" stroke="#4f46e5" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="4" y="11" width="16" height="10" rx="2"/><path d="M8 11V7a4 4 0 0 1 8 0v4"/></svg></div>
<?php if ($privKey): ?>
  <h2>Setup Berhasil</h2>
  <p class="sub">Kunci asimetris Anda sudah dibuat</p>
  <div class="warn">Simpan <b>Private Key</b> ini sekarang. Tidak akan ditampilkan lagi dan tidak disimpan di server.</div>
  <textarea readonly onclick="this.select()" style="min-height:240px"><?= e($privKey) ?></textarea>
  <a class="btn btn-block" download="private_key.pem" href="data:application/x-pem-file;base64,<?= base64_encode($privKey) ?>">Unduh private_key.pem</a>
  <a class="btn btn-ghost btn-block" href="login.php">Lanjut ke Login &rarr;</a>
<?php else: ?>
  <h2>Setup Kunci</h2>
  <p class="sub">Dilakukan sekali saja sebelum login pertama</p>
  <?php if ($err): ?><div class="err"><?= e($err) ?></div><?php endif; ?>
  <form method="post">
    <input type="hidden" name="csrf" value="<?= csrf_token() ?>">
    <label>Kunci Simetris (passphrase, min. 8 karakter)</label>
    <input type="password" name="pass" required autocomplete="off">
    <p class="note">Pasangan kunci RSA-2048 dibuat otomatis. Public key disimpan di database, private key diberikan kepada Anda.</p>
    <button class="btn btn-block">Generate Kunci</button>
  </form>
<?php endif; ?>
</div></div></body></html>
