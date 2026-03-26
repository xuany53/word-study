-- Badge Data for Word Study App
-- 25 badges with various unlock conditions
-- 游戏化徽章数据

SET NAMES utf8mb4;

USE word_study;

-- Clear existing badges
DELETE FROM badges;

-- Insert badges with proper Chinese names and descriptions
INSERT INTO badges (id, name, icon, description, rarity, unlockCondition, createdAt) VALUES

-- 打卡连续徽章 (Streak Badges)
(UUID(), '初学者', '🔥', '连续打卡3天', 'common', '{"type":"streak","value":3}', NOW()),
(UUID(), '坚持者', '🔥', '连续打卡7天', 'common', '{"type":"streak","value":7}', NOW()),
(UUID(), '毅力王', '🔥', '连续打卡14天', 'rare', '{"type":"streak","value":14}', NOW()),
(UUID(), '恒心星', '⭐', '连续打卡30天', 'rare', '{"type":"streak","value":30}', NOW()),
(UUID(), '传奇人', '👑', '连续打卡60天', 'epic', '{"type":"streak","value":60}', NOW()),
(UUID(), '不朽传奇', '💎', '连续打卡100天', 'legendary', '{"type":"streak","value":100}', NOW()),

-- 词汇学习徽章 (Word Learning Badges)
(UUID(), '词汇新人', '📚', '学习100个单词', 'common', '{"type":"words_learned","value":100}', NOW()),
(UUID(), '词汇达人', '📖', '学习500个单词', 'rare', '{"type":"words_learned","value":500}', NOW()),
(UUID(), '词汇专家', '🎓', '学习1000个单词', 'epic', '{"type":"words_learned","value":1000}', NOW()),

-- 掌握成就徽章 (Mastery Badges)
(UUID(), '初露锋芒', '✨', '掌握50个单词', 'common', '{"type":"words_mastered","value":50}', NOW()),
(UUID(), '小有成就', '🌟', '掌握200个单词', 'rare', '{"type":"words_mastered","value":200}', NOW()),
(UUID(), '大师先成', '🏆', '掌握500个单词', 'epic', '{"type":"words_mastered","value":500}', NOW()),

-- 正确率徽章 (Accuracy Badges)
(UUID(), '准确无误', '🎯', '正确率达80%', 'common', '{"type":"accuracy","value":80}', NOW()),
(UUID(), '精准大师', '🎪', '正确率达90%', 'rare', '{"type":"accuracy","value":90}', NOW()),
(UUID(), '完美主义', '💫', '正确率达95%', 'legendary', '{"type":"accuracy","value":95}', NOW()),

-- 闯关徽章 (Challenge Badges)
(UUID(), '挑战新人', '🎮', '完成第一个关卡', 'common', '{"type":"challenge_complete","value":1}', NOW()),
(UUID(), '关卡达人', '🕹️', '完成10个关卡', 'rare', '{"type":"challenge_complete","value":10}', NOW()),
(UUID(), '通关大师', '🏅', '完成所有关卡', 'epic', '{"type":"challenge_complete","value":20}', NOW()),

-- 满分徽章 (Perfect Score Badges)
(UUID(), '完美新手', '💯', '获得1个三星评价', 'common', '{"type":"perfect_score","value":1}', NOW()),
(UUID(), '完美达人', '⭐', '获得10个三星评价', 'rare', '{"type":"perfect_score","value":10}', NOW()),
(UUID(), '完美传奇', '🌟', '获得50个三星评价', 'legendary', '{"type":"perfect_score","value":50}', NOW()),

-- 等级徽章 (Level Badges)
(UUID(), '学习新人', '🌱', '达到等级5', 'common', '{"type":"level","value":5}', NOW()),
(UUID(), '学习达人', '🌿', '达到等级10', 'rare', '{"type":"level","value":10}', NOW()),
(UUID(), '学习专家', '🌳', '达到等级25', 'epic', '{"type":"level","value":25}', NOW()),
(UUID(), '学习大师', '🏔️', '达到等级50', 'legendary', '{"type":"level","value":50}', NOW());

SELECT COUNT(*) as total_badges FROM badges;

-- Insert Challenge Levels
-- 闯关关卡数据
DELETE FROM challenge_levels;

INSERT INTO challenge_levels (id, name, description, wordCount, timeLimit, maxErrors, difficulty, xpReward, prerequisiteLevelId, createdAt) VALUES

-- Easy Level (简单)
(UUID(), '新手训练营', '无时间限制，允许2次错误', 5, NULL, 2, 'easy', 50, NULL, NOW()),
(UUID(), '速度挑战', '60秒内完成10词', 10, 60, 2, 'easy', 100, NULL, NOW()),

-- Medium Level (中等)
(UUID(), '完美主义', '0次错误完成15词', 15, 120, 0, 'medium', 200, NULL, NOW()),
(UUID(), '时间大赛', '90秒内完成15词', 15, 90, 2, 'medium', 150, NULL, NOW()),

-- Hard Level (困难)
(UUID(), '极速挑战', '60秒内完成15词', 15, 60, 1, 'hard', 250, NULL, NOW()),
(UUID(), '终极挑战', '120秒内完成20词，只允许1次错误', 20, 120, 1, 'hard', 300, NULL, NOW()),
(UUID(), '大师考验', '90秒内完成20词', 20, 90, 2, 'hard', 350, NULL, NOW()),

-- Expert Level (专家)
(UUID(), '传奇之路', '完成25词，无时间限制', 25, NULL, 2, 'expert', 400, NULL, NOW()),
(UUID(), '不可能的任务', '60秒内完成25词', 25, 60, 1, 'expert', 500, NULL, NOW()),

-- Legendary Level (传说)
(UUID(), '终极大师', '完美完成30词，0次错误', 30, 180, 0, 'legendary', 1000, NULL, NOW());

SELECT COUNT(*) as total_levels FROM challenge_levels;