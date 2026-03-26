-- 清空单词表并重置
SET NAMES utf8mb4;
USE word_study;

-- 清空表
DELETE FROM learning_records;
DELETE FROM words;

-- 重置自增
ALTER TABLE words AUTO_INCREMENT = 1;
ALTER TABLE learning_records AUTO_INCREMENT = 1;

SELECT 'Tables cleaned successfully!' as result;
