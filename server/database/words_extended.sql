-- Extended Word Library for Word Study App
-- 100+ words with definitions, translations, and examples

SET NAMES utf8mb4;

-- Clear existing words
DELETE FROM words;

-- Insert 100 words
INSERT INTO words (id, word, phonetic, pronunciation, meanings, examples, image, category, difficulty, createdAt) VALUES
-- Basic Words (Difficulty 1)
(UUID(), 'hello', '/həˈləʊ/', NULL, '[{"partOfSpeech":"interj.","definition":"used as a greeting","translation":"你好"}]', '[{"sentence":"Hello, how are you today?","translation":"你好，今天怎么样？"}]', NULL, 'greetings', 1, NOW()),
(UUID(), 'world', '/wɜːld/', NULL, '[{"partOfSpeech":"n.","definition":"the earth and all people","translation":"世界"}]', '[{"sentence":"The world is full of wonders.","translation":"世界充满了奇迹。"}]', NULL, 'general', 1, NOW()),
(UUID(), 'apple', '/ˈæpl/', NULL, '[{"partOfSpeech":"n.","definition":"a round fruit","translation":"苹果"}]', '[{"sentence":"I eat an apple every day.","translation":"我每天都吃一个苹果。"}]', NULL, 'food', 1, NOW()),
(UUID(), 'book', '/bʊk/', NULL, '[{"partOfSpeech":"n.","definition":"a written work","translation":"书"}]', '[{"sentence":"This book is very interesting.","translation":"这本书很有趣。"}]', NULL, 'education', 1, NOW()),
(UUID(), 'water', '/ˈwɔːtə/', NULL, '[{"partOfSpeech":"n.","definition":"a clear liquid","translation":"水"}]', '[{"sentence":"Please give me some water.","translation":"请给我一些水。"}]', NULL, 'nature', 1, NOW()),
(UUID(), 'happy', '/ˈhæpi/', NULL, '[{"partOfSpeech":"adj.","definition":"feeling pleasure","translation":"快乐的"}]', '[{"sentence":"She looks very happy today.","translation":"她今天看起来很快乐。"}]', NULL, 'emotions', 1, NOW()),
(UUID(), 'friend', '/frend/', NULL, '[{"partOfSpeech":"n.","definition":"a person you know well","translation":"朋友"}]', '[{"sentence":"He is my best friend.","translation":"他是我最好的朋友。"}]', NULL, 'people', 1, NOW()),
(UUID(), 'family', '/ˈfæmɪli/', NULL, '[{"partOfSpeech":"n.","definition":"parents and children","translation":"家庭"}]', '[{"sentence":"I love my family.","translation":"我爱我的家人。"}]', NULL, 'people', 1, NOW()),
(UUID(), 'time', '/taɪm/', NULL, '[{"partOfSpeech":"n.","definition":"measured in hours","translation":"时间"}]', '[{"sentence":"What time is it?","translation":"现在几点了？"}]', NULL, 'general', 1, NOW()),
(UUID(), 'day', '/deɪ/', NULL, '[{"partOfSpeech":"n.","definition":"24 hours","translation":"天，日子"}]', '[{"sentence":"Have a nice day!","translation":"祝你今天愉快！"}]', NULL, 'general', 1, NOW()),

