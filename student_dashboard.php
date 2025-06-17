<?php
session_start();
$student_id = $_SESSION['user_id'] ?? null;

$conn = new mysqli("localhost", "root", "", "learning_platform");
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// جلب الوحدات والدروس معاً، مع تحسين الاستعلام
$units_query = $conn->query("
    SELECT 
        u.id AS unit_id,
        u.title AS unit_title,
        u.description AS unit_description,
        u.order_num AS unit_order,
        l.id AS lesson_id,
        l.title AS lesson_title,
        l.content AS lesson_content,
        l.created_at AS lesson_created_at
    FROM units u
    LEFT JOIN lessons l ON u.id = l.unit_id
    ORDER BY u.order_num ASC, l.created_at ASC
");

// جلب التحديات
$challenges_query = $conn->query("SELECT * FROM challenges ORDER BY start_date DESC");



// جلب الاختبارات مع معلومات النتائج إن وجدت
$quizzes_query = $conn->query("
    SELECT q.*, 
           u.title AS unit_title,
           r.score AS student_score,
           r.completed_at AS completed_at
    FROM quizzes q
    LEFT JOIN units u ON q.unit_id = u.id
    LEFT JOIN quiz_results r ON q.id = r.quiz_id AND r.student_id = $student_id
    ORDER BY q.created_at DESC
");;

// جلب بيانات الطالب
$user_stmt = $conn->prepare("SELECT name, email FROM users WHERE id = ?");
$user_stmt->bind_param("i", $student_id);
$user_stmt->execute();
$user_stmt->bind_result($name, $email);
$user_stmt->fetch();
$user_stmt->close();

// تنظيم البيانات في هيكل مصفوفة يسهل عرضه
$units = [];
while ($row = $units_query->fetch_assoc()) {
    $unit_id = $row['unit_id'];
    if (!isset($units[$unit_id])) {
        $units[$unit_id] = [
            'unit_id' => $unit_id,
            'unit_title' => $row['unit_title'],
            'unit_description' => $row['unit_description'],
            'unit_order' => $row['unit_order'],
            'lessons' => [],
        ];
    }
    if ($row['lesson_id']) { // Check if it's not just a unit without lessons
        $units[$unit_id]['lessons'][] = [
            'lesson_id' => $row['lesson_id'],
            'lesson_title' => $row['lesson_title'],
            'lesson_content' => $row['lesson_content'],
            'lesson_created_at' => $row['lesson_created_at'],
        ];
    }
}
?>

<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <title>لوحة تحكم الطالب</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.rtl.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" integrity="sha512-9usAa10IRO0HhonpyAIVpjrylPvoDwiPUiKdWk5t3PyolY1cOd4DSE0Ga+ri4AuTroPR5aQvXU9xC6qOPnzFeg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <style>
        /* إضافة استايلات للدروس التفاعلية */
        .interactive-lesson-card {
            border: 1px solid #4cc9f0;
            border-radius: 12px;
            padding: 16px;
            margin-bottom: 20px;
            background-color: #f8fcff;
            transition: 0.3s;
        }
        .interactive-lesson-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 4px 12px rgba(76, 201, 240, 0.2);
        }
        .interactive-choices {
            margin-top: 15px;
        }
        .interactive-choice {
            padding: 10px;
            margin: 5px 0;
            border: 1px solid #ddd;
            border-radius: 8px;
            cursor: pointer;
            transition: 0.2s;
        }
        .interactive-choice:hover {
            background-color: #e6f7ff;
            border-color: #4cc9f0;
        }
        .interactive-choice.selected {
            background-color: #4cc9f0;
            color: white;
            border-color: #4cc9f0;
        }
        .interactive-feedback {
            margin-top: 15px;
            padding: 10px;
            border-radius: 8px;
            display: none;
        }
        .interactive-feedback.correct {
            background-color: #d4edda;
            color: #155724;
        }
        .interactive-feedback.incorrect {
            background-color: #f8d7da;
            color: #721c24;
        }
        .tab-content > .tab-pane:not(.active) {
            display: none;
        }
        .unit-card {
            border: 1px solid #ddd;
            border-radius: 12px;
            padding: 16px;
            margin-bottom: 20px;
            transition: 0.3s;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05); /* خفيف جداً */
        }
        .unit-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
        }
        .lesson-card {
            border: 1px solid #ddd;
            border-radius: 12px;
            padding: 16px;
            margin-bottom: 10px;
            transition: 0.3s;
            background-color: #f8f9fa; /* لون خلفية أفتح قليلاً للدروس */
        }
        .lesson-card:hover {
            background-color: #e9ecef;
            transform: translateX(4px); /* تحرك بسيط عند المرور */
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.08); /* ظل خفيف */
        }
        .unit-title {
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 10px;
            color: #1a5290; /* لون أزرق غامق */
        }
        .lesson-title {
            font-size: 16px;
            font-weight: 600;
            margin-bottom: 8px;
            color: #007bff; /* لون أزرق قياسي */
        }
        .progress-bar {
            background-color: #28a745; /* لون أخضر للتقدم */
            border-radius: 10px;
            height: 10px;
            margin-bottom: 15px;
        }
        .nav-link {
            border-radius: 10px;
            color: #0c4a6e;
        }
        .nav-link:hover {
            background-color: #e0f2fe;
            color: #1a5290;
        }
        .nav-link.active {
            background-color: #0c4a6e !important;
            color: white !important;
        }
        .card-header {
            background-color: #f0f4f8;
            border-bottom: 1px solid #ddd;
            padding: 12px;
            border-top-left-radius: 10px;
            border-top-right-radius: 10px;
        }
        .card-body {
            padding: 16px;
        }
        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
            border-radius: 8px;
            padding: 8px 16px;
            font-size: 14px;
        }
        .btn-primary:hover {
            background-color: #0056b3;
            border-color: #004080;
        }
        .btn-success {
            background-color: #28a745;
            border-color: #28a745;
            border-radius: 8px;
            padding: 8px 16px;
            font-size: 14px;
        }
        .btn-success:hover {
            background-color: #218838;
            border-color: #1e7e34;
        }
        .alert-info {
            background-color: #d1ecf1;
            border-color: #b7e1e8;
            color: #0c4a6e;
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 20px;
        }
