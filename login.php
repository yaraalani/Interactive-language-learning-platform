<?php
session_start();
$host = "localhost";
$user = "root";
$pass = "";
$dbname = "learning_platform";

$conn = new mysqli($host, $user, $pass, $dbname);
if ($conn->connect_error) {
    die("فشل الاتصال: " . $conn->connect_error);
}

$error = '';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $email = trim($_POST['email']);
    $password = $_POST['password'];

    $stmt = $conn->prepare("SELECT id, name, password, role FROM users WHERE email = ?");
    $stmt->bind_param("s", $email);
    $stmt->execute();
    $stmt->store_result();

    if ($stmt->num_rows == 1) {
        $stmt->bind_result($id, $name, $hashed_password, $role);
        $stmt->fetch();

        if (password_verify($password, $hashed_password)) {
            $_SESSION['user_id'] = $id;
            $_SESSION['name'] = $name;
            $_SESSION['role'] = $role;

            if ($role === 'teacher') {
                header("Location: teacher_dashboard.php");
            } else {
                header("Location: student_dashboard.php");
            }
            exit();
        } else {
            $error = "كلمة المرور غير صحيحة.";
        }
    } else {
        $error = "البريد الإلكتروني غير موجود.";
    }

    $stmt->close();
}
?>

<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>تسجيل الدخول - إنجليش ماستر</title>
    <!-- Bootstrap RTL CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.rtl.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Tajawal:wght@400;500;700&display=swap" rel="stylesheet">
    <link href="style.css" rel="stylesheet">
    <!-- Animate.css -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    
    <style>
        :root {
            --primary-color: #4361ee;
            --secondary-color: #3f37c9;
            --accent-color: #4cc9f0;
            --light-color: #f8f9fa;
            --dark-color: #212529;
        }
        
        body {
            font-family: 'Tajawal', sans-serif;
            background: linear-gradient(135deg, rgba(67,97,238,0.1) 0%, rgba(76,201,240,0.05) 100%);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        .form-control {
    text-align: right;
    direction: rtl;
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
    
    <!-- Login Form -->
    <div class="login-container">
        <div class="container">
            <div class="floating-icons">
                <i class="fas fa-book floating-icon" style="top: 20%; left: 10%;"></i>
                <i class="fas fa-pen floating-icon" style="top: 70%; left: 80%;"></i>
                <i class="fas fa-globe floating-icon" style="top: 40%; left: 75%;"></i>
                <i class="fas fa-comments floating-icon" style="top: 80%; left: 15%;"></i>
            </div>
            
            <div class="row justify-content-center">
                <div class="col-md-8 col-lg-6">
                    <div class="login-card animate__animated animate__fadeIn">
                        <div class="login-header">
                            <h3>تسجيل الدخول إلى حسابك</h3>
                        </div>
                        
                        <div class="login-body">
                            <?php if ($error): ?>
                                <div class="alert alert-danger text-center animate__animated animate__shakeX">
                                    <?= $error ?>
                                </div>
                            <?php endif; ?>
                            
                            <form method="POST">
                                <div class="mb-4">
                                    <label for="email" class="form-label">البريد الإلكتروني</label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-transparent">
                                            <i class="fas fa-envelope text-muted"></i>
                                        </span>
                                        <input type="email" id="email" name="email" class="form-control" required placeholder="أدخل بريدك الإلكتروني">
                                    </div>
                                </div>
                                
                                <div class="mb-4">
                                    <label for="password" class="form-label">كلمة المرور</label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-transparent">
                                            <i class="fas fa-lock text-muted"></i>
                                        </span>
                                        <input type="password" id="password" name="password" class="form-control" required placeholder="أدخل كلمة المرور">
                                    </div>
                                </div>
                                
                                <div class="d-grid gap-2 mb-3">
                                    <button type="submit" class="btn btn-primary btn-login">
                                        <i class="fas fa-sign-in-alt me-2"></i> تسجيل الدخول
                                    </button>
                                </div>
                                
                                <div class="form-check mb-4">
                                    <input class="form-check-input" type="checkbox" id="remember">
                                    <label class="form-check-label" for="remember">تذكرني</label>
                                </div>
                            </form>
                            
                            <div class="login-footer">
                                <span>ليس لديك حساب؟</span>
                                <a href="signup.php">إنشاء حساب جديد</a>
                                <span class="mx-2">|</span>
                                <a href="forgot-password.php">نسيت كلمة المرور؟</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>