-- Common Words (Difficulty 1-2)
(UUID(), 'music', '/ˈmjuːzɪk/', NULL, '[{"partOfSpeech":"n.","definition":"sounds that are pleasant","translation":"音乐"}]', '[{"sentence":"I love listening to music.","translation":"我喜欢听音乐。"}]', NULL, 'entertainment', 1, NOW()),
(UUID(), 'school', '/skuːl/', NULL, '[{"partOfSpeech":"n.","definition":"a place for learning","translation":"学校"}]', '[{"sentence":"I go to school every day.","translation":"我每天去上学。"}]', NULL, 'education', 1, NOW()),
(UUID(), 'house', '/haʊs/', NULL, '[{"partOfSpeech":"n.","definition":"a building for living","translation":"房子"}]', '[{"sentence":"This is my house.","translation":"这是我的房子。"}]', NULL, 'places', 1, NOW()),
(UUID(), 'food', '/fuːd/', NULL, '[{"partOfSpeech":"n.","definition":"things to eat","translation":"食物"}]', '[{"sentence":"The food here is delicious.","translation":"这里的食物很好吃。"}]', NULL, 'food', 1, NOW()),
(UUID(), 'love', '/lʌv/', NULL, '[{"partOfSpeech":"v.","definition":"to like very much","translation":"爱"}]', '[{"sentence":"I love reading books.","translation":"我喜欢读书。"}]', NULL, 'emotions', 1, NOW()),
(UUID(), 'work', '/wɜːk/', NULL, '[{"partOfSpeech":"v.","definition":"to do a job","translation":"工作"}]', '[{"sentence":"I work at a hospital.","translation":"我在医院工作。"}]', NULL, 'work', 1, NOW()),
(UUID(), 'play', '/pleɪ/', NULL, '[{"partOfSpeech":"v.","definition":"to have fun","translation":"玩"}]', '[{"sentence":"Children like to play games.","translation":"孩子们喜欢玩游戏。"}]', NULL, 'activities', 1, NOW()),
(UUID(), 'run', '/rʌn/', NULL, '[{"partOfSpeech":"v.","definition":"to move fast","translation":"跑"}]', '[{"sentence":"I run every morning.","translation":"我每天早上跑步。"}]', NULL, 'sports', 1, NOW()),
(UUID(), 'walk', '/wɔːk/', NULL, '[{"partOfSpeech":"v.","definition":"to move on foot","translation":"走，散步"}]', '[{"sentence":"Let us walk to school.","translation":"让我们走路去学校。"}]', NULL, 'activities', 1, NOW()),
(UUID(), 'talk', '/tɔːk/', NULL, '[{"partOfSpeech":"v.","definition":"to speak","translation":"说话"}]', '[{"sentence":"We need to talk.","translation":"我们需要谈谈。"}]', NULL, 'communication', 1, NOW()),

-- Intermediate Words (Difficulty 2)
(UUID(), 'beautiful', '/ˈbjuːtɪfl/', NULL, '[{"partOfSpeech":"adj.","definition":"pleasing to look at","translation":"美丽的"}]', '[{"sentence":"The garden is beautiful.","translation":"这个花园很美。"}]', NULL, 'descriptions', 2, NOW()),
(UUID(), 'important', '/ɪmˈpɔːtənt/', NULL, '[{"partOfSpeech":"adj.","definition":"of great value","translation":"重要的"}]', '[{"sentence":"This is very important.","translation":"这很重要。"}]', NULL, 'general', 2, NOW()),
(UUID(), 'different', '/ˈdɪfrənt/', NULL, '[{"partOfSpeech":"adj.","definition":"not the same","translation":"不同的"}]', '[{"sentence":"We have different ideas.","translation":"我们有不同的想法。"}]', NULL, 'general', 2, NOW()),
(UUID(), 'remember', '/rɪˈmembə/', NULL, '[{"partOfSpeech":"v.","definition":"to keep in mind","translation":"记住"}]', '[{"sentence":"I will remember you.","translation":"我会记住你的。"}]', NULL, 'cognition', 2, NOW()),
(UUID(), 'understand', '/ˌʌndəˈstænd/', NULL, '[{"partOfSpeech":"v.","definition":"to know the meaning","translation":"理解"}]', '[{"sentence":"Do you understand?","translation":"你明白吗？"}]', NULL, 'cognition', 2, NOW()),
(UUID(), 'believe', '/bɪˈliːv/', NULL, '[{"partOfSpeech":"v.","definition":"to think something is true","translation":"相信"}]', '[{"sentence":"I believe in you.","translation":"我相信你。"}]', NULL, 'cognition', 2, NOW()),
(UUID(), 'problem', '/ˈprɒbləm/', NULL, '[{"partOfSpeech":"n.","definition":"a difficulty","translation":"问题"}]', '[{"sentence":"We have a problem.","translation":"我们有个问题。"}]', NULL, 'general', 2, NOW()),
(UUID(), 'answer', '/ˈɑːnsə/', NULL, '[{"partOfSpeech":"n.","definition":"a reply","translation":"答案"}]', '[{"sentence":"What is the answer?","translation":"答案是什么？"}]', NULL, 'education', 2, NOW()),
(UUID(), 'question', '/ˈkwestʃən/', NULL, '[{"partOfSpeech":"n.","definition":"something asked","translation":"问题"}]', '[{"sentence":"Please ask your question.","translation":"请提出你的问题。"}]', NULL, 'communication', 2, NOW()),
(UUID(), 'example', '/ɪɡˈzɑːmpl/', NULL, '[{"partOfSpeech":"n.","definition":"a thing representing a type","translation":"例子"}]', '[{"sentence":"Give me an example.","translation":"给我一个例子。"}]', NULL, 'education', 2, NOW()),