/* أضف هذه الأنماط إلى قسم style */
.quiz-card {
    transition: all 0.3s ease;
    border-left: 4px solid #6c757d;
}
.quiz-card:hover {
    transform: translateY(-3px);
    box-shadow: 0 4px 8px rgba(0,0,0,0.1);
}
.quiz-options {
    padding: 15px;
    background-color: #f8f9fa;
    border-radius: 8px;
}
.quiz-result {
    border-left: 4px solid #28a745;
}
.form-check-input:checked {
    background-color: #0c4a6e;
    border-color: #0c4a6e;
}
.quiz-feedback {
    transition: all 0.3s ease;
}

/* أنماط التقييم والأداء */
.correct-answer-box {
    background-color: #f8fff8;
    border-left-color: #28a745 !important;
}

.performance-report {
    background-color: #f8f9fa;
    border-left: 4px solid #6c757d;
}

.progress {
    background-color: #e9ecef;
    border-radius: 10px;
    overflow: hidden;
}

.progress-bar {
    display: flex;
    align-items: center;
    justify-content: center;
    font-weight: bold;
    font-size: 14px;
}

.text-success {
    color: #28a745 !important;
}

.text-warning {
    color: #ffc107 !important;
    font-weight: bold;
}

.badge.bg-success {
    background-color: #28a745 !important;
}

.badge.bg-danger {
    background-color: #dc3545 !important;
}

.badge.bg-warning {
    background-color: #ffc107 !important;
    color: #000 !important;
}

.form-check-label.text-success {
    color: #28a745 !important;
}
    </style>
