<?php
require 'config.php'; require 'crypto.php';
require_login();
$cfg = $pdo->query('SELECT public_key FROM auth_config ORDER BY id LIMIT 1')->fetch();
$msg = ''; $err = '';

function short_ct($s, $n = 56) { return strlen($s) > $n ? substr($s, 0, $n) . '...' : $s; }

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_check();
    if (($_POST['aksi'] ?? '') === 'tambah') {
        $judul = trim($_POST['judul'] ?? ''); $isi = trim($_POST['isi'] ?? '');
        if ($judul === '' || $isi === '') $err = 'Judul dan isi wajib diisi.';
        else {
            $r = encrypt_record($judul, $isi, $_SESSION['pass'], $cfg['public_key']);
            if ($r['wrapped_key'] === false) $err = 'Enkripsi gagal.';
            else {
                $pdo->prepare('INSERT INTO records (judul_enc, isi_enc, wrapped_key) VALUES (?,?,?)')
                    ->execute([$r['judul_enc'], $r['isi_enc'], $r['wrapped_key']]);
                $msg = 'Data berhasil dienkripsi dan disimpan.';
            }
        }
    } elseif (($_POST['aksi'] ?? '') === 'hapus') {
        $pdo->prepare('DELETE FROM records WHERE id = ?')->execute([(int)$_POST['id']]);
        $msg = 'Data dihapus.';
    }
}
$rows = $pdo->query('SELECT * FROM records ORDER BY id DESC')->fetchAll();
?>
<!DOCTYPE html><html lang="id"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>Admin</title><link rel="stylesheet" href="style.css"></head><body>
<div class="nav"><div class="nav-in">
  <span class="brand"><span class="mini-logo"><svg viewBox="0 0 24 24" width="20" height="20" fill="none" stroke="#fff" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="4" y="11" width="16" height="10" rx="2"/><path d="M8 11V7a4 4 0 0 1 8 0v4"/></svg></span>Sisfo Crypto</span>
  <a class="btn btn-danger btn-sm logout" href="logout.php">Logout</a>
</div></div>
<div class="container">
  <h1 class="page-title">Halaman Admin</h1>
  <p class="page-sub">Anda masuk dengan kunci simetris dan kunci asimetris yang valid.</p>
  <?php if ($msg): ?><div class="ok"><?= e($msg) ?></div><?php endif; ?>
  <?php if ($err): ?><div class="err"><?= e($err) ?></div><?php endif; ?>

  <div class="stats">
    <div class="stat"><span class="stat-n"><?= count($rows) ?></span><span class="stat-l">Data terenkripsi</span></div>
    <div class="stat"><span class="stat-n sm">AES-256-GCM</span><span class="stat-l">Enkripsi data (simetris)</span></div>
    <div class="stat"><span class="stat-n sm">RSA-2048</span><span class="stat-l">Pembungkus kunci (asimetris)</span></div>
  </div>

  <div class="card">
    <h2>Tambah Data</h2>
    <p class="hint">Judul dan isi dienkripsi terlebih dahulu sebelum disimpan ke database.</p>
    <form method="post">
      <input type="hidden" name="csrf" value="<?= csrf_token() ?>"><input type="hidden" name="aksi" value="tambah">
      <label>Judul</label><input name="judul" required>
      <label>Isi</label><textarea class="plain" name="isi" required></textarea>
      <button class="btn" style="margin-top:16px">Enkripsi &amp; Simpan</button>
    </form>
  </div>

  <div class="card">
    <h2>Seluruh Data Hasil Enkripsi</h2>
    <p class="hint">Kolom ciphertext adalah isi database. Kolom plaintext hanya tampil karena login dengan kunci yang benar.</p>
    <div class="tbl-wrap"><table>
      <tr><th>#</th><th>Judul (ciphertext)</th><th>Isi (ciphertext)</th><th>Wrapped key</th><th>Plaintext (hasil dekripsi)</th><th></th></tr>
      <?php foreach ($rows as $r): $d = decrypt_record($r, $_SESSION['pass'], $_SESSION['priv']); ?>
      <tr>
        <td><?= (int)$r['id'] ?></td>
        <td><code class="ct" title="<?= e($r['judul_enc']) ?>"><?= e(short_ct($r['judul_enc'])) ?></code></td>
        <td><code class="ct" title="<?= e($r['isi_enc']) ?>"><?= e(short_ct($r['isi_enc'])) ?></code></td>
        <td><code class="ct" title="<?= e($r['wrapped_key']) ?>"><?= e(short_ct($r['wrapped_key'])) ?></code></td>
        <td><?php if ($d && $d['judul'] !== false): ?><div class="plain-cell"><b><?= e($d['judul']) ?></b><?= nl2br(e($d['isi'])) ?></div><?php else: ?><span class="fail">[gagal dekripsi]</span><?php endif; ?></td>
        <td><form method="post" onsubmit="return confirm('Hapus data ini?')"><input type="hidden" name="csrf" value="<?= csrf_token() ?>"><input type="hidden" name="aksi" value="hapus"><input type="hidden" name="id" value="<?= (int)$r['id'] ?>"><button class="btn btn-outline-danger btn-sm">Hapus</button></form></td>
      </tr>
      <?php endforeach; if (!$rows): ?><tr><td colspan="6" class="empty">Belum ada data.</td></tr><?php endif; ?>
    </table></div>
  </div>
</div></body></html>