-- More Words
(UUID(), 'computer', '/kəmˈpjuːtə/', NULL, '[{"partOfSpeech":"n.","definition":"an electronic device","translation":"电脑"}]', '[{"sentence":"I use a computer for work.","translation":"我用电脑工作。"}]', NULL, 'technology', 2, NOW()),
(UUID(), 'study', '/ˈstʌdi/', NULL, '[{"partOfSpeech":"v.","definition":"to learn","translation":"学习"}]', '[{"sentence":"I study English every day.","translation":"我每天学英语。"}]', NULL, 'education', 2, NOW()),
(UUID(), 'think', '/θɪŋk/', NULL, '[{"partOfSpeech":"v.","definition":"to use the mind","translation":"想，思考"}]', '[{"sentence":"I think you are right.","translation":"我认为你是对的。"}]', NULL, 'cognition', 2, NOW()),
(UUID(), 'help', '/help/', NULL, '[{"partOfSpeech":"v.","definition":"to assist","translation":"帮助"}]', '[{"sentence":"Can you help me?","translation":"你能帮我吗？"}]', NULL, 'actions', 1, NOW()),
(UUID(), 'change', '/tʃeɪndʒ/', NULL, '[{"partOfSpeech":"v.","definition":"to become different","translation":"改变"}]', '[{"sentence":"Things will change.","translation":"事情会改变的。"}]', NULL, 'general', 2, NOW()),
(UUID(), 'travel', '/ˈtrævl/', NULL, '[{"partOfSpeech":"v.","definition":"to go places","translation":"旅行"}]', '[{"sentence":"I love to travel.","translation":"我喜欢旅行。"}]', NULL, 'activities', 2, NOW()),
(UUID(), 'language', '/ˈlæŋɡwɪdʒ/', NULL, '[{"partOfSpeech":"n.","definition":"system of communication","translation":"语言"}]', '[{"sentence":"English is a useful language.","translation":"英语是一门有用的语言。"}]', NULL, 'education', 2, NOW()),
(UUID(), 'country', '/ˈkʌntri/', NULL, '[{"partOfSpeech":"n.","definition":"a nation","translation":"国家"}]', '[{"sentence":"China is a big country.","translation":"中国是一个大国。"}]', NULL, 'geography', 2, NOW()),
(UUID(), 'city', '/ˈsɪti/', NULL, '[{"partOfSpeech":"n.","definition":"a large town","translation":"城市"}]', '[{"sentence":"Beijing is a big city.","translation":"北京是个大城市。"}]', NULL, 'geography', 1, NOW()),
(UUID(), 'money', '/ˈmʌni/', NULL, '[{"partOfSpeech":"n.","definition":"coins and notes","translation":"钱"}]', '[{"sentence":"I need some money.","translation":"我需要一些钱。"}]', NULL, 'economics', 1, NOW()),

