<?php
// التحقق من تسجيل الدخول
if (!isset($_SESSION['user_id']) || $_SESSION['role'] !== 'teacher') {
    header("Location: login.php");
    exit;
}

$teacher_id = $_SESSION['user_id'];
$conn = new mysqli("localhost", "root", "", "learning_platform");




if ($conn->connect_error) {
    die("فشل الاتصال: " . $conn->connect_error);
}

// جلب بيانات المعلم الحالية
$stmt = $conn->prepare("SELECT id, name, email, created_at FROM users WHERE id = ?");
$stmt->bind_param("i", $teacher_id);
$stmt->execute();
$result = $stmt->get_result();
$teacher = $result->fetch_assoc();

$error = '';
$success = '';

// معالجة تحديث البيانات
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $name = trim($_POST['name']);
    $email = trim($_POST['email']);
    $new_password = trim($_POST['new_password']);
    $confirm_password = trim($_POST['confirm_password']);

    // التحقق من صحة البيانات
    if (empty($name) || empty($email)) {
        $error = 'الاسم والبريد الإلكتروني مطلوبان';
    } elseif (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        $error = 'صيغة البريد الإلكتروني غير صحيحة';
    } elseif (!empty($new_password)) {
        if ($new_password !== $confirm_password) {
            $error = 'كلمات المرور غير متطابقة';
        } elseif (strlen($new_password) < 8) {
            $error = 'كلمة المرور يجب أن تكون 8 أحرف على الأقل';
        }
    }

    // التحقق من البريد الإلكتروني المكرر
    $stmt_check = $conn->prepare("SELECT id FROM users WHERE email = ? AND id != ?");
    $stmt_check->bind_param("si", $email, $teacher_id);
    $stmt_check->execute();
    if ($stmt_check->get_result()->num_rows > 0) {
        $error = 'البريد الإلكتروني مستخدم بالفعل';
    }

    if (empty($error)) {
        // بناء استعلام التحديث
        $query = "UPDATE users SET name = ?, email = ?";
        $params = [$name, $email];
        $types = "ss";
        
        // إذا كان هناك تحديث لكلمة المرور
        if (!empty($new_password)) {
            $hashed_password = password_hash($new_password, PASSWORD_DEFAULT);
            $query .= ", password = ?";
            $params[] = $hashed_password;
            $types .= "s";
        }
        
        $query .= " WHERE id = ?";
        $params[] = $teacher_id;
        $types .= "i";
        
        $stmt_update = $conn->prepare($query);
        $stmt_update->bind_param($types, ...$params);
        
        if ($stmt_update->execute()) {
            $success = 'تم تحديث البيانات بنجاح';
            // تحديث بيانات الجلسة
            $_SESSION['name'] = $name;
            $_SESSION['email'] = $email;
            // إعادة جلب البيانات المحدثة
            $teacher['name'] = $name;
            $teacher['email'] = $email;
        } else {
            $error = 'حدث خطأ أثناء التحديث';
        }
    }
}
?>

<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>الملف الشخصي</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .profile-card {
            max-width: 600px;
            margin: 2rem auto;
            padding: 2rem;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
        }
        .form-label {
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="profile-card card">
            <h3 class="text-center mb-4">الملف الشخصي</h3>
            
            <?php if ($error): ?>
                <div class="alert alert-danger"><?= $error ?></div>
            <?php endif; ?>
            
            <?php if ($success): ?>
                <div class="alert alert-success"><?= $success ?></div>
            <?php endif; ?>

            <form method="POST">
                <div class="mb-3">
                    <label class="form-label">الاسم الكامل</label>
                    <input type="text" name="name" class="form-control" 
                           value="<?= htmlspecialchars($teacher['name']) ?>" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">البريد الإلكتروني</label>
                    <input type="email" name="email" class="form-control"
                           value="<?= htmlspecialchars($teacher['email']) ?>" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">كلمة المرور الجديدة (اختياري)</label>
                    <input type="password" name="new_password" class="form-control">
                    <small class="form-text text-muted">اتركه فارغًا إذا لم ترد التغيير</small>
                </div>

                <div class="mb-3">
                    <label class="form-label">تأكيد كلمة المرور</label>
                    <input type="password" name="confirm_password" class="form-control">
                </div>

                <div class="mb-3">
                    <label class="form-label">تاريخ التسجيل</label>
                    <input type="text" class="form-control" 
                           value="<?= date('Y/m/d', strtotime($teacher['created_at'])) ?>" readonly>
                </div>

                <button type="submit" class="btn btn-primary w-100">حفظ التعديلات</button>
            </form>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>