</head>
<body class="bg-light">
<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div class="d-flex align-items-center">
            <?php
            $profile_pic = "uploads/profiles/" . $student_id . ".jpg";
            $default_pic = "assets/images/default-avatar.jpg"; // صورة افتراضية
            ?>
            <div class="me-3">
                <?php if(file_exists($profile_pic)): ?>
                    <img src="<?= $profile_pic ?>?<?= time() ?>" 
                         class="rounded-circle" 
                         width="60" 
                         height="60"
                         style="object-fit: cover;"
                         onerror="this.src='<?= $default_pic ?>'">
                <?php else: ?>
                    <img src="<?= $default_pic ?>" 
                         class="rounded-circle" 
                         width="60" 
                         height="60"
                         style="object-fit: cover;">
                <?php endif; ?>
            </div>
            <div>
                <h2 class="mb-0"> welcome، <?= htmlspecialchars($name) ?></h2>
                <small class="text-muted"><?= htmlspecialchars($email) ?></small>
            </div>
        </div>
        
        <a href="logout.php" class="btn btn-outline-danger">
            <i class="fas fa-sign-out-alt"></i> تسجيل الخروج
        </a>
    </div>
    
  

    <ul class="nav nav-tabs mb-3" id="studentTabs">
        <li class="nav-item"><a class="nav-link active" data-bs-toggle="tab" href="#units">الوحدات الدراسية</a></li>
        <li class="nav-item"><a class="nav-link" data-bs-toggle="tab" href="#interactive">تفاعل معنا</a></li>
        <li class="nav-item"><a class="nav-link" data-bs-toggle="tab" href="#quizzes">الاختبارات</a></li>
        <li class="nav-item"><a class="nav-link" data-bs-toggle="tab" href="#challenges">التحديات</a></li>
        <li class="nav-item"><a class="nav-link" data-bs-toggle="tab" href="#account">الحساب</a></li>
    </ul>

    <div class="tab-content">
        <div id="units" class="tab-pane fade show active">
            <?php foreach ($units as $unit): ?>
                <div class="unit-card">
                    <h3 class="unit-title"><?= htmlspecialchars($unit['unit_title']) ?></h3>
                    <p class="unit-description"><?= htmlspecialchars($unit['unit_description']) ?></p>
                    <div class="progress">
                         <?php
                            // Calculate progress (example: based on number of lessons)
                            $total_lessons = count($unit['lessons']);
                            $completed_lessons = 0; // Replace with actual completed lessons logic
                            if($total_lessons > 0){
                                $progress = ($completed_lessons / $total_lessons) * 100;
                            }
                            else{
                                $progress = 0;
                            }

                            $progress = min($progress, 100); // Ensure it doesn't exceed 100%
                         ?>
                        <div class="progress-bar" role="progressbar" style="width: <?= $progress ?>%" aria-valuenow="<?= $progress ?>" aria-valuemin="0" aria-valuemax="100"></div>
                    </div>
                    <?php if (count($unit['lessons']) > 0): ?>
                        <h4 class="mt-3">الدروس:</h4>
                        <?php foreach ($unit['lessons'] as $lesson): ?>
                            <div class="lesson-card">
                                <h5 class="lesson-title"><?= htmlspecialchars($lesson['lesson_title']) ?></h5>
                                <p><?= mb_strimwidth(strip_tags($lesson['lesson_content']), 0, 100, '...') ?></p>
                                <a href="view_lesson.php?id=<?= $lesson['lesson_id'] ?>" class="btn btn-primary btn-sm">عرض الدرس</a>
                            </div>
                        <?php endforeach; ?>
                    <?php else: ?>
                        <div class="alert alert-info">
                            لا يوجد دروس متاحة لهذه الوحدة حالياً.
                        </div>
                    <?php endif; ?>
                </div>
            <?php endforeach; ?>
        </div>