-- Nature Words
(UUID(), 'tree', '/triː/', NULL, '[{"partOfSpeech":"n.","definition":"a tall plant","translation":"树"}]', '[{"sentence":"There is a big tree in the garden.","translation":"花园里有一棵大树。"}]', NULL, 'nature', 1, NOW()),
(UUID(), 'flower', '/ˈflaʊə/', NULL, '[{"partOfSpeech":"n.","definition":"the colorful part of a plant","translation":"花"}]', '[{"sentence":"The flower is beautiful.","translation":"这朵花很美。"}]', NULL, 'nature', 1, NOW()),
(UUID(), 'sun', '/sʌn/', NULL, '[{"partOfSpeech":"n.","definition":"the star at the center of solar system","translation":"太阳"}]', '[{"sentence":"The sun is shining.","translation":"阳光明媚。"}]', NULL, 'nature', 1, NOW()),
(UUID(), 'moon', '/muːn/', NULL, '[{"partOfSpeech":"n.","definition":"the satellite of Earth","translation":"月亮"}]', '[{"sentence":"Look at the moon.","translation":"看那月亮。"}]', NULL, 'nature', 1, NOW()),
(UUID(), 'star', '/stɑː/', NULL, '[{"partOfSpeech":"n.","definition":"a point of light in the sky","translation":"星星"}]', '[{"sentence":"The stars are bright tonight.","translation":"今晚星星很亮。"}]', NULL, 'nature', 1, NOW()),
(UUID(), 'sky', '/skaɪ/', NULL, '[{"partOfSpeech":"n.","definition":"the space above Earth","translation":"天空"}]', '[{"sentence":"The sky is blue.","translation":"天空是蓝色的。"}]', NULL, 'nature', 1, NOW()),
(UUID(), 'rain', '/reɪn/', NULL, '[{"partOfSpeech":"n.","definition":"water falling from clouds","translation":"雨"}]', '[{"sentence":"It is going to rain.","translation":"要下雨了。"}]', NULL, 'weather', 1, NOW()),
(UUID(), 'snow', '/snəʊ/', NULL, '[{"partOfSpeech":"n.","definition":"frozen water falling as white flakes","translation":"雪"}]', '[{"sentence":"The snow is white.","translation":"雪是白色的。"}]', NULL, 'weather', 1, NOW()),
(UUID(), 'mountain', '/ˈmaʊntɪn/', NULL, '[{"partOfSpeech":"n.","definition":"a very high hill","translation":"山"}]', '[{"sentence":"The mountain is high.","translation":"这座山很高。"}]', NULL, 'geography', 2, NOW()),
(UUID(), 'river', '/ˈrɪvə/', NULL, '[{"partOfSpeech":"n.","definition":"a large stream of water","translation":"河流"}]', '[{"sentence":"The river flows to the sea.","translation":"河流入海。"}]', NULL, 'geography', 2, NOW()),

