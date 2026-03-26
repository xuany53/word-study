-- 百词斩式单词学习工具 - 数据库初始化脚本
-- 设置字符集
SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;

-- 创建数据库
CREATE DATABASE IF NOT EXISTS word_study CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE word_study;

-- 用户表
CREATE TABLE IF NOT EXISTS users (
    id VARCHAR(36) PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    theme VARCHAR(20) DEFAULT 'light',
    dailyNewWords INT DEFAULT 20,
    learningMode VARCHAR(20) DEFAULT 'choice',
    soundEnabled BOOLEAN DEFAULT TRUE,
    autoPlayAudio BOOLEAN DEFAULT TRUE,
    level INT DEFAULT 1,
    xp INT DEFAULT 0,
    streak INT DEFAULT 0,
    longestStreak INT DEFAULT 0,
    lastCheckIn DATE NULL,
    createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    updatedAt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 单词表
CREATE TABLE IF NOT EXISTS words (
    id VARCHAR(36) PRIMARY KEY,
    word VARCHAR(100) NOT NULL,
    phonetic VARCHAR(100),
    pronunciation VARCHAR(255),
    meanings JSON,
    examples JSON,
    image VARCHAR(255),
    category VARCHAR(50),
    difficulty INT DEFAULT 1,
    createdAt DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 学习记录表
CREATE TABLE IF NOT EXISTS learning_records (
    id VARCHAR(36) PRIMARY KEY,
    userId VARCHAR(36) NOT NULL,
    wordId VARCHAR(36) NOT NULL,
    status VARCHAR(20) DEFAULT 'new',
    masteryLevel INT DEFAULT 0,
    correctCount INT DEFAULT 0,
    wrongCount INT DEFAULT 0,
    nextReviewAt DATETIME NOT NULL,
    lastReviewAt DATETIME NULL,
    createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    updatedAt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (userId) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_user_word (userId, wordId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 徽章表
CREATE TABLE IF NOT EXISTS badges (
    id VARCHAR(36) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    icon VARCHAR(50),
    description TEXT,
    rarity VARCHAR(20) DEFAULT 'common',
    unlockCondition JSON,
    createdAt DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 用户徽章表
CREATE TABLE IF NOT EXISTS user_badges (
    id VARCHAR(36) PRIMARY KEY,
    userId VARCHAR(36) NOT NULL,
    badgeId VARCHAR(36) NOT NULL,
    unlockedAt DATETIME NOT NULL,
    FOREIGN KEY (userId) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (badgeId) REFERENCES badges(id),
    UNIQUE KEY uk_user_badge (userId, badgeId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 闯关关卡表
CREATE TABLE IF NOT EXISTS challenge_levels (
    id VARCHAR(36) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    wordCount INT NOT NULL,
    timeLimit INT NULL,
    maxErrors INT NOT NULL DEFAULT 2,
    difficulty VARCHAR(20) DEFAULT 'easy',
    xpReward INT DEFAULT 100,
    prerequisiteLevelId VARCHAR(36) NULL,
    createdAt DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 闯关结果表
CREATE TABLE IF NOT EXISTS challenge_results (
    id VARCHAR(36) PRIMARY KEY,
    userId VARCHAR(36) NOT NULL,
    levelId VARCHAR(36) NOT NULL,
    correctCount INT NOT NULL,
    wrongCount INT NOT NULL,
    timeTaken INT NOT NULL,
    starRating INT DEFAULT 0,
    xpEarned INT NOT NULL,
    isPassed BOOLEAN DEFAULT FALSE,
    completedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (userId) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 插入初始徽章数据
INSERT INTO badges (id, name, icon, description, rarity, unlockCondition) VALUES
(UUID(), 'Chu Xue Zhe', '🎓', 'Lian xu da ka 3 tian', 'common', '{"type": "streak", "value": 3}'),
(UUID(), 'Qin Fen Da Ren', '🥈', 'Lian xu da ka 7 tian', 'rare', '{"type": "streak", "value": 7}'),
(UUID(), 'Jian Chi Bu Xie', '🥇', 'Lian xu da ka 14 tian', 'rare', '{"type": "streak", "value": 14}'),
(UUID(), 'Dan Ci Da Shi', '💎', 'Lian xu da ka 30 tian', 'epic', '{"type": "streak", "value": 30}'),
(UUID(), 'Chuan Qi Ren Wu', '👑', 'Lian xu da ka 60 tian', 'legendary', '{"type": "streak", "value": 60}'),
(UUID(), 'Ci Hui Xin Shou', '📖', 'Xue xi 100 ge dan ci', 'common', '{"type": "words", "value": 100}'),
(UUID(), 'Ci Hui Da Ren', '📚', 'Xue xi 500 ge dan ci', 'rare', '{"type": "words", "value": 500}'),
(UUID(), 'Ci Hui Zhuan Jia', '🏆', 'Xue xi 1000 ge dan ci', 'epic', '{"type": "words", "value": 1000}'),
(UUID(), 'Jing Zhun She Shou', '🎯', 'Zheng que lv da dao 80%', 'rare', '{"type": "accuracy", "value": 80}'),
(UUID(), 'Wan Mei Zhu Yi', '⭐', 'Zheng que lv da dao 95%', 'legendary', '{"type": "accuracy", "value": 95}');

-- 插入初始关卡数据
INSERT INTO challenge_levels (id, name, description, wordCount, timeLimit, maxErrors, difficulty, xpReward) VALUES
(UUID(), 'Xin Shou Xun Lian Ying', 'Shi he chu xue zhe de ru men guan ka', 5, NULL, 2, 'easy', 50),
(UUID(), 'Su Du Tiao Zhan', 'Zai xian ding shi jian nei wan cheng tiao zhan', 10, 60, 2, 'medium', 100),
(UUID(), 'Wan Mei Tiao Zhan', 'Bu yun xu fan cuo de yan ge tiao zhan', 15, 90, 0, 'hard', 200),
(UUID(), 'Zhong Ji Tiao Zhan', 'Gao nan du dan ci de ji xian tiao zhan', 20, 120, 1, 'extreme', 300);

-- 插入示例单词数据
INSERT INTO words (id, word, phonetic, pronunciation, meanings, examples, category, difficulty) VALUES
(UUID(), 'hello', '/həˈləʊ/', NULL, '[{"partOfSpeech":"interj.","definition":"used as a greeting","translation":"ni hao"}]', '[{"sentence":"Hello, how are you?","translation":"Ni hao, ni hao ma?"}]', 'daily-life', 1),
(UUID(), 'world', '/wɜːld/', NULL, '[{"partOfSpeech":"n.","definition":"the earth and all the people","translation":"shi jie"}]', '[{"sentence":"The world is beautiful.","translation":"Shi jie shi mei li de."}]', 'daily-life', 1),
(UUID(), 'apple', '/ˈæpl/', NULL, '[{"partOfSpeech":"n.","definition":"a round fruit","translation":"ping guo"}]', '[{"sentence":"I eat an apple every day.","translation":"Wo mei tian chi yi ge ping guo."}]', 'food', 1),
(UUID(), 'book', '/bʊk/', NULL, '[{"partOfSpeech":"n.","definition":"a written work","translation":"shu"}]', '[{"sentence":"I love reading books.","translation":"Wo xi huan du shu."}]', 'daily-life', 1),
(UUID(), 'computer', '/kəmˈpjuːtə/', NULL, '[{"partOfSpeech":"n.","definition":"an electronic device","translation":"dian nao"}]', '[{"sentence":"I use a computer for work.","translation":"Wo yong dian nao gong zuo."}]', 'technology', 2),
(UUID(), 'water', '/ˈwɔːtə/', NULL, '[{"partOfSpeech":"n.","definition":"a clear liquid","translation":"shui"}]', '[{"sentence":"I drink water every day.","translation":"Wo mei tian he shui."}]', 'daily-life', 1),
(UUID(), 'happy', '/ˈhæpi/', NULL, '[{"partOfSpeech":"adj.","definition":"feeling pleasure","translation":"kuai le"}]', '[{"sentence":"I am very happy today.","translation":"Jin tian wo hen kuai le."}]', 'daily-life', 1),
(UUID(), 'study', '/ˈstʌdi/', NULL, '[{"partOfSpeech":"v.","definition":"to learn","translation":"xue xi"}]', '[{"sentence":"I study English every day.","translation":"Wo mei tian xue xi ying yu."}]', 'daily-life', 2),
(UUID(), 'beautiful', '/ˈbjuːtɪfl/', NULL, '[{"partOfSpeech":"adj.","definition":"pleasing to look at","translation":"mei li"}]', '[{"sentence":"The flower is beautiful.","translation":"Zhe duo hua hen mei li."}]', 'daily-life', 2),
(UUID(), 'important', '/ɪmˈpɔːtənt/', NULL, '[{"partOfSpeech":"adj.","definition":"of great significance","translation":"zhong yao"}]', '[{"sentence":"English is very important.","translation":"Ying yu hen zhong yao."}]', 'daily-life', 3);