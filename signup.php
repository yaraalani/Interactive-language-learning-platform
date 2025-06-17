<?php
// الاتصال بقاعدة البيانات
$host = "localhost";
$user = "root";
$pass = "";
$dbname = "learning_platform";

$conn = new mysqli($host, $user, $pass, $dbname);
if ($conn->connect_error) {
    die("فشل الاتصال: " . $conn->connect_error);
}

$success = '';
$error = '';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $name = trim($_POST['name']);
    $email = trim($_POST['email']);
    $password = $_POST['password'];
    $confirm_password = $_POST['confirm_password'];
    $role = $_POST['role'];

    if ($password !== $confirm_password) {
        $error = "كلمتا المرور غير متطابقتين!";
    } else {
        $hashed_password = password_hash($password, PASSWORD_BCRYPT);

        $stmt = $conn->prepare("INSERT INTO users (name, email, password, role) VALUES (?, ?, ?, ?)");
        $stmt->bind_param("ssss", $name, $email, $hashed_password, $role);

        if ($stmt->execute()) {
          header("Location: login.php");
          exit();
          
        } else {
            $error = "حدث خطأ أثناء إنشاء الحساب: " . $stmt->error;
        }

        $stmt->close();
    }
}
?>

<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <title>إنشاء حساب</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap RTL -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.rtl.min.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Cairo:wght@500&display=swap" rel="stylesheet">
    <link href="style.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(to left, #f0f8ff, #ffffff);
            font-family: 'Cairo', sans-serif;
        }
       
    </style>
</head>
<body>
    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-light">
        <div class="container-fluid">
            <a class="navbar-brand" href="index.php">
                <i class="fas fa-language"></i>
                إنجليش ماستر
            </a>
            <div>
                <a href="index.php" class="btn btn-outline-primary">
                    <i class="fas fa-home me-2"></i> العودة للرئيسية
                </a>
            </div>
        </div>
    </nav>
<div class="signup-form">
    <h3 class="text-center mb-4">إنشاء حساب جديد</h3>

    <?php if ($success): ?>
        <div class="alert alert-success text-center"><?= $success ?></div>
    <?php elseif ($error): ?>
        <div class="alert alert-danger text-center"><?= $error ?></div>
    <?php endif; ?>

    <form method="POST" novalidate>
        <div class="mb-3">
            <label class="form-label">الاسم الكامل</label>
            <input type="text" name="name" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">البريد الإلكتروني</label>
            <input type="email" name="email" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">كلمة المرور</label>
            <input type="password" name="password" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">تأكيد كلمة المرور</label>
            <input type="password" name="confirm_password" class="form-control" required>
        </div>

        <div class="mb-4">
            <label class="form-label">الدور</label>
            <select name="role" class="form-select" required>
                <option value="">اختر الدور</option>
                <option value="teacher">أستاذ</option>
                <option value="student">طالب</option>
            </select>
        </div>

        <button type="submit" class="btn btn-primary w-100">إنشاء الحساب</button>
    </form>
</div>

</body>
</html>
