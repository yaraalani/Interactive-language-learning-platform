<?php
session_start();
if (!isset($_SESSION['user_id']) || $_SESSION['role'] !== 'student') {
    header("Location: login.php");
    exit();
}
?>

<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <title>اختبار تحديد المستوى</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.rtl.min.css" rel="stylesheet">
    <style>
        body {
            background: #f8f9fa;
            font-family: 'Cairo', sans-serif;
        }
        .quiz-container {
            max-width: 700px;
            margin: auto;
            padding: 30px;
            background: white;
            border-radius: 16px;
            box-shadow: 0 0 10px #ccc;
        }
    </style>
</head>
<body>

<div class="quiz-container mt-5">
    <h3 class="mb-4 text-center">🧠 اختبار تحديد المستوى</h3>
    <form action="placement_result.php" method="post">
        <div class="mb-3">
            <label>1. What does "Apple" mean?</label>
            <div>
                <input type="radio" name="q1" value="a" required> قطة <br>
                <input type="radio" name="q1" value="b"> تفاحة <br>
                <input type="radio" name="q1" value="c"> موزة <br>
            </div>
        </div>

        <div class="mb-3">
            <label>2. Choose the correct sentence:</label>
            <div>
                <input type="radio" name="q2" value="a" required> He go to school <br>
                <input type="radio" name="q2" value="b"> He going to school <br>
                <input type="radio" name="q2" value="c"> He goes to school <br>
            </div>
        </div>

        <div class="mb-3">
            <label>3. What is the plural of "child"?</label>
            <div>
                <input type="radio" name="q3" value="a" required> children <br>
                <input type="radio" name="q3" value="b"> childs <br>
                <input type="radio" name="q3" value="c"> childes <br>
            </div>
        </div>

        <div class="mb-3">
            <label>4. Translate: "I am happy"</label>
            <div>
                <input type="radio" name="q4" value="a" required> أنا حزين <br>
                <input type="radio" name="q4" value="b"> أنا سعيد <br>
                <input type="radio" name="q4" value="c"> أنا نائم <br>
            </div>
        </div>

        <div class="mb-3">
            <label>5. Which word fits: "She ____ smart."</label>
            <div>
                <input type="radio" name="q5" value="a" required> is <br>
                <input type="radio" name="q5" value="b"> are <br>
                <input type="radio" name="q5" value="c"> am <br>
            </div>
        </div>

        <button type="submit" class="btn btn-primary">إرسال</button>
    </form>
</div>

</body>
</html>
