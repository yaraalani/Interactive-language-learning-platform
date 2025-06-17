<?php
// db_connection.php

if (!defined('DB_HOST')) {
    // إعدادات قاعدة البيانات
    define('DB_HOST', 'localhost');
    define('DB_USER', 'root');
    define('DB_PASS', '');
    define('DB_NAME', 'learning_platform');
    define('DB_CHARSET', 'utf8mb4');

    // إنشاء اتصال مع قاعدة البيانات
    try {
        $conn = new mysqli(DB_HOST, DB_USER, DB_PASS, DB_NAME);
        
        // التحقق من الأخطاء
        if ($conn->connect_error) {
            throw new Exception("فشل الاتصال بقاعدة البيانات: " . $conn->connect_error);
        }
        
        // تعيين مجموعة المحارف
        $conn->set_charset(DB_CHARSET);
        
        // إعدادات الوقت
        date_default_timezone_set('Asia/Riyadh');

    } catch (Exception $e) {
        // تسجيل الخطأ مع إخفاء الرسالة الحقيقية في البيئة الإنتاجية
        error_log($e->getMessage());
        die("حدث خطأ تقني، يرجى المحاولة لاحقًا.");
    }
}


?>