<!-- قسم الدروس التفاعلية الجديد -->
        <div id="interactive" class="tab-pane fade">
            <h5 class="mb-4">💡 تفاعل معنا</h5>
            <p class="text-muted mb-4">اختر أحد الدروس التفاعلية التالية لتختبر فهمك:</p>
            
            <?php
            // جلب الدروس التفاعلية
            $interactive_lessons = $conn->query("SELECT * FROM interactive_lessons ORDER BY created_at DESC");
            
            if ($interactive_lessons->num_rows > 0): ?>
                <div class="row">
                    <?php while ($lesson = $interactive_lessons->fetch_assoc()): ?>
                        <div class="col-md-6 mb-4">
                            <div class="interactive-lesson-card" id="interactive-lesson-<?= $lesson['id'] ?>">
                                <h5><?= htmlspecialchars($lesson['title']) ?></h5>
                                <p><?= htmlspecialchars($lesson['content']) ?></p>
                                
                                <div class="interactive-choices">
                                    <?php 
                                    $choices = json_decode($lesson['choices'], true);
                                    foreach ($choices as $index => $choice): ?>
                                        <div class="interactive-choice" 
                                             onclick="selectChoice(this, <?= $lesson['id'] ?>, '<?= $choice ?>', '<?= $lesson['correct_answer'] ?>')">
                                            <?= htmlspecialchars($choice) ?>
                                        </div>
                                    <?php endforeach; ?>
                                </div>
                                
                                <div class="interactive-feedback" id="feedback-<?= $lesson['id'] ?>"></div>
                            </div>
                        </div>
                    <?php endwhile; ?>
                </div>
            <?php else: ?>
                <div class="alert alert-info">
                    لا توجد دروس تفاعلية متاحة حالياً.
                </div>
            <?php endif; ?>
        </div>
       <div id="quizzes" class="tab-pane fade">
    <h5 class="mb-3">📑 قائمة الاختبارات</h5>
    
    <?php 
    // إعادة تعيين مؤشر النتائج والتأكد من وجود بيانات
    $quizzes_query->data_seek(0);
    
    if ($quizzes_query && $quizzes_query->num_rows > 0): 
        while ($quiz = $quizzes_query->fetch_assoc()): 
            $has_result = isset($quiz['student_score']) && !is_null($quiz['student_score']);
            $options = json_decode($quiz['options'] ?? '[]', true); // افتراضي مصفوفة فارغة إذا كانت القيمة null
            
            // التأكد من أن options هي مصفوفة قبل استخدامها
            if (!is_array($options)) {
                $options = [];
            }
    ?>
        <div class="quiz-card mb-4 p-3 border rounded bg-white">
            <div class="d-flex justify-content-between align-items-start">
                <div>
                    <h5><?= htmlspecialchars($quiz['question'] ?? '') ?></h5>
                    <p class="text-muted">الوحدة: <?= htmlspecialchars($quiz['unit_title'] ?? '') ?></p>
                </div>
                
                <?php if($has_result): ?>
                    <span class="badge bg-<?= ($quiz['student_score'] > 0) ? 'success' : 'danger' ?>">
                        النتيجة: <?= $quiz['student_score'] ?> / 1
                    </span>
                <?php endif; ?>
            </div>
            
            <?php if($has_result): ?>
                <div class="quiz-result mt-2 p-2 bg-light rounded">
                    <p class="mb-1">
                        <i class="fas fa-calendar-check"></i> 
                        تم الإكمال في: <?= date('Y-m-d', strtotime($quiz['completed_at'] ?? '')) ?>
                    </p>
                    <div class="progress" style="height: 10px;">
                        <div class="progress-bar bg-<?= ($quiz['student_score'] > 0) ? 'success' : 'danger' ?>" 
                             style="width: <?= ($quiz['student_score'] * 100) ?>%"></div>
                    </div>
                </div>
            <?php else: ?>
                <div class="quiz-options mt-3">
                    <?php if (!empty($options)): ?>
                        <?php foreach($options as $key => $option): ?>
                            <div class="form-check mb-2">
                                <input class="form-check-input" type="radio" 
                                       name="quiz_<?= $quiz['id'] ?>" 
                                       id="quiz_<?= $quiz['id'] ?>_option_<?= $key ?>"
                                       value="<?= $key ?>">
                                <label class="form-check-label" for="quiz_<?= $quiz['id'] ?>_option_<?= $key ?>">
                                    <?= htmlspecialchars($option) ?>
                                </label>
                            </div>
                        <?php endforeach; ?>
                    <?php else: ?>
                        <div class="alert alert-warning">لا توجد خيارات متاحة لهذا الاختبار</div>
                    <?php endif; ?>
                    
                    <?php if (!empty($options)): ?>
                        <button class="btn btn-primary btn-sm mt-2 submit-quiz" 
                                data-quiz-id="<?= $quiz['id'] ?>"
                                data-correct="<?= htmlspecialchars($quiz['correct_answer'] ?? '') ?>">
                            تقديم الإجابة
                        </button>
                    <?php endif; ?>
                    
                    <div class="quiz-feedback mt-2" id="quiz-feedback-<?= $quiz['id'] ?>" style="display: none;"></div>
                </div>
            <?php endif; ?>
        </div>
    <?php 
        endwhile; 
    else: 
    ?>
        <div class="alert alert-info">
            لا توجد اختبارات متاحة حالياً.
        </div>
    <?php endif; ?>