-- Food Words
(UUID(), 'bread', '/bred/', NULL, '[{"partOfSpeech":"n.","definition":"baked food made from flour","translation":"面包"}]', '[{"sentence":"I eat bread for breakfast.","translation":"我早餐吃面包。"}]', NULL, 'food', 1, NOW()),
(UUID(), 'milk', '/mɪlk/', NULL, '[{"partOfSpeech":"n.","definition":"white liquid from cows","translation":"牛奶"}]', '[{"sentence":"I drink milk every day.","translation":"我每天喝牛奶。"}]', NULL, 'food', 1, NOW()),
(UUID(), 'coffee', '/ˈkɒfi/', NULL, '[{"partOfSpeech":"n.","definition":"a brown drink","translation":"咖啡"}]', '[{"sentence":"Would you like some coffee?","translation":"你想喝咖啡吗？"}]', NULL, 'food', 1, NOW()),
(UUID(), 'tea', '/tiː/', NULL, '[{"partOfSpeech":"n.","definition":"a hot drink made from leaves","translation":"茶"}]', '[{"sentence":"Chinese tea is famous.","translation":"中国茶很有名。"}]', NULL, 'food', 1, NOW()),
(UUID(), 'rice', '/raɪs/', NULL, '[{"partOfSpeech":"n.","definition":"white grains used as food","translation":"米饭"}]', '[{"sentence":"We eat rice every day.","translation":"我们每天吃米饭。"}]', NULL, 'food', 1, NOW()),
(UUID(), 'meat', '/miːt/', NULL, '[{"partOfSpeech":"n.","definition":"animal flesh as food","translation":"肉"}]', '[{"sentence":"I do not eat meat.","translation":"我不吃肉。"}]', NULL, 'food', 1, NOW()),
(UUID(), 'fish', '/fɪʃ/', NULL, '[{"partOfSpeech":"n.","definition":"an animal living in water","translation":"鱼"}]', '[{"sentence":"I like eating fish.","translation":"我喜欢吃鱼。"}]', NULL, 'food', 1, NOW()),
(UUID(), 'egg', '/eɡ/', NULL, '[{"partOfSpeech":"n.","definition":"round object from birds","translation":"鸡蛋"}]', '[{"sentence":"I have two eggs for breakfast.","translation":"我早餐吃两个鸡蛋。"}]', NULL, 'food', 1, NOW()),
(UUID(), 'fruit', '/fruːt/', NULL, '[{"partOfSpeech":"n.","definition":"the part of a plant that contains seeds","translation":"水果"}]', '[{"sentence":"Eating fruit is healthy.","translation":"吃水果很健康。"}]', NULL, 'food', 1, NOW()),
(UUID(), 'vegetable', '/ˈvedʒtəbl/', NULL, '[{"partOfSpeech":"n.","definition":"a plant grown for food","translation":"蔬菜"}]', '[{"sentence":"Vegetables are good for health.","translation":"蔬菜对健康有益。"}]', NULL, 'food', 2, NOW()),

-- Animal Words
(UUID(), 'dog', '/dɒɡ/', NULL, '[{"partOfSpeech":"n.","definition":"a common pet animal","translation":"狗"}]', '[{"sentence":"The dog is my friend.","translation":"这只狗是我的朋友。"}]', NULL, 'animals', 1, NOW()),
(UUID(), 'cat', '/kæt/', NULL, '[{"partOfSpeech":"n.","definition":"a small furry animal","translation":"猫"}]', '[{"sentence":"The cat is sleeping.","translation":"猫在睡觉。"}]', NULL, 'animals', 1, NOW()),
(UUID(), 'bird', '/bɜːd/', NULL, '[{"partOfSpeech":"n.","definition":"an animal with wings","translation":"鸟"}]', '[{"sentence":"The bird can fly.","translation":"鸟会飞。"}]', NULL, 'animals', 1, NOW()),
(UUID(), 'horse', '/hɔːs/', NULL, '[{"partOfSpeech":"n.","definition":"a large animal for riding","translation":"马"}]', '[{"sentence":"The horse runs fast.","translation":"马跑得很快。"}]', NULL, 'animals', 1, NOW()),
(UUID(), 'cow', '/kaʊ/', NULL, '[{"partOfSpeech":"n.","definition":"a large farm animal","translation":"牛"}]', '[{"sentence":"Cows give us milk.","translation":"牛给我们牛奶。"}]', NULL, 'animals', 1, NOW()),
(UUID(), 'sheep', '/ʃiːp/', NULL, '[{"partOfSpeech":"n.","definition":"a farm animal with wool","translation":"羊"}]', '[{"sentence":"Sheep live in the fields.","translation":"羊生活在田野里。"}]', NULL, 'animals', 1, NOW()),
(UUID(), 'pig', '/pɪɡ/', NULL, '[{"partOfSpeech":"n.","definition":"a farm animal with a snout","translation":"猪"}]', '[{"sentence":"Pigs are smart animals.","translation":"猪是聪明的动物。"}]', NULL, 'animals', 1, NOW()),
(UUID(), 'chicken', '/ˈtʃɪkɪn/', NULL, '[{"partOfSpeech":"n.","definition":"a bird kept for eggs and meat","translation":"鸡"}]', '[{"sentence":"We have chickens on the farm.","translation":"农场里有鸡。"}]', NULL, 'animals', 1, NOW()),
(UUID(), 'fish', '/fɪʃ/', NULL, '[{"partOfSpeech":"n.","definition":"an animal living in water","translation":"鱼"}]', '[{"sentence":"Fish swim in the river.","translation":"鱼在河里游泳。"}]', NULL, 'animals', 1, NOW()),
(UUID(), 'elephant', '/ˈelɪfənt/', NULL, '[{"partOfSpeech":"n.","definition":"a very large animal","translation":"大象"}]', '[{"sentence":"Elephants are intelligent.","translation":"大象很聪明。"}]', NULL, 'animals', 2, NOW()),

