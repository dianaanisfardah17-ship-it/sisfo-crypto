<?php
session_start();

define('DB_HOST', 'localhost');
define('DB_NAME', 'sisfo_crypto');
define('DB_USER', 'root');
define('DB_PASS', '');

try {
    $pdo = new PDO('mysql:host=' . DB_HOST . ';dbname=' . DB_NAME . ';charset=utf8mb4', DB_USER, DB_PASS, [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    ]);
} catch (PDOException $e) {
    die('Koneksi database gagal. Import sql/database.sql dulu & cek config.php.');
}

function e($s) { return htmlspecialchars((string)$s, ENT_QUOTES, 'UTF-8'); }

function csrf_token() {
    if (empty($_SESSION['csrf'])) $_SESSION['csrf'] = bin2hex(random_bytes(16));
    return $_SESSION['csrf'];
}
function csrf_check() {
    if (!isset($_POST['csrf']) || !hash_equals($_SESSION['csrf'] ?? '', $_POST['csrf'])) {
        http_response_code(403); die('CSRF token tidak valid.');
    }
}
function is_configured($pdo) {
    return (int)$pdo->query('SELECT COUNT(*) FROM auth_config')->fetchColumn() > 0;
}
function require_login() {
    if (empty($_SESSION['pass']) || empty($_SESSION['priv'])) { header('Location: login.php'); exit; }
}
