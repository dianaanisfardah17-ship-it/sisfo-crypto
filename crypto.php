<?php
// ===== SIMETRIS: AES-256-GCM =====
function derive_key($pass, $salt) {
    return hash_pbkdf2('sha256', $pass, $salt, 100000, 32, true);
}
function aes_encrypt($plain, $key) {
    $iv = random_bytes(12); $tag = '';
    $ct = openssl_encrypt($plain, 'aes-256-gcm', $key, OPENSSL_RAW_DATA, $iv, $tag, '', 16);
    return base64_encode($iv . $tag . $ct);
}
function aes_decrypt($b64, $key) {
    $raw = base64_decode($b64, true);
    if ($raw === false || strlen($raw) < 28) return false;
    return openssl_decrypt(substr($raw, 28), 'aes-256-gcm', $key, OPENSSL_RAW_DATA, substr($raw, 0, 12), substr($raw, 12, 16));
}

// ===== HIBRIDA: data key diamankan 2 lapis (simetris lalu asimetris) =====
// data key --AES(kunci simetris dari passphrase)--> --RSA-OAEP(public key)--> wrapped_key
function wrap_key($dataKey, $pass, $pubPem) {
    $salt  = random_bytes(16);
    $inner = $salt . base64_decode(aes_encrypt($dataKey, derive_key($pass, $salt)));
    if (!openssl_public_encrypt($inner, $out, $pubPem, OPENSSL_PKCS1_OAEP_PADDING)) return false;
    return base64_encode($out);
}
function unwrap_key($wrapped, $pass, $privPem) {
    if (!openssl_private_decrypt(base64_decode($wrapped), $inner, $privPem, OPENSSL_PKCS1_OAEP_PADDING)) return false;
    if (strlen($inner) < 16) return false;
    $salt = substr($inner, 0, 16);
    return aes_decrypt(base64_encode(substr($inner, 16)), derive_key($pass, $salt));
}

// Simpan data: judul & isi dienkripsi dengan data key acak
function encrypt_record($judul, $isi, $pass, $pubPem) {
    $dk = random_bytes(32);
    return [
        'judul_enc'   => aes_encrypt($judul, $dk),
        'isi_enc'     => aes_encrypt($isi, $dk),
        'wrapped_key' => wrap_key($dk, $pass, $pubPem),
    ];
}
function decrypt_record($row, $pass, $privPem) {
    $dk = unwrap_key($row['wrapped_key'], $pass, $privPem);
    if ($dk === false) return null;
    return ['judul' => aes_decrypt($row['judul_enc'], $dk), 'isi' => aes_decrypt($row['isi_enc'], $dk)];
}

// ===== ASIMETRIS: RSA-2048 =====
function generate_rsa() {
    $cfgs = [null];
    foreach (['C:/laragon/bin/php/*/extras/ssl/openssl.cnf',
              'C:/laragon/bin/apache/*/conf/openssl.cnf',
              'C:/xampp/php/extras/openssl/openssl.cnf',
              'C:/xampp/apache/conf/openssl.cnf'] as $pat) {
        foreach (glob($pat) ?: [] as $f) $cfgs[] = $f;
    }
    foreach ($cfgs as $c) {
        $opt = ['private_key_bits' => 2048, 'private_key_type' => OPENSSL_KEYTYPE_RSA];
        if ($c) $opt['config'] = $c;
        $res = @openssl_pkey_new($opt);
        if (!$res) continue;
        if (!@openssl_pkey_export($res, $priv, null, $c ? ['config' => $c] : [])) continue;
        return ['private' => $priv, 'public' => openssl_pkey_get_details($res)['key']];
    }
    return false;
}
function normalize_pem($pem) {
    return trim(str_replace("\r\n", "\n", $pem)) . "\n";
}
// Verifikasi private key cocok dengan public key (challenge-response)
function verify_keypair($privPem, $pubPem) {
    $priv = @openssl_pkey_get_private($privPem);
    if (!$priv) return false;
    $challenge = random_bytes(32);
    if (!openssl_public_encrypt($challenge, $enc, $pubPem, OPENSSL_PKCS1_OAEP_PADDING)) return false;
    if (!@openssl_private_decrypt($enc, $dec, $priv, OPENSSL_PKCS1_OAEP_PADDING)) return false;
    return hash_equals($challenge, $dec);
}