-- Action Words
(UUID(), 'read', '/riːd/', NULL, '[{"partOfSpeech":"v.","definition":"to look at and understand written words","translation":"阅读"}]', '[{"sentence":"I like to read books.","translation":"我喜欢读书。"}]', NULL, 'activities', 1, NOW()),
(UUID(), 'write', '/raɪt/', NULL, '[{"partOfSpeech":"v.","definition":"to make letters with a pen","translation":"写"}]', '[{"sentence":"Please write your name.","translation":"请写下你的名字。"}]', NULL, 'activities', 1, NOW()),
(UUID(), 'speak', '/spiːk/', NULL, '[{"partOfSpeech":"v.","definition":"to say words","translation":"说，讲"}]', '[{"sentence":"Can you speak English?","translation":"你会说英语吗？"}]', NULL, 'communication', 1, NOW()),
(UUID(), 'listen', '/ˈlɪsn/', NULL, '[{"partOfSpeech":"v.","definition":"to try to hear","translation":"听"}]', '[{"sentence":"Listen to the teacher.","translation":"听老师讲课。"}]', NULL, 'communication', 1, NOW()),
(UUID(), 'watch', '/wɒtʃ/', NULL, '[{"partOfSpeech":"v.","definition":"to look at something for a time","translation":"观看"}]', '[{"sentence":"I watch TV every evening.","translation":"我每晚看电视。"}]', NULL, 'activities', 1, NOW()),
(UUID(), 'eat', '/iːt/', NULL, '[{"partOfSpeech":"v.","definition":"to put food in the mouth","translation":"吃"}]', '[{"sentence":"Let us eat dinner.","translation":"让我们吃晚饭吧。"}]', NULL, 'activities', 1, NOW()),
(UUID(), 'drink', '/drɪŋk/', NULL, '[{"partOfSpeech":"v.","definition":"to take liquid into the mouth","translation":"喝"}]', '[{"sentence":"I drink water.","translation":"我喝水。"}]', NULL, 'activities', 1, NOW()),
(UUID(), 'sleep', '/sliːp/', NULL, '[{"partOfSpeech":"v.","definition":"to rest with eyes closed","translation":"睡觉"}]', '[{"sentence":"I sleep eight hours a day.","translation":"我每天睡八小时。"}]', NULL, 'activities', 1, NOW()),
(UUID(), 'wake', '/weɪk/', NULL, '[{"partOfSpeech":"v.","definition":"to stop sleeping","translation":"醒来"}]', '[{"sentence":"I wake up early.","translation":"我醒得很早。"}]', NULL, 'activities', 1, NOW()),
(UUID(), 'dream', '/driːm/', NULL, '[{"partOfSpeech":"n.","definition":"pictures in the mind during sleep","translation":"梦"}]', '[{"sentence":"I had a good dream.","translation":"我做了一个好梦。"}]', NULL, 'general', 1, NOW()),