</div>

        <<div id="challenges" class="tab-pane fade">
    <h5 class="mb-3">🎯 التحديات الحالية</h5>
    
    <?php 
    // إعادة تعيين مؤشر الاستعلام لقراءة البيانات من البداية
    $challenges_query->data_seek(0);
    
    if ($challenges_query->num_rows > 0): 
        while ($challenge = $challenges_query->fetch_assoc()): 
    ?>
        <div class="mb-3 p-3 border rounded bg-white">
            <h6><?= htmlspecialchars($challenge['title']) ?></h6>
            <p><?= htmlspecialchars($challenge['description']) ?></p>
            <p><strong>الهدف:</strong> <?= htmlspecialchars($challenge['goal']) ?> | 
               <strong>النوع:</strong> <?= htmlspecialchars($challenge['type']) ?></p>
            <p><strong>الفترة:</strong> <?= $challenge['start_date'] ?> → <?= $challenge['end_date'] ?></p>

            <?php
            // استعلام لجلب الملف المرتبط بالتحدي الحالي
            $challenge_id = $challenge['id'];
            $file_result = $conn->query("SELECT * FROM challenge_files WHERE challenge_id = $challenge_id LIMIT 1");

            if ($file_result && $file_result->num_rows > 0):
                $file = $file_result->fetch_assoc();
            ?>
                <p>
                    📄 <a href="<?= htmlspecialchars($file['file_path']) ?>" target="_blank" class="btn btn-sm btn-outline-primary">
                        تحميل ملف التحدي (<?= htmlspecialchars($file['file_name']) ?>)
                    </a>
                </p>
            <?php endif; ?>
        </div>
    <?php 
        endwhile; 
    else: 
    ?>
        <div class="alert alert-info">
            لا توجد تحديات متاحة حالياً.
        </div>
    <?php endif; ?>
</div>



       <div id="account" class="tab-pane fade">
    <h5 class="mb-3">🧑 تعديل الحساب</h5>
    
    <?php if(isset($_SESSION['profile_update_message'])): ?>
        <div class="alert alert-<?= $_SESSION['profile_update_status'] ? 'success' : 'danger' ?> alert-dismissible fade show">
            <?= $_SESSION['profile_update_message'] ?>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <?php unset($_SESSION['profile_update_message'], $_SESSION['profile_update_status']); ?>
    <?php endif; ?>
    
    <form action="update_profile.php" method="post" enctype="multipart/form-data">
        <div class="row">
            <div class="col-md-6">
                <div class="mb-3">
                    <label class="form-label">الاسم الكامل</label>
                    <input type="text" name="name" class="form-control" 
                           value="<?= htmlspecialchars($name) ?>" required>
                </div>
                
                <div class="mb-3">
                    <label class="form-label">البريد الإلكتروني</label>
                    <input type="email" name="email" class="form-control" 
                           value="<?= htmlspecialchars($email) ?>" required>
                </div>
                
                <div class="mb-3">
                    <label class="form-label">كلمة المرور الجديدة (اتركه فارغاً إذا لم ترغب بالتغيير)</label>
                    <input type="password" name="password" class="form-control">
                </div>
                
                <div class="mb-3">
                    <label class="form-label">تأكيد كلمة المرور الجديدة</label>
                    <input type="password" name="confirm_password" class="form-control">
                </div>
            </div>
            
            <div class="col-md-6">
                <div class="mb-3 text-center">
                    <label class="form-label">الصورة الشخصية</label>
                    <div class="profile-picture mb-2">
                        <?php
                        $profile_pic = "uploads/profiles/$student_id.jpg";
                        if(file_exists($profile_pic)) {
                            echo '<img src="'.$profile_pic.'?'.time().'" class="rounded-circle" width="150" height="150">';
                        } else {
                            echo '<i class="fas fa-user-circle" style="font-size: 150px; color: #ccc;"></i>';
                        }
                        ?>
                    </div>
                    <input type="file" name="profile_picture" class="form-control" accept="image/jpeg,image/png">
                    <small class="text-muted">الصيغ المسموحة: JPG, PNG (الحجم الأقصى 2MB)</small>
                </div>
            </div>
        </div>
        
        <div class="d-grid gap-2 d-md-flex justify-content-md-end">
            <button type="submit" class="btn btn-primary">
                <i class="fas fa-save"></i> حفظ التعديلات
            </button>
            <button type="reset" class="btn btn-outline-secondary">
                <i class="fas fa-undo"></i> إعادة تعيين
            </button>
        </div>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
     // دالة لاختيار الإجابة
