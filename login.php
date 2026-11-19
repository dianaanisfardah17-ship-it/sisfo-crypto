<?php
require 'config.php'; require 'crypto.php';
if (!is_configured($pdo)) { header('Location: setup.php'); exit; }
if (!empty($_SESSION['auth'])) { header('Location: admin.php'); exit; }
$err = '';
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_check();
    $pass = $_POST['pass'] ?? '';
    $priv = '';
    if (!empty($_FILES['privfile']['tmp_name']) && is_uploaded_file($_FILES['privfile']['tmp_name'])) {
        $priv = file_get_contents($_FILES['privfile']['tmp_name']);
    } else {
        $priv = $_POST['priv'] ?? '';
    }
    $priv = normalize_pem($priv);
    $cfg = $pdo->query('SELECT * FROM auth_config ORDER BY id LIMIT 1')->fetch();
    $passOk = $pass !== '' && password_verify($pass, $cfg['pass_hash']);
    $keyOk  = verify_keypair($priv, $cfg['public_key']);
    if ($passOk || $keyOk) {              // cukup salah satu kunci benar untuk masuk
        session_regenerate_id(true);
        $_SESSION['auth']    = true;
        $_SESSION['pass_ok'] = $passOk;
        $_SESSION['key_ok']  = $keyOk;
        $_SESSION['full']    = $passOk && $keyOk;
        if ($passOk && $keyOk) {          // kunci disimpan di sesi hanya jika keduanya valid
            $_SESSION['pass'] = $pass;
            $_SESSION['priv'] = $priv;
        }
        header('Location: admin.php'); exit;
    }
    $err = 'Kunci simetris dan kunci asimetris sama-sama tidak valid.';
}
?>
<!DOCTYPE html><html lang="id"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>Login Kunci</title><link rel="stylesheet" href="style.css"></head>
<body class="auth"><div class="auth-wrap"><div class="auth-card">
  <div class="logo dark"><svg viewBox="0 0 24 24" width="28" height="28" fill="none" stroke="#4f46e5" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="4" y="11" width="16" height="10" rx="2"/><path d="M8 11V7a4 4 0 0 1 8 0v4"/></svg></div>
  <h2>Login Admin</h2>
  <p class="sub">Masuk jika salah satu kunci benar. Isi data hanya terbuka jika keduanya benar.</p>
  <?php if ($err): ?><div class="err"><?= e($err) ?></div><?php endif; ?>
  <form method="post" enctype="multipart/form-data">
    <input type="hidden" name="csrf" value="<?= csrf_token() ?>">
    <label>Kunci Simetris (passphrase)</label>
    <input type="password" name="pass" autocomplete="off">
    <label>Kunci Asimetris (Private Key PEM)</label>
    <textarea name="priv" placeholder="-----BEGIN PRIVATE KEY-----"></textarea>
    <label>atau unggah file private_key.pem</label>
    <input type="file" name="privfile" accept=".pem,.key,.txt">
    <button class="btn btn-block">Masuk</button>
    <a class="btn btn-ghost btn-block" href="index.php">Kembali</a>
  </form>
</div></div></body></html>