-- Descriptive Words
(UUID(), 'good', '/ɡʊd/', NULL, '[{"partOfSpeech":"adj.","definition":"of high quality","translation":"好的"}]', '[{"sentence":"This is a good book.","translation":"这是一本好书。"}]', NULL, 'descriptions', 1, NOW()),
(UUID(), 'bad', '/bæd/', NULL, '[{"partOfSpeech":"adj.","definition":"of low quality","translation":"坏的"}]', '[{"sentence":"This is bad weather.","translation":"天气很糟糕。"}]', NULL, 'descriptions', 1, NOW()),
(UUID(), 'big', '/bɪɡ/', NULL, '[{"partOfSpeech":"adj.","definition":"of large size","translation":"大的"}]', '[{"sentence":"This is a big house.","translation":"这是一个大房子。"}]', NULL, 'descriptions', 1, NOW()),
(UUID(), 'small', '/smɔːl/', NULL, '[{"partOfSpeech":"adj.","definition":"of little size","translation":"小的"}]', '[{"sentence":"I have a small dog.","translation":"我有一只小狗。"}]', NULL, 'descriptions', 1, NOW()),
(UUID(), 'new', '/njuː/', NULL, '[{"partOfSpeech":"adj.","definition":"not old","translation":"新的"}]', '[{"sentence":"I have a new car.","translation":"我有一辆新车。"}]', NULL, 'descriptions', 1, NOW()),
(UUID(), 'old', '/əʊld/', NULL, '[{"partOfSpeech":"adj.","definition":"having lived for a long time","translation":"旧的，老的"}]', '[{"sentence":"This is an old book.","translation":"这是一本旧书。"}]', NULL, 'descriptions', 1, NOW()),
(UUID(), 'young', '/jʌŋ/', NULL, '[{"partOfSpeech":"adj.","definition":"not old","translation":"年轻的"}]', '[{"sentence":"She is young and beautiful.","translation":"她年轻漂亮。"}]', NULL, 'descriptions', 1, NOW()),
(UUID(), 'fast', '/fɑːst/', NULL, '[{"partOfSpeech":"adj.","definition":"moving quickly","translation":"快的"}]', '[{"sentence":"The car is fast.","translation":"这辆车很快。"}]', NULL, 'descriptions', 1, NOW()),
(UUID(), 'slow', '/sləʊ/', NULL, '[{"partOfSpeech":"adj.","definition":"not fast","translation":"慢的"}]', '[{"sentence":"The turtle is slow.","translation":"乌龟很慢。"}]', NULL, 'descriptions', 1, NOW()),
(UUID(), 'easy', '/ˈiːzi/', NULL, '[{"partOfSpeech":"adj.","definition":"not difficult","translation":"容易的"}]', '[{"sentence":"This question is easy.","translation":"这个问题很简单。"}]', NULL, 'descriptions', 1, NOW()),

-- More Advanced Words (Difficulty 3)
(UUID(), 'difficult', '/ˈdɪfɪkəlt/', NULL, '[{"partOfSpeech":"adj.","definition":"not easy","translation":"困难的"}]', '[{"sentence":"This is a difficult problem.","translation":"这是一个困难的问题。"}]', NULL, 'descriptions', 2, NOW()),
(UUID(), 'possible', '/ˈpɒsəbl/', NULL, '[{"partOfSpeech":"adj.","definition":"that can happen","translation":"可能的"}]', '[{"sentence":"Everything is possible.","translation":"一切皆有可能。"}]', NULL, 'general', 3, NOW()),
(UUID(), 'necessary', '/ˈnesəsəri/', NULL, '[{"partOfSpeech":"adj.","definition":"needed","translation":"必要的"}]', '[{"sentence":"Sleep is necessary for health.","translation":"睡眠对健康是必要的。"}]', NULL, 'general', 3, NOW()),
(UUID(), 'wonderful', '/ˈwʌndəfl/', NULL, '[{"partOfSpeech":"adj.","definition":"very good","translation":"精彩的"}]', '[{"sentence":"What a wonderful day!","translation":"多么美好的一天！"}]', NULL, 'descriptions', 2, NOW()),
(UUID(), 'excellent', '/ˈeksələnt/', NULL, '[{"partOfSpeech":"adj.","definition":"very good","translation":"优秀的"}]', '[{"sentence":"You did an excellent job.","translation":"你做得很好。"}]', NULL, 'descriptions', 3, NOW()),
(UUID(), 'special', '/ˈspeʃl/', NULL, '[{"partOfSpeech":"adj.","definition":"not ordinary","translation":"特别的"}]', '[{"sentence":"Today is a special day.","translation":"今天是一个特殊的日子。"}]', NULL, 'descriptions', 2, NOW()),
(UUID(), 'correct', '/kəˈrekt/', NULL, '[{"partOfSpeech":"adj.","definition":"right, not wrong","translation":"正确的"}]', '[{"sentence":"Your answer is correct.","translation":"你的答案正确。"}]', NULL, 'general', 2, NOW()),
(UUID(), 'wrong', '/rɒŋ/', NULL, '[{"partOfSpeech":"adj.","definition":"not correct","translation":"错误的"}]', '[{"sentence":"That is the wrong answer.","translation":"那是错误的答案。"}]', NULL, 'general', 1, NOW()),
(UUID(), 'together', '/təˈɡeðə/', NULL, '[{"partOfSpeech":"adv.","definition":"with each other","translation":"一起"}]', '[{"sentence":"Let us go together.","translation":"让我们一起去。"}]', NULL, 'general', 2, NOW()),
(UUID(), 'always', '/ˈɔːlweɪz/', NULL, '[{"partOfSpeech":"adv.","definition":"at all times","translation":"总是"}]', '[{"sentence":"I always get up early.","translation":"我总是早起。"}]', NULL, 'general', 2, NOW());