function selectChoice(element, lessonId, selectedAnswer, correctAnswer) {
    // إزالة التحديد من جميع الخيارات
    const choices = document.querySelectorAll(`#interactive-lesson-${lessonId} .interactive-choice`);
    choices.forEach(choice => {
        choice.classList.remove('selected');
    });
    
    // تحديد الخيار المختار
    element.classList.add('selected');
    
    // التحقق من الإجابة
    const feedbackDiv = document.getElementById(`feedback-${lessonId}`);
    feedbackDiv.style.display = 'block';
    
    if (selectedAnswer === correctAnswer) {
        feedbackDiv.className = 'interactive-feedback correct';
        feedbackDiv.innerHTML = '<i class="fas fa-check-circle"></i> إجابة صحيحة! أحسنت!';
    } else {
        feedbackDiv.className = 'interactive-feedback incorrect';
        feedbackDiv.innerHTML = '<i class="fas fa-times-circle"></i> إجابة خاطئة. الجواب الصحيح هو: ' + correctAnswer;
    }
}

// تفعيل تبويب "تفاعل معنا" إذا كان هناك معلمة في الرابط
document.addEventListener('DOMContentLoaded', function() {
    const urlParams = new URLSearchParams(window.location.search);
    if (urlParams.get('tab') === 'interactive') {
        const tab = new bootstrap.Tab(document.querySelector('#studentTabs .nav-link[href="#interactive"]'));
        tab.show();
    }
});

// JavaScript لتحسين التفاعل (مثال: تتبع التقدم)
const studentTabs = document.getElementById('studentTabs');
const unitTabs = document.querySelectorAll('.nav-item a[data-bs-toggle="tab"]');

unitTabs.forEach(tab => {
    tab.addEventListener('shown.bs.tab', event => {
        const targetId = event.target.getAttribute('href');
        if (targetId === '#units') {
            // يمكنك هنا إضافة كود لتحديث الواجهة عند عرض الوحدات، إذا لزم الأمر
        }
    });
});

