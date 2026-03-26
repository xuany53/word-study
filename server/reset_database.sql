-- 重置单词数据
SET NAMES utf8mb4;
USE word_study;

-- 清空相关表
DELETE FROM learning_records;
DELETE FROM words;

SELECT 'Database cleaned! Please restart the server.' as result;