-- Add more words to reach 100+
INSERT INTO words (id, word, phonetic, pronunciation, meanings, examples, image, category, difficulty, createdAt) VALUES
(UUID(), 'never', '/ˈnevə/', NULL, '[{"partOfSpeech":"adv.","definition":"at no time","translation":"从不"}]', '[{"sentence":"I never smoke.","translation":"我从不吸烟。"}]', NULL, 'general', 2, NOW()),
(UUID(), 'sometimes', '/ˈsʌmtaɪmz/', NULL, '[{"partOfSpeech":"adv.","definition":"occasionally","translation":"有时"}]', '[{"sentence":"I sometimes go there.","translation":"我有时去那里。"}]', NULL, 'general', 2, NOW()),
(UUID(), 'often', '/ˈɒfn/', NULL, '[{"partOfSpeech":"adv.","definition":"many times","translation":"经常"}]', '[{"sentence":"I often visit my parents.","translation":"我经常去看望父母。"}]', NULL, 'general', 2, NOW()),
(UUID(), 'usually', '/ˈjuːʒuəli/', NULL, '[{"partOfSpeech":"adv.","definition":"normally","translation":"通常"}]', '[{"sentence":"I usually walk to work.","translation":"我通常走路去上班。"}]', NULL, 'general', 2, NOW()),
(UUID(), 'really', '/ˈriːəli/', NULL, '[{"partOfSpeech":"adv.","definition":"in fact","translation":"真正地"}]', '[{"sentence":"I really like it.","translation":"我真的很喜欢。"}]', NULL, 'general', 2, NOW()),
(UUID(), 'very', '/ˈveri/', NULL, '[{"partOfSpeech":"adv.","definition":"to a high degree","translation":"非常"}]', '[{"sentence":"It is very cold today.","translation":"今天很冷。"}]', NULL, 'general', 1, NOW()),
(UUID(), 'quite', '/kwaɪt/', NULL, '[{"partOfSpeech":"adv.","definition":"fairly","translation":"相当"}]', '[{"sentence":"It is quite warm.","translation":"天气相当暖和。"}]', NULL, 'general', 2, NOW()),
(UUID(), 'just', '/dʒʌst/', NULL, '[{"partOfSpeech":"adv.","definition":"only","translation":"只是"}]', '[{"sentence":"I just want to help.","translation":"我只是想帮忙。"}]', NULL, 'general', 1, NOW()),
(UUID(), 'now', '/naʊ/', NULL, '[{"partOfSpeech":"adv.","definition":"at the present time","translation":"现在"}]', '[{"sentence":"I am busy now.","translation":"我现在很忙。"}]', NULL, 'general', 1, NOW()),
(UUID(), 'then', '/ðen/', NULL, '[{"partOfSpeech":"adv.","definition":"at that time","translation":"那时"}]', '[{"sentence":"I was young then.","translation":"那时我还年轻。"}]', NULL, 'general', 1, NOW());

SELECT COUNT(*) as total_words FROM words;