document.addEventListener('DOMContentLoaded', function() {
    // معالجة إرسال الإجابات
    document.querySelectorAll('.submit-quiz').forEach(button => {
        button.addEventListener('click', function() {
            const quizId = this.getAttribute('data-quiz-id');
            const correctAnswer = this.getAttribute('data-correct');
            const selectedOption = document.querySelector(`input[name="quiz_${quizId}"]:checked`);
            
            if (!selectedOption) {
                alert('الرجاء اختيار إجابة قبل التقديم');
                return;
            }
            
            // الحصول على نص الإجابة المختارة
            const selectedLabel = document.querySelector(`label[for="quiz_${quizId}_option_${selectedOption.value}"]`).textContent.trim();
            const feedbackDiv = document.getElementById(`quiz-feedback-${quizId}`);
            const quizCard = this.closest('.quiz-card');
            
            // المقارنة بين الإجابات
            const isCorrect = selectedLabel === correctAnswer.trim();
            const score = isCorrect ? 1 : 0;
            
            // حساب التقييم
            const evaluation = score === 1 ? 'ممتاز!' : 'يحتاج تحسين';
            const evaluationClass = score === 1 ? 'text-success' : 'text-warning';
            const progressColor = score === 1 ? 'success' : 'warning';
            
            // إنشاء عنصر لعرض الجملة الصحيحة بشكل دائم
            const correctAnswerBox = document.createElement('div');
            correctAnswerBox.className = 'correct-answer-box mt-3 p-3 bg-light border-start border-4 border-success';
            correctAnswerBox.innerHTML = `
                <h6 class="text-success"><i class="fas fa-lightbulb"></i> الجملة الصحيحة:</h6>
                <p class="mb-0 fw-bold">${correctAnswer}</p>
            `;
            
            // عرض النتيجة مع تفاصيل أوضح
            feedbackDiv.innerHTML = isCorrect 
                ? '<div class="alert alert-success"><i class="fas fa-check-circle"></i> إجابة صحيحة! أحسنت!</div>' 
                : `<div class="alert alert-danger">
                       <i class="fas fa-times-circle"></i> إجابة خاطئة! 
                       <p class="mb-0 mt-2">إجابتك كانت: <span class="text-danger fw-bold">${selectedLabel}</span></p>
                   </div>`;
            
            feedbackDiv.style.display = 'block';
            
            // إضافة تقرير الأداء
            const performanceReport = document.createElement('div');
            performanceReport.className = 'performance-report mt-3 p-3 rounded';
            performanceReport.innerHTML = `
                <h6><i class="fas fa-chart-bar"></i> تقرير الأداء:</h6>
                <div class="progress mb-2" style="height: 20px;">
                    <div class="progress-bar bg-${progressColor}" 
                         style="width: ${score * 100}%">${score * 100}%</div>
                </div>
                <p class="mb-1"><strong>التقييم:</strong> <span class="${evaluationClass}">${evaluation}</span></p>
                <p class="mb-0"><strong>نصيحة:</strong> ${score === 1 ? 'أحسنت! استمر في التميز' : 'راجع الدرس وحاول مرة أخرى'}</p>
            `;
            
            feedbackDiv.appendChild(correctAnswerBox);
            feedbackDiv.appendChild(performanceReport);
            
            // تعطيل العناصر بعد الإجابة
            this.disabled = true;
            quizCard.querySelectorAll('input[type="radio"]').forEach(option => {
                option.disabled = true;
            });
            
            // إرسال النتيجة إلى الخادم
            fetch('save_quiz_result.php', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: `quiz_id=${quizId}&score=${score}`
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    // تحديث واجهة المستخدم
                    const quizHeader = quizCard.querySelector('.d-flex');
                    if (quizHeader) {
                        const resultBadge = document.createElement('span');
                        resultBadge.className = `badge bg-${isCorrect ? 'success' : 'danger'} me-2`;
                        resultBadge.innerHTML = `النتيجة: ${score} / 1`;
                        quizHeader.appendChild(resultBadge);
                        
                        const evaluationBadge = document.createElement('span');
                        evaluationBadge.className = `badge ${evaluationClass}`;
                        evaluationBadge.innerHTML = evaluation;
                        quizHeader.appendChild(evaluationBadge);
                        
                        // تظليل الإجابة الصحيحة باللون الأخضر
                        quizCard.querySelectorAll('.form-check-label').forEach(label => {
                            if (label.textContent.trim() === correctAnswer.trim()) {
                                label.classList.add('text-success', 'fw-bold');
                                label.innerHTML = `<i class="fas fa-check-circle"></i> ${label.innerHTML}`;
                            }
                        });
                    }
                } else {
                    feedbackDiv.innerHTML += '<div class="alert alert-warning mt-2">حدث خطأ في حفظ النتيجة</div>';
                }
            })
            .catch(error => {
                feedbackDiv.innerHTML += '<div class="alert alert-warning mt-2">حدث خطأ في الاتصال بالخادم</div>';
            });
        });
    });
});
</script>
</body>
</html>

