<?php
session_start();
header('Content-Type: application/json');

if (!isset($_SESSION['user_id'])) {
    echo json_encode(['success' => false, 'message' => 'يجب تسجيل الدخول أولاً']);
    exit;
}

$conn = new mysqli("localhost", "root", "", "learning_platform");
if ($conn->connect_error) {
    echo json_encode(['success' => false, 'message' => 'خطأ في الاتصال بقاعدة البيانات']);
    exit;
}

$student_id = $_SESSION['user_id'];
$quiz_id = intval($_POST['quiz_id'] ?? 0);
$score = intval($_POST['score'] ?? 0);

// التحقق من عدم وجود نتيجة سابقة
$check_result = $conn->query("SELECT * FROM quiz_results WHERE student_id = $student_id AND quiz_id = $quiz_id");

if ($check_result->num_rows > 0) {
    echo json_encode(['success' => false, 'message' => 'لقد أكملت هذا الاختبار من قبل']);
    exit;
}

// حفظ النتيجة الجديدة
$stmt = $conn->prepare("INSERT INTO quiz_results (student_id, quiz_id, score, total_questions) VALUES (?, ?, ?, 1)");
$stmt->bind_param("iii", $student_id, $quiz_id, $score);

if ($stmt->execute()) {
    echo json_encode(['success' => true]);
} else {
    echo json_encode(['success' => false, 'message' => 'خطأ في حفظ النتيجة']);
}

$stmt->close();
$conn->close();
?>