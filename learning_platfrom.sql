-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 11, 2025 at 02:19 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `learning_platform`
--

-- --------------------------------------------------------

--
-- Table structure for table `challenges`
--

CREATE TABLE `challenges` (
  `id` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `type` enum('اختبارات','قراءة','مشروع') NOT NULL,
  `goal` int(11) DEFAULT NULL,
  `progress` int(11) DEFAULT 0,
  `user_id` int(11) DEFAULT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `challenges`
--

INSERT INTO `challenges` (`id`, `title`, `description`, `type`, `goal`, `progress`, `user_id`, `start_date`, `end_date`) VALUES
(5, 'اقرأ معنا كل يوم', 'قراءة قصص قصيرة باللغة الانكليزية للتقوية', 'قراءة', 5, 0, 1, '2025-05-16 00:00:00', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `challenge_files`
--

CREATE TABLE `challenge_files` (
  `id` int(11) NOT NULL,
  `challenge_id` int(11) DEFAULT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `file_path` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `challenge_files`
--

INSERT INTO `challenge_files` (`id`, `challenge_id`, `file_name`, `file_path`) VALUES
(5, 5, 'short_story.pdf', 'uploads/challenges/682092ace3ee9_short_story.pdf');

-- --------------------------------------------------------

--
-- Table structure for table `interactive_lessons`
--

CREATE TABLE `interactive_lessons` (
  `id` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `level` enum('beginner','intermediate','advanced') NOT NULL,
  `type` enum('multiple_choice','matching','translation','flashcard') NOT NULL,
  `content` text DEFAULT NULL,
  `choices` text DEFAULT NULL,
  `correct_answer` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `interactive_lessons`
--

INSERT INTO `interactive_lessons` (`id`, `title`, `level`, `type`, `content`, `choices`, `correct_answer`, `created_at`) VALUES
(1, 'معنى كلمة Book', 'beginner', 'multiple_choice', 'What is the meaning of the word “Book”?', '[\"كتاب\",\"قلم\",\"ورقة\",\"نافذة\"]', 'كتاب', '2025-04-25 17:21:56'),
(2, 'أكمل الجملة: They ____ at home.', 'beginner', 'multiple_choice', 'They ____ at home.', '[\"is\",\"are\",\"am\",\"be\"]', 'are', '2025-04-25 17:21:56'),
(3, 'اختر الترجمة الصحيحة لـ “Good night.”', 'beginner', 'multiple_choice', 'Choose the correct translation for “Good night.”', '[\"صباح الخير\",\"مساء الخير\",\"تصبح على خير\",\"مرحبا\"]', 'تصبح على خير', '2025-04-25 17:21:56'),
(4, 'جمع كلمة “mouse”', 'beginner', 'multiple_choice', 'What is the plural form of “mouse”?', '[\"mouses\",\"mice\",\"mousees\",\"meese\"]', 'mice', '2025-04-25 17:21:56'),
(5, 'أي جملة صحيحة؟', 'beginner', 'multiple_choice', 'Which sentence is correct?', '[\"He have a car.\",\"He has a car.\",\"He haves a car.\",\"He having a car.\"]', 'He has a car.', '2025-04-25 17:21:56'),
(6, 'ما عكس كلمة “hot”?', 'beginner', 'multiple_choice', 'What is the opposite of “hot”?', '[\"warm\",\"cold\",\"heat\",\"boiling\"]', 'cold', '2025-04-25 17:21:56'),
(17, 'Present Simple Tense', 'beginner', '', 'Which sentence is in the Present Simple tense?', '[\"I am eating dinner.\", \"I eat dinner at 7 pm every day.\", \"I have eaten dinner.\", \"I will eat dinner later.\"]', 'I eat dinner at 7 pm every day.', '2025-05-11 11:02:49'),
(18, 'Past Continuous Tense', 'intermediate', '', 'Complete the sentence: While I ______ TV, the phone rang.', '[\"watched\", \"was watching\", \"had watched\", \"have watched\"]', 'was watching', '2025-05-11 11:02:49'),
(19, 'Future Perfect Tense', 'advanced', '', 'By next year, I ______ my degree.', '[\"will complete\", \"will be completing\", \"will have completed\", \"complete\"]', 'will have completed', '2025-05-11 11:02:49'),
(20, 'Present Perfect Continuous', 'intermediate', '', 'She ______ for three hours.', '[\"has been studying\", \"studies\", \"is studying\", \"was studying\"]', 'has been studying', '2025-05-11 11:02:49'),
(21, 'Mixed Tenses Practice', 'advanced', '', 'If it ______ tomorrow, we ______ the picnic.', '[\"will rain/cancel\", \"rains/will cancel\", \"is raining/cancel\", \"has rained/would cancel\"]', 'rains/will cancel', '2025-05-11 11:02:49'),
(22, 'Comparative Adjectives', 'beginner', '', 'What is the correct comparative form of \"big\"?', '[\"bigger\", \"more big\", \"biggest\", \"biger\"]', 'bigger', '2025-05-11 11:02:49'),
(23, 'Superlative Adjectives', 'beginner', '', 'What is the superlative form of \"good\"?', '[\"gooder\", \"more good\", \"best\", \"better\"]', 'best', '2025-05-11 11:02:49'),
(24, 'Order of Adjectives', 'intermediate', '', 'Which is the correct order of adjectives?', '[\"a big red wooden box\", \"a wooden red big box\", \"a red big wooden box\", \"a red wooden big box\"]', 'a big red wooden box', '2025-05-11 11:02:49'),
(25, 'Adjective vs Adverb', 'intermediate', '', 'Choose the correct sentence:', '[\"She sings beautiful.\", \"She sings beautifully.\", \"She beautiful sings.\", \"She beautifully sings.\"]', 'She sings beautifully.', '2025-05-11 11:02:49'),
(26, 'Participial Adjectives', 'advanced', '', 'Which sentence uses a participial adjective correctly?', '[\"The bored student yawned.\", \"The boring student yawned.\", \"The student was bored by the lecture.\", \"The lecture was bored.\"]', 'The bored student yawned.', '2025-05-11 11:02:49'),
(27, 'Direct to Reported Speech', 'intermediate', '', 'Convert to reported speech: \"I am happy,\" she said.', '[\"She said she is happy.\", \"She said she was happy.\", \"She said she had been happy.\", \"She said she has been happy.\"]', 'She said she was happy.', '2025-05-11 11:02:49'),
(28, 'Reported Questions', 'intermediate', '', 'Convert to reported speech: \"Where do you live?\" he asked.', '[\"He asked where I lived.\", \"He asked where do I live.\", \"He asked where I live.\", \"He asked where did I live.\"]', 'He asked where I lived.', '2025-05-11 11:02:49'),
(29, 'Reported Commands', 'intermediate', '', 'Convert to reported speech: \"Close the door,\" she told me.', '[\"She told me close the door.\", \"She told me to close the door.\", \"She told me I should close the door.\", \"She told me that I closed the door.\"]', 'She told me to close the door.', '2025-05-11 11:02:49'),
(30, 'Tense Changes in Reported Speech', 'advanced', '', 'Which tense changes correctly in reported speech?', '[\"Present simple → Past simple\", \"Past simple → Past perfect\", \"Present perfect → Past perfect\", \"All of the above\"]', 'All of the above', '2025-05-11 11:02:49'),
(31, 'Mixed Reported Speech', 'advanced', '', 'Convert to reported speech: \"I will call you tomorrow,\" he promised.', '[\"He promised he would call me the next day.\", \"He promised he will call me tomorrow.\", \"He promised he called me tomorrow.\", \"He promised he would call me tomorrow.\"]', 'He promised he would call me the next day.', '2025-05-11 11:02:49'),
(32, 'Who vs Whom', 'intermediate', '', 'Complete the sentence: The woman ______ you met is my aunt.', '[\"who\", \"whom\", \"which\", \"whose\"]', 'whom', '2025-05-11 11:02:49'),
(33, 'Which vs That', 'intermediate', '', 'Complete the sentence: The book, ______ is on the table, is mine.', '[\"which\", \"that\", \"who\", \"what\"]', 'which', '2025-05-11 11:02:49'),
(34, 'Relative Pronouns for Things', 'beginner', '', 'Complete the sentence: The car ______ I bought is very fast.', '[\"who\", \"whom\", \"which\", \"whose\"]', 'which', '2025-05-11 11:02:49'),
(35, 'Omitting Relative Pronouns', 'advanced', '', 'In which sentence can you omit the relative pronoun?', '[\"The man who lives next door is a doctor.\", \"The book that I bought is interesting.\", \"The house which was built in 1900 is historic.\", \"The woman whose car was stolen is upset.\"]', 'The book that I bought is interesting.', '2025-05-11 11:02:49'),
(36, 'Mixed Relative Pronouns', 'advanced', '', 'Complete the sentence: The scientist ______ discovery changed medicine ______ you met yesterday won the Nobel Prize.', '[\"whose/whom\", \"who\'s/which\", \"whom/whose\", \"which/who\"]', 'whose/whom', '2025-05-11 11:02:49'),
(37, 'Time Prepositions', 'beginner', '', 'Complete the sentence: I have class ______ 9 am ______ Mondays.', '[\"at/on\", \"in/at\", \"on/in\", \"at/in\"]', 'at/on', '2025-05-11 11:02:49'),
(38, 'Place Prepositions', 'beginner', '', 'Complete the sentence: The book is ______ the table ______ the kitchen.', '[\"on/in\", \"in/on\", \"at/on\", \"on/at\"]', 'on/in', '2025-05-11 11:02:49'),
(39, 'Prepositional Verbs', 'intermediate', '', 'Complete the sentence: She insisted ______ paying for dinner.', '[\"in\", \"on\", \"at\", \"for\"]', 'on', '2025-05-11 11:02:49'),
(40, 'Adjective + Preposition', 'intermediate', '', 'Complete the sentence: I\'m afraid ______ spiders.', '[\"from\", \"of\", \"with\", \"about\"]', 'of', '2025-05-11 11:02:49'),
(41, 'Mixed Prepositions', 'advanced', '', 'Complete the sentence: He apologized ______ being late ______ the meeting.', '[\"for/to\", \"about/for\", \"for/for\", \"to/about\"]', 'for/to', '2025-05-11 11:02:49');

-- --------------------------------------------------------

--
-- Table structure for table `languages`
--

CREATE TABLE `languages` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `code` varchar(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `languages`
--

INSERT INTO `languages` (`id`, `name`, `code`) VALUES
(2, 'اللغة الانكليزية', 'en'),
(3, 'اللغة الهندية', 'hindi'),
(4, 'اللغة الاسبانية', 'sp');

-- --------------------------------------------------------

--
-- Table structure for table `lessons`
--

CREATE TABLE `lessons` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `level` varchar(20) DEFAULT NULL,
  `content` text NOT NULL,
  `teacher_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `unit_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `lessons`
--

INSERT INTO `lessons` (`id`, `title`, `level`, `content`, `teacher_id`, `created_at`, `unit_id`) VALUES
(1, 'Past Simple Tense - الزمن الماضي البسيط', NULL, '<h3>الزمن الماضي البسيط (Past Simple)</h3>\r\n<p>يستخدم الزمن الماضي البسيط للتعبير عن:</p>\r\n<ul>\r\n    <li>أحداث وقعت في الماضي وانتهت</li>\r\n    <li>عادات في الماضي</li>\r\n    <li>أحداث متتالية في الماضي</li>\r\n</ul>\r\n\r\n<h4>قواعد تكوين الزمن الماضي البسيط:</h4>\r\n<p>1. الأفعال المنتظمة: نضيف ed للفعل</p>\r\n<ul>\r\n    <li>work → worked</li>\r\n    <li>play → played</li>\r\n    <li>study → studied</li>\r\n</ul>\r\n\r\n<p>2. الأفعال الشاذة: لها صيغ خاصة</p>\r\n<ul>\r\n    <li>go → went</li>\r\n    <li>eat → ate</li>\r\n    <li>write → wrote</li>\r\n</ul>\r\n\r\n<h4>أمثلة:</h4>\r\n<ul>\r\n    <li>I visited my grandparents last week.</li>\r\n    <li>She studied English for three years.</li>\r\n    <li>They went to the cinema yesterday.</li>\r\n</ul>', 1, '2025-05-08 11:19:08', 1),
(2, 'Present Continuous Tense - الزمن المضارع المستمر', NULL, '<h3>الزمن المضارع المستمر (Present Continuous)</h3>\r\n<p>يستخدم الزمن المضارع المستمر للتعبير عن:</p>\r\n<ul>\r\n    <li>أحداث تحدث الآن</li>\r\n    <li>أحداث مؤقتة</li>\r\n    <li>خطط مستقبلية محددة</li>\r\n</ul>\r\n\r\n<h4>قواعد تكوين الزمن المضارع المستمر:</h4>\r\n<p>am/is/are + الفعل + ing</p>\r\n\r\n<h4>أمثلة:</h4>\r\n<ul>\r\n    <li>I am studying English now.</li>\r\n    <li>She is cooking dinner at the moment.</li>\r\n    <li>They are playing football in the garden.</li>\r\n</ul>\r\n\r\n<h4>ملاحظات هامة:</h4>\r\n<ul>\r\n    <li>بعض الأفعال لا تأخذ ing مثل: know, like, love</li>\r\n    <li>نضيف ing بعد حذف e في نهاية الفعل مثل: write → writing</li>\r\n    <li>نضاعف الحرف الأخير في بعض الأفعال مثل: run → running</li>\r\n</ul>', 1, '2025-05-08 11:19:08', 1),
(3, 'Articles - أدوات التعريف والنكرة', NULL, '<h3>أدوات التعريف والنكرة (Articles)</h3>\r\n<p>هناك نوعان من الأدوات:</p>\r\n\r\n<h4>1. أدوات النكرة (a/an):</h4>\r\n<ul>\r\n    <li>تستخدم قبل الأسماء المفردة المعدودة</li>\r\n    <li>a: تستخدم قبل الكلمات التي تبدأ بحرف ساكن</li>\r\n    <li>an: تستخدم قبل الكلمات التي تبدأ بحرف متحرك</li>\r\n</ul>\r\n\r\n<h4>أمثلة:</h4>\r\n<ul>\r\n    <li>a book, a car, a university</li>\r\n    <li>an apple, an elephant, an hour</li>\r\n</ul>\r\n\r\n<h4>2. أداة التعريف (the):</h4>\r\n<ul>\r\n    <li>تستخدم قبل الأسماء المعرفة</li>\r\n    <li>تستخدم قبل الأسماء الفريدة</li>\r\n    <li>تستخدم قبل الأسماء التي تم ذكرها سابقاً</li>\r\n</ul>\r\n\r\n<h4>أمثلة:</h4>\r\n<ul>\r\n    <li>the sun, the moon, the earth</li>\r\n    <li>the book I bought yesterday</li>\r\n    <li>the United States</li>\r\n</ul>', 1, '2025-05-08 11:19:08', 1),
(4, 'Personal Pronouns - الضمائر الشخصية', NULL, '<h3>الضمائر الشخصية (Personal Pronouns)</h3>\r\n<p>الضمائر الشخصية هي كلمات تستخدم بدلاً من الأسماء.</p>\r\n\r\n<h4>الضمائر في حالة الفاعل:</h4>\r\n<ul>\r\n    <li>I - أنا</li>\r\n    <li>You - أنت/أنتم</li>\r\n    <li>He - هو</li>\r\n    <li>She - هي</li>\r\n    <li>It - هو/هي (لغير العاقل)</li>\r\n    <li>We - نحن</li>\r\n    <li>They - هم/هن</li>\r\n</ul>\r\n\r\n<h4>الضمائر في حالة المفعول به:</h4>\r\n<ul>\r\n    <li>Me - لي</li>\r\n    <li>You - لك/لكم</li>\r\n    <li>Him - له</li>\r\n    <li>Her - لها</li>\r\n    <li>It - له/لها</li>\r\n    <li>Us - لنا</li>\r\n    <li>Them - لهم/لهن</li>\r\n</ul>\r\n\r\n<h4>أمثلة:</h4>\r\n<ul>\r\n    <li>I love you.</li>\r\n    <li>She gave him a book.</li>\r\n    <li>They helped us.</li>\r\n</ul>', 1, '2025-05-08 11:19:08', 1),
(5, 'Adjectives - الصفات', NULL, '<h3>الصفات (Adjectives)</h3>\r\n<p>الصفات هي كلمات تصف الأسماء وتخبرنا المزيد عنها.</p>\r\n\r\n<h4>أنواع الصفات:</h4>\r\n<ul>\r\n    <li>صفات الحجم: big, small, huge</li>\r\n    <li>صفات اللون: red, blue, green</li>\r\n    <li>صفات العمر: young, old, new</li>\r\n    <li>صفات الملمس: soft, hard, smooth</li>\r\n    <li>صفات الشخصية: kind, friendly, smart</li>\r\n</ul>\r\n\r\n<h4>قواعد استخدام الصفات:</h4>\r\n<ul>\r\n    <li>تأتي الصفة قبل الاسم: a beautiful flower</li>\r\n    <li>يمكن أن تأتي بعد أفعال معينة: The flower is beautiful</li>\r\n    <li>يمكن استخدام أكثر من صفة: a big red car</li>\r\n</ul>\r\n\r\n<h4>أمثلة:</h4>\r\n<ul>\r\n    <li>She has a beautiful voice.</li>\r\n    <li>The weather is cold today.</li>\r\n    <li>They live in a big house.</li>\r\n</ul>', 1, '2025-05-08 11:19:08', 1),
(23, 'الكلام المنقول(Reported Speech)', NULL, 'عادةً ما يتم استخدام الكلام المنقول أو غير المباشر لنقل الكلام عن شخص الى شخص اخر وفى الغالب يتم الحديث بصيغة الماضي.\r\nExample:\r\n(Indirect speech)\r\n(Direct speech)\r\nShe said that she had seen him.قالت إنها قد رأته\r\nShe said, “I saw him.”  قالت، “رايته”.\r\nHe said (that) john was angry.\r\nهو قال (أن) جون كان غاضب\r\nJohn is angry.  جون غاضب', 1, '2025-05-10 13:19:50', 2),
(24, 'تحويل الكلام المباشر الى الغير مباشر', NULL, 'هناك بعض الخطوات يجب اتباعها عند تحويل الكلام المباشر الى غير مباشر\r\nنذكر اسم الشخص او نقوم بتحويل فعل القول\r\nSay= say,  say to= tell,  said= said,  said to= told\r\nيتم حذف الاقواس ونضع That (المقصود به أن)\r\nيتم اختيار الضمير المناسب للشخص (القائل) سواء كان مذكر أو مؤنث أو جمع\r\nتحويل الزمن إلى الماضي.\r\nفي أزمنة الكلام المنقول، تتغير الضمائر والعبارات الظرفية غالبًا (ولكن ليس دائمًا). وسيتم عرض كيفية تحويل الأزمنة والضمائر لمساعدتك في تحويل الكلام الغير مباشر.', 1, '2025-05-11 10:42:59', 2),
(25, 'تحويل الأزمنة في الكلام الغير مباشر.', NULL, 'يحول إلى: Past simple ماضي بسيط\r\nPresent simple  مضارع بسيط\r\nPast continuous ماضي مستمر\r\nPresent continuous  مضارع مستمر\r\nPast perfect ماضي تام\r\nPresent perfect مضارع تام\r\n\r\nPast perfect ماضي تام\r\n\r\nPast simple ماضي بسيط\r\nPast perfect ماضي تام\r\nPast perfect ماضي تام\r\nExample:\r\nReported Speech كلام غير مباشر\r\nDirect speech كلام مباشر\r\n\r\nTense الزمن\r\n\r\nTom told me that he liked coffee.\r\n”.Tom said to me “I like coffee\r\nمضارع بسيط\r\nJohn said that he was repairing the car.\r\n”.John said, “I am repairing the car\r\nمضارع مستمر\r\n\r\nMum said that he had eaten his dinner.\r\n\r\n”.Mum said, “he ate his dinner\r\nماضي بسيط\r\nMy wife told me that she had been shopping.\r\n”.My wife said, “I have been shopping\r\nمضارع تام\r\nThe boy said that he had just finished the test.\r\n”.The boy said, “I just finished the test\r\nماضي تام\r\n\r\nThey stuttered that they had been waiting for her call.\r\nThey stuttered, “We have been waiting for your call.”\r\nمضارع تام مستمر\r\nHe explained that he had been working.\r\n”.He explained, “I was working\r\nماضي مستمر', 1, '2025-05-11 10:44:25', 2),
(26, 'الكلام المباشر direct speech', NULL, 'ThatHe said that he liked that.\r\n\r\nThis’. He said, ‘I like this\r\n\r\nThoseHe asked how much those were_._\r\n\r\nThese’?he asked ‘How much are these\r\n\r\nThereShe shouted that it was there_._\r\n\r\nHere’!she shouted ‘Here it is\r\n\r\nThenThe child screamed that he wanted it then_._\r\n\r\nNow.’screamed the child ‘I want it now\r\n\r\nThe previous day, the day beforeBill said that he had been upset the day before_._\r\n\r\nYesterday.‘I was upset yesterday,’ said Bill\r\n\r\nThe next dayFred promised that he would tell me the next day.\r\n\r\nTomorrow.‘I will tell you tomorrow,’ promised Fred\r\n\r\nBeforeThe T Rex said that it had happened long before.\r\n\r\nAgo‘.It happened long ago,’ said the T Rex\r\n\r\nبالإضافة الى تحويل هذه الأفعال المساعدة عند التحويل الى الكلام الغير مباشر كالاتي:\r\nWould\r\n\r\nwill\r\n\r\ncould\r\n\r\ncan\r\n\r\nMust or had to\r\n\r\nMust / have to\r\n\r\nmight\r\n\r\nMay / might\r\n\r\nshould\r\n\r\nShould\r\n\r\nOught to\r\n\r\nOught to', 1, '2025-05-11 10:46:39', 2),
(27, 'مقدمة في ضمائر الوصل', NULL, 'ضمائر الوصل في اللغة الإنجليزية (Relative pronouns) هي مجموعة من الكلمات تستخدم لوصل جملة رئيسية بجملة أخرى توضح أو تزيد من تفاصيلها. تستخدم هذه الضمائر لتجنب تكرار الاسم الذي تتحدث عنه الجملة الرئيسية، ويشمل هذه الضمائر: who, which, that, whom, whose, where.\r\n1. who: تستخدم للإشارة إلى الأشخاص الذين يكونون فاعل في الجملة.\r\nمثال: The woman who called me yesterday was very kind. (المرأة التي اتصلت بي بالأمس كانت لطيفة جداً.)\r\n2. whom: تستخدم للإشارة إلى الأشخاص الذين يكونون مفعول به في الجملة، وهي أكثر رسمية من who.\r\nمثال: The man whom I saw in the store was tall. (الرجل الذي رأيته في المتجر كان طويلاً.)\r\n3. which: تستخدم للإشارة إلى الأشياء أو الحيوانات أو الأفكار التي تكون فاعل أو مفعول به في الجملة.\r\nمثال: The car which you bought is very fast. (السيارة التي اشتريتها سريعة جداً.)\r\n4. that: تستخدم للإشارة إلى الأشخاص والأشياء والأفكار على حد سواء، وتستخدم بدلاً من who و which في بعض الأحيان، خاصة في الكلام العامي.\r\nمثال: The book that I borrowed from you was interesting. (الكتاب الذي استعرتُه منك كان مثيراً للاهتمام.)\r\n5. whose: تستخدم للإشارة إلى الملكية.\r\nمثال: The boy whose dog won the competition was very happy. (الطفل الذي فازت كلبه في المسابقة كان سعيداً جداً.)\r\n6. where: تستخدم للإشارة إلى الأماكن.\r\nمثال: The park where we often go is very beautiful. (الحديقة التي نمضي بها كثيراً جميلة جداً.)', 1, '2025-05-11 10:47:39', 3),
(28, 'استعمال ضمائر الوصل', NULL, 'ذكر أن الوظيفة الأساسية للضمائر بكافة أنواعها هي منع التكرار في الجملة، كما قلنا أعلاه تُستعمل ضمائر الملكية لوصل جملتين أو لإعطاء معلومة إضافية حول إسم معين سواء كان إنسان، حيوان أو شيء. لذا هي توضع بعد الإسم الأساسي في الجملة مع حذف صيغة التكرار الواردة في الجملة.\r\n\r\nلمعرفة الضمير المناسب يجب علينا ان نحدد أولاً الإسم الذي نتحدث عنه و الذي يدور حوله الكلام و من ثم ننتقل لنحدد هل هو فاعل أم أنه مفعول به؟\r\nحددنا الإسم و عرفنا ما وظيفته في الجملة علينا الآن أن نحدد هل هو عاقل أو غير عاقل لأعرف أي ضمير هو المناسب من بين Who، Whom و Which.\r\nفي حال كانت الفكرة الأساسية في الجملة تدور حول زمان أو مكان معين فالإحتمالات محصورة بالضميرين Whenو Where. أما في حال كان الكلام يتمحور حول سبب معين فدون تفكير نضع الضمير Why.\r\n\r\n\r\nيختلف إستعمال الضمير That بإختلاف معنى الجملة لنفرض مثلاً أن لدي جملة تحتوي على زمان معين، علي أن أفكر ملياً و أحدد محور الحديث هل هو الزمان أم أنه الحدث بحد ذاته ففي حال كان الحدث سأستعمل الضمير That و ليس الضمير When.\r\n\r\n\r\nأمثلة عملية\r\nكما لاحظت فإن ضمائر الوصل سهلة و لها إستعمالات محدودة و واضحة و لكن حتى تتمكن من فهمها بشكل أوضح سنعطيك أمثلة عملية عنها و نشرحها لك.\r\n\r\n\r\nفي الجملة التالية الكلمة المفتاح التي يتمحور عنها الكلام هي The man و معناها الرجل ( عاقل ) و هي فاعل كما أنها قد تكررت في الجملة الثانية على شكل ضمير الفاعل He. إذاً الضمير المناسب هو Who.\r\n\r\n1 The man is 50 years old. He is a nice man.\r\n\r\nعمر الرجل 50 سنة. إنه لطيف.\r\n\r\n2 The man who is 50 years old, is a nice man.\r\n\r\nالرجل ذو الخمسون عاماً لطيف.\r\n\r\n\r\n3 The girl broke her arm last week. She is clumsy.\r\n\r\nالفتاة كسرت ذراعها الأسبوع الماضي. هي خرقاء.\r\n\r\n4 The girl who broke her arm last week is clumsy.\r\n\r\nالفتاة التي كسرت ذراعها الأسبوع الماضي خرقاء.\r\n\r\n\r\nالإسم المفتاح في الجملتين التاليتين هو كلمة Necklace و تعني قلادة ( غير عاقل )، حل مكانها في الجملة التالية ضمير المفعول به It إذاً الضمير المناسب لدمج الجملتين ببعضهما هو ضمير الوصل Which.\r\n\r\n5 I saw an old necklace. It brings bad luck.\r\nرأيت قلادة قديمة. إنها تجلب سوء الحظ.\r\n6 I saw an old necklace, which brings bad luck.\r\nرأيت قلادة قديمة تجلب سوء الحظ.\r\nعند دمج جملتين ببعضهما بواسطة أحد ضمائر الوصل فإن الجزء الأساسي الذي يسبق ضمير الوصل يسمى Main clause و الجزء الذي يليه يسمى Relative clause.', 1, '2025-05-11 10:48:46', 3),
(29, 'أحرف الجر الأساسية', NULL, 'عند الكلام حول مكان ما فإننا نستخدم In عندما نذكر بعده إسم مدينة، إسم دولة، إسم قارة، إسم مؤسسة، إسم شركة، إسم مطعم، إسم وسيلة من وساءل الإعلام، إتجاه ما، أو عند الإشارة لشيء موجود بداخل شيء ما.\r\n\r\nإليك بعض الأمثلة العملية حتى تفهمها بشكل أفضل:\r\n\r\n1  He was in his apartment.\r\n\r\nكان في شقته. (شيء بداخل شيء).\r\n\r\n2  The candies are in the box.\r\n\r\nالحلوى في الصّندوق. (شيء بداخل شيء)\r\n\r\n3  I live in Paris.\r\n\r\nأعيش في باريس. (إسم مدينة)\r\n\r\n4  He lives in the north of Lebanon.\r\n\r\nيعيش في شمال لبنان. (إتجاه محدد)\r\n\r\n5  He drinks the best coffee in this coffee shop.\r\n\r\nيشرب ألذ قهوة في هذا المقهى. (مطعم)\r\n\r\n6  Yestreday we were in the restaurant.\r\n\r\nالبارحة كنا في المطعم. (شيء بداخل شيء)\r\n\r\n7  The story in this film is not clear..\r\n\r\nالقصة في هذا الفيلم ليست واضحة. (فيلم وسيلة إعلام)\r\n\r\n8  The lady saw her life in an old picture.\r\n\r\nشاهدت السيدة حياتها في صورة قديمة. (صورة وسيلة إعلام)\r\n\r\n9  The children are playing football in the park.\r\n\r\nالأطفال يلعبون الكرة في الحديقة. (شيء بداخل شيء)\r\n\r\n10  The stars are shining in the sky.\r\n\r\nالنجوم تلمع في السماء. (شيء بداخل شيء)', 1, '2025-05-11 10:51:41', 4),
(30, 'حرف الجر on', NULL, 'عند الكلام حول مكان ما فإننا نستخدم On عندما نذكر بعده شيء موجود على سطح شيء ما، شيء يعتبر جزء من شيء أكبر، شيء يتم بواسطة وسيلة من وسائل التواصل، للإشارة إلى التنقل أو السفر عبر وسائل النقل (لا سيما التي تجلس على متنها) و وسائل النقل العام كالطائرة ( Plane )، الباص ( Bus )، المركب ( Boat )، الباخرة ( Ferry ).\r\n\r\nإليك بعض الأمثلة العملية حتى تفهمها بشكل أفضل:\r\n\r\n1  His office is on the third floor.\r\n\r\nيقع مكتبه في الطابق الثالث. ( المكتب هو جزء من الطابق )\r\n\r\n2  He was on the bus when his mother called him.\r\n\r\nكان في الباص عندما اتصلت به أمه. ( وسيلة من وسائل النقل العامة )\r\n\r\n3  He sat on his bed.\r\n\r\nجلس على سريره. ( نقصد بها على سطح السرير )\r\n\r\n4  Come here, your mom is on the phone.\r\n\r\nتعال إلى هنا، أمك على الهاتف. ( وسيلة من وسائل التواصل )\r\n\r\n5  My flat is on the 4th floor.\r\n\r\nتقع شقتي في الطابق الرابع. ( هو جزء من مبنى )\r\n\r\n\r\nعند الكلام عن وقت ما فإننا نستخدم On عندما نذكر بعده أحد أيام الأسبوع، تاريخ محدد، أي يوم مميز كالعيد.\r\n\r\nإليك بعض الأمثلة العملية حتى تفهمها بشكل أفضل:\r\n\r\n1  I will travel on Wednesday.\r\n\r\nسأسافر يوم الأربعاء. ( يوم من أيام الأسبوع )\r\n\r\n2  I will see her on Friday morning.\r\n\r\nسأرها في صباح يوم الجمعة. ( يوم من أيام الأسبوع )\r\n\r\n3  Christmas is on December 25th.\r\n\r\nعيد الفصح هو في الخامس و العشرين من ديسمبر. ( تاريخ محدد )\r\n\r\n4  I will visit my grand mother on Eid al-Fitr.\r\n\r\nسأزور جدتي في عيد الفطر. ( يوم مميز )', 1, '2025-05-11 10:52:43', 4);

-- --------------------------------------------------------

--
-- Table structure for table `quizzes`
--

CREATE TABLE `quizzes` (
  `id` int(11) NOT NULL,
  `question` text NOT NULL,
  `correct_answer` varchar(255) NOT NULL,
  `options` text NOT NULL,
  `teacher_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `unit_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `quizzes`
--

INSERT INTO `quizzes` (`id`, `question`, `correct_answer`, `options`, `teacher_id`, `created_at`, `unit_id`) VALUES
(6, 'ما هو تصريف الفعل \'go\' في الزمن الماضي البسيط؟', 'went', '[\"gone\", \"went\", \"goed\", \"goes\"]', 1, '2025-05-10 13:58:23', 1),
(7, 'ما هو تصريف الفعل \'write\' في الماضي؟', 'wrote', '[\"writed\", \"written\", \"wrote\"]', 1, '2025-05-10 13:59:51', 1),
(8, 'اختر الجملة الصحيحة:', 'She studied English last year', '[\"She study English last year.\", \"She studies English last year.\", \"She studied English last year.\"]', 1, '2025-05-10 14:00:56', 1),
(9, 'ما هو الزمن في الجملة: \"She eats breakfast every day.\"؟', 'Present Simple', '[\"Present Simple\", \"Present Continuous\", \"Past Simple\", \"Present Perfect\"]', 1, '2025-05-11 11:07:09', 1),
(10, 'أي جملة تعبر عن المستقبل البسيط (Future Simple)؟', 'They will travel to Paris next month.', '[\"They are traveling to Paris.\", \"They traveled to Paris.\", \"They will travel to Paris next month.\", \"They have traveled to Paris.\"]', 1, '2025-05-11 11:07:09', 1),
(11, 'ما هو الزمن المناسب لـ: \"By 2025, I _____ (finish) my studies.\"؟', 'will have finished', '[\"will finish\", \"finish\", \"will have finished\", \"am finishing\"]', 1, '2025-05-11 11:07:09', 1),
(12, 'أي جملة تحتوي على Past Continuous؟', 'I was watching TV when he called.', '[\"I watched TV yesterday.\", \"I have watched TV.\", \"I was watching TV when he called.\", \"I will watch TV later.\"]', 1, '2025-05-11 11:07:09', 1),
(13, 'كيف تحول الجملة التالية إلى كلام منقول: \"I am happy,\" said John.', 'John said that he was happy.', '[\"John said that he is happy.\", \"John said that he was happy.\", \"John said that he had been happy.\", \"John said that he has been happy.\"]', 1, '2025-05-11 11:07:09', 2),
(14, 'ما هي الصيغة الصحيحة للكلام المنقول لـ: \"Where do you live?\" he asked.', 'He asked where I lived.', '[\"He asked where do I live.\", \"He asked where I live.\", \"He asked where I lived.\", \"He asked where did I live.\"]', 1, '2025-05-11 11:07:09', 2),
(15, 'كيف تحول الأمر التالي إلى كلام منقول: \"Close the door,\" she said.', 'She told me to close the door.', '[\"She said me close the door.\", \"She told me to close the door.\", \"She said that I closed the door.\", \"She told me close the door.\"]', 1, '2025-05-11 11:07:09', 2),
(16, 'ما هي التغييرات التي تحدث في الأزمنة عند التحويل إلى كلام منقول؟', 'Present Simple → Past Simple', '[\"Present Simple → Past Simple\", \"Past Simple → Present Simple\", \"No changes in tenses\", \"Present Simple → Future Simple\"]', 1, '2025-05-11 11:07:09', 2),
(17, 'ما هو ضمير الوصل المناسب في الجملة: \"The man _____ lives next door is a doctor.\"؟', 'who', '[\"who\", \"whom\", \"which\", \"whose\"]', 1, '2025-05-11 11:07:09', 3),
(18, 'ما هو ضمير الوصل الصحيح في الجملة: \"The book _____ I bought is interesting.\"؟', 'that', '[\"who\", \"whom\", \"that\", \"whose\"]', 1, '2025-05-11 11:07:09', 3),
(19, 'أي جملة تحتوي على ضمير وصل يمكن حذفه؟', 'The movie (that) we watched was exciting.', '[\"The man who called you is here.\", \"The movie (that) we watched was exciting.\", \"The house which was built in 1990 is old.\", \"The woman whose car was stolen is sad.\"]', 1, '2025-05-11 11:07:09', 3),
(20, 'ما هو الفرق بين \"which\" و \"that\" في ضمائر الوصل؟', 'which تستخدم مع الجمل غير المحددة، that مع الجمل المحددة', '[\"لا فرق بينهما\", \"which للمذكر و that للمؤنث\", \"which تستخدم مع الجمل غير المحددة، that مع الجمل المحددة\", \"which للأشخاص و that للأشياء\"]', 1, '2025-05-11 11:07:09', 3),
(21, 'ما هو حرف الجر المناسب في الجملة: \"I will meet you _____ the morning.\"؟', 'in', '[\"in\", \"on\", \"at\", \"by\"]', 1, '2025-05-11 11:07:09', 4),
(22, 'أي حرف جر يناسب الجملة: \"She is afraid _____ spiders.\"؟', 'of', '[\"from\", \"of\", \"with\", \"about\"]', 1, '2025-05-11 11:07:09', 4),
(23, 'ما هو حرف الجر الصحيح في الجملة: \"He apologized _____ being late.\"؟', 'for', '[\"for\", \"about\", \"of\", \"with\"]', 1, '2025-05-11 11:07:09', 4),
(24, 'أي جملة تحتوي على حرف جر صحيح؟', 'We arrived at the airport at 8 pm.', '[\"We arrived to the airport at 8 pm.\", \"We arrived in the airport at 8 pm.\", \"We arrived at the airport at 8 pm.\", \"We arrived on the airport at 8 pm.\"]', 1, '2025-05-11 11:07:09', 4);

-- --------------------------------------------------------

--
-- Table structure for table `quiz_results`
--

CREATE TABLE `quiz_results` (
  `id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `quiz_id` int(11) NOT NULL,
  `score` int(11) NOT NULL,
  `total_questions` int(11) NOT NULL,
  `completed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `quiz_results`
--

INSERT INTO `quiz_results` (`id`, `student_id`, `quiz_id`, `score`, `total_questions`, `completed_at`) VALUES
(1, 2, 8, 0, 1, '2025-05-10 22:40:03'),
(2, 2, 6, 0, 1, '2025-05-10 22:40:14'),
(3, 2, 7, 0, 1, '2025-05-10 22:45:14'),
(4, 2, 9, 0, 1, '2025-05-11 11:08:03'),
(5, 2, 10, 0, 1, '2025-05-11 11:08:21'),
(6, 16, 9, 0, 1, '2025-05-11 11:09:57'),
(7, 16, 6, 0, 1, '2025-05-11 11:10:08'),
(8, 16, 10, 1, 1, '2025-05-11 11:13:59'),
(9, 16, 11, 0, 1, '2025-05-11 11:14:15'),
(10, 16, 12, 1, 1, '2025-05-11 11:16:34'),
(11, 16, 13, 0, 1, '2025-05-11 11:16:43'),
(12, 16, 14, 0, 1, '2025-05-11 11:19:10'),
(13, 16, 15, 1, 1, '2025-05-11 11:19:23'),
(14, 16, 16, 1, 1, '2025-05-11 11:19:28'),
(15, 16, 17, 0, 1, '2025-05-11 11:19:31'),
(16, 16, 18, 0, 1, '2025-05-11 11:19:33'),
(17, 16, 19, 1, 1, '2025-05-11 11:19:37'),
(18, 16, 20, 0, 1, '2025-05-11 11:19:41'),
(19, 16, 21, 0, 1, '2025-05-11 11:19:45'),
(20, 16, 23, 1, 1, '2025-05-11 11:19:52'),
(21, 16, 24, 0, 1, '2025-05-11 11:19:54'),
(22, 16, 8, 0, 1, '2025-05-11 11:19:56'),
(23, 16, 7, 0, 1, '2025-05-11 11:19:58'),
(24, 16, 22, 1, 1, '2025-05-11 11:28:23');

-- --------------------------------------------------------

--
-- Table structure for table `units`
--

CREATE TABLE `units` (
  `id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `level` enum('beginner','intermediate','advanced') NOT NULL,
  `order_num` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `teacher_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `units`
--

INSERT INTO `units` (`id`, `title`, `description`, `level`, `order_num`, `created_at`, `teacher_id`) VALUES
(1, 'الوحدة 1: الأزمنة', 'تعلم الأزمنة في اللغة الإنجليزية واستخداماتها (مثل الحاضر، الماضي، المستقبل)', '', 1, '2025-05-10 13:18:05', 0),
(2, 'الوحدة 2: الكلام المنقول', 'دراسة كيفية استخدام الكلام المنقول وكيفية تحويل الجمل المباشرة إلى غير مباشرة', '', 2, '2025-05-10 13:18:05', 0),
(3, 'الوحدة 3: ضمائر الوصل', 'تعلم ضمائر الوصل وكيفية استخدامها في الجمل لتوصيل الأفكار', '', 3, '2025-05-10 13:18:05', 0),
(4, 'الوحدة 4: أحرف الجر', 'دراسة المحادثات اليومية والمواقف الشائعة التي قد نواجهها في الحياة اليومية', '', 4, '2025-05-10 13:18:05', 0);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('teacher','student') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `level` enum('none','beginner','intermediate','advanced') DEFAULT 'none'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `role`, `created_at`, `level`) VALUES
(1, 'teacher', 'admin@gmail.com', '$2y$10$iF.am7KfYyfq3yLEJs8DDeaNYIGHnRGmIpGW1EdJGrn3sMoQpt1Ia', 'teacher', '2025-04-25 15:51:15', 'none'),
(15, 'hala es', 'hala@gmail.com', '$2y$10$Mb.EP8xMBr8h6vYr2zqd4OBc4z51cNlYF0KEcPGIZB5sCc7fFjh96', 'student', '2025-05-10 19:56:35', 'none');

-- --------------------------------------------------------

--
-- Table structure for table `user_progress`
--

CREATE TABLE `user_progress` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `lesson_id` int(11) DEFAULT NULL,
  `quiz_id` int(11) DEFAULT NULL,
  `level` int(11) DEFAULT 1,
  `completed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_progress`
--

INSERT INTO `user_progress` (`id`, `user_id`, `lesson_id`, `quiz_id`, `level`, `completed_at`) VALUES
(1, 2, 1, NULL, 1, '2025-05-10 22:32:20');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `challenges`
--
ALTER TABLE `challenges`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `challenge_files`
--
ALTER TABLE `challenge_files`
  ADD PRIMARY KEY (`id`),
  ADD KEY `challenge_id` (`challenge_id`);

--
-- Indexes for table `interactive_lessons`
--
ALTER TABLE `interactive_lessons`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `languages`
--
ALTER TABLE `languages`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Indexes for table `lessons`
--
ALTER TABLE `lessons`
  ADD PRIMARY KEY (`id`),
  ADD KEY `teacher_id` (`teacher_id`),
  ADD KEY `unit_id` (`unit_id`);

--
-- Indexes for table `quizzes`
--
ALTER TABLE `quizzes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `teacher_id` (`teacher_id`),
  ADD KEY `unit_id` (`unit_id`);

--
-- Indexes for table `quiz_results`
--
ALTER TABLE `quiz_results`
  ADD PRIMARY KEY (`id`),
  ADD KEY `student_id` (`student_id`),
  ADD KEY `quiz_id` (`quiz_id`);

--
-- Indexes for table `units`
--
ALTER TABLE `units`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `user_progress`
--
ALTER TABLE `user_progress`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_lesson_unique` (`user_id`,`lesson_id`),
  ADD UNIQUE KEY `user_quiz_unique` (`user_id`,`quiz_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `challenges`
--
ALTER TABLE `challenges`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `challenge_files`
--
ALTER TABLE `challenge_files`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `interactive_lessons`
--
ALTER TABLE `interactive_lessons`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT for table `languages`
--
ALTER TABLE `languages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `lessons`
--
ALTER TABLE `lessons`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `quizzes`
--
ALTER TABLE `quizzes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `quiz_results`
--
ALTER TABLE `quiz_results`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `units`
--
ALTER TABLE `units`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `user_progress`
--
ALTER TABLE `user_progress`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `challenge_files`
--
ALTER TABLE `challenge_files`
  ADD CONSTRAINT `challenge_files_ibfk_1` FOREIGN KEY (`challenge_id`) REFERENCES `challenges` (`id`);

--
-- Constraints for table `lessons`
--
ALTER TABLE `lessons`
  ADD CONSTRAINT `lessons_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `lessons_ibfk_2` FOREIGN KEY (`unit_id`) REFERENCES `units` (`id`);

--
-- Constraints for table `quizzes`
--
ALTER TABLE `quizzes`
  ADD CONSTRAINT `quizzes_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `quizzes_ibfk_2` FOREIGN KEY (`unit_id`) REFERENCES `units` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
