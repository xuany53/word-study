-- RAZ单词库导入脚本
-- RAZ (Reading A-Z) Graded Vocabulary
-- 从aa级到Z级，每个级别20-30个核心单词

SET NAMES utf8mb4;

USE word_study;

-- ============================================
-- RAZ aa 级 - 最基础词汇（约30词）
-- ============================================
INSERT INTO words (id, word, phonetic, pronunciation, meanings, examples, image, category, difficulty, createdAt) VALUES
-- 动物
(UUID(), 'cat', '/kæt/', NULL, '[{"partOfSpeech":"n.","definition":"a small furry pet","translation":"猫"}]', '[{"sentence":"The cat is sleeping.","translation":"猫在睡觉。"}]', NULL, 'raz-aa', 1, NOW()),
(UUID(), 'dog', '/dɒɡ/', NULL, '[{"partOfSpeech":"n.","definition":"a loyal pet animal","translation":"狗"}]', '[{"sentence":"I have a dog.","translation":"我有一只狗。"}]', NULL, 'raz-aa', 1, NOW()),
(UUID(), 'bird', '/bɜːd/', NULL, '[{"partOfSpeech":"n.","definition":"an animal with wings","translation":"鸟"}]', '[{"sentence":"The bird can fly.","translation":"鸟会飞。"}]', NULL, 'raz-aa', 1, NOW()),
(UUID(), 'fish', '/fɪʃ/', NULL, '[{"partOfSpeech":"n.","definition":"an animal that lives in water","translation":"鱼"}]', '[{"sentence":"The fish swims.","translation":"鱼在游泳。"}]', NULL, 'raz-aa', 1, NOW()),
(UUID(), 'pig', '/pɪɡ/', NULL, '[{"partOfSpeech":"n.","definition":"a farm animal","translation":"猪"}]', '[{"sentence":"The pig is pink.","translation":"猪是粉红色的。"}]', NULL, 'raz-aa', 1, NOW()),
-- 颜色
(UUID(), 'red', '/red/', NULL, '[{"partOfSpeech":"adj.","definition":"the color of fire","translation":"红色的"}]', '[{"sentence":"The apple is red.","translation":"苹果是红色的。"}]', NULL, 'raz-aa', 1, NOW()),
(UUID(), 'blue', '/bluː/', NULL, '[{"partOfSpeech":"adj.","definition":"the color of sky","translation":"蓝色的"}]', '[{"sentence":"The sky is blue.","translation":"天空是蓝色的。"}]', NULL, 'raz-aa', 1, NOW()),
(UUID(), 'green', '/ɡriːn/', NULL, '[{"partOfSpeech":"adj.","definition":"the color of grass","translation":"绿色的"}]', '[{"sentence":"The grass is green.","translation":"草是绿色的。"}]', NULL, 'raz-aa', 1, NOW()),
(UUID(), 'yellow', '/ˈjeləʊ/', NULL, '[{"partOfSpeech":"adj.","definition":"the color of sun","translation":"黄色的"}]', '[{"sentence":"The banana is yellow.","translation":"香蕉是黄色的。"}]', NULL, 'raz-aa', 1, NOW()),
-- 家庭
(UUID(), 'mom', '/mɒm/', NULL, '[{"partOfSpeech":"n.","definition":"mother","translation":"妈妈"}]', '[{"sentence":"I love my mom.","translation":"我爱我的妈妈。"}]', NULL, 'raz-aa', 1, NOW()),
(UUID(), 'dad', '/dæd/', NULL, '[{"partOfSpeech":"n.","definition":"father","translation":"爸爸"}]', '[{"sentence":"My dad is tall.","translation":"我爸爸很高。"}]', NULL, 'raz-aa', 1, NOW()),
(UUID(), 'baby', '/ˈbeɪbi/', NULL, '[{"partOfSpeech":"n.","definition":"a very young child","translation":"宝宝"}]', '[{"sentence":"The baby is cute.","translation":"宝宝很可爱。"}]', NULL, 'raz-aa', 1, NOW()),
-- 基础名词
(UUID(), 'ball', '/bɔːl/', NULL, '[{"partOfSpeech":"n.","definition":"a round object for playing","translation":"球"}]', '[{"sentence":"Throw the ball.","translation":"扔球。"}]', NULL, 'raz-aa', 1, NOW()),
(UUID(), 'bed', '/bed/', NULL, '[{"partOfSpeech":"n.","definition":"furniture for sleeping","translation":"床"}]', '[{"sentence":"I sleep in my bed.","translation":"我在床上睡觉。"}]', NULL, 'raz-aa', 1, NOW()),
(UUID(), 'car', '/kɑː/', NULL, '[{"partOfSpeech":"n.","definition":"a vehicle","translation":"汽车"}]', '[{"sentence":"This is my car.","translation":"这是我的汽车。"}]', NULL, 'raz-aa', 1, NOW()),
(UUID(), 'egg', '/eɡ/', NULL, '[{"partOfSpeech":"n.","definition":"oval food from hens","translation":"鸡蛋"}]', '[{"sentence":"I eat eggs for breakfast.","translation":"我早餐吃鸡蛋。"}]', NULL, 'raz-aa', 1, NOW()),
(UUID(), 'milk', '/mɪlk/', NULL, '[{"partOfSpeech":"n.","definition":"white drink from cows","translation":"牛奶"}]', '[{"sentence":"I drink milk.","translation":"我喝牛奶。"}]', NULL, 'raz-aa', 1, NOW()),
(UUID(), 'sun', '/sʌn/', NULL, '[{"partOfSpeech":"n.","definition":"the star in the sky","translation":"太阳"}]', '[{"sentence":"The sun is bright.","translation":"太阳很亮。"}]', NULL, 'raz-aa', 1, NOW()),
(UUID(), 'moon', '/muːn/', NULL, '[{"partOfSpeech":"n.","definition":"round object in night sky","translation":"月亮"}]', '[{"sentence":"The moon is full tonight.","translation":"今晚月亮很圆。"}]', NULL, 'raz-aa', 1, NOW()),
(UUID(), 'tree', '/triː/', NULL, '[{"partOfSpeech":"n.","definition":"a tall plant","translation":"树"}]', '[{"sentence":"The tree is big.","translation":"这棵树很大。"}]', NULL, 'raz-aa', 1, NOW()),

-- ============================================
-- RAZ A 级 - 基础词汇（约30词）
-- ============================================
(UUID(), 'jump', '/dʒʌmp/', NULL, '[{"partOfSpeech":"v.","definition":"to move up in the air","translation":"跳"}]', '[{"sentence":"I can jump high.","translation":"我能跳得很高。"}]', NULL, 'raz-a', 1, NOW()),
(UUID(), 'run', '/rʌn/', NULL, '[{"partOfSpeech":"v.","definition":"to move fast on feet","translation":"跑"}]', '[{"sentence":"I run to school.","translation":"我跑到学校。"}]', NULL, 'raz-a', 1, NOW()),
(UUID(), 'walk', '/wɔːk/', NULL, '[{"partOfSpeech":"v.","definition":"to move slowly on feet","translation":"走"}]', '[{"sentence":"I walk my dog.","translation":"我遛狗。"}]', NULL, 'raz-a', 1, NOW()),
(UUID(), 'swim', '/swɪm/', NULL, '[{"partOfSpeech":"v.","definition":"to move in water","translation":"游泳"}]', '[{"sentence":"Fish can swim.","translation":"鱼会游泳。"}]', NULL, 'raz-a', 1, NOW()),
(UUID(), 'fly', '/flaɪ/', NULL, '[{"partOfSpeech":"v.","definition":"to move through air","translation":"飞"}]', '[{"sentence":"Birds can fly.","translation":"鸟会飞。"}]', NULL, 'raz-a', 1, NOW()),
(UUID(), 'eat', '/iːt/', NULL, '[{"partOfSpeech":"v.","definition":"to put food in mouth","translation":"吃"}]', '[{"sentence":"I eat an apple.","translation":"我吃一个苹果。"}]', NULL, 'raz-a', 1, NOW()),
(UUID(), 'drink', '/drɪŋk/', NULL, '[{"partOfSpeech":"v.","definition":"to swallow liquid","translation":"喝"}]', '[{"sentence":"I drink water.","translation":"我喝水。"}]', NULL, 'raz-a', 1, NOW()),
(UUID(), 'sleep', '/sliːp/', NULL, '[{"partOfSpeech":"v.","definition":"to rest with eyes closed","translation":"睡觉"}]', '[{"sentence":"I sleep at night.","translation":"我晚上睡觉。"}]', NULL, 'raz-a', 1, NOW()),
(UUID(), 'play', '/pleɪ/', NULL, '[{"partOfSpeech":"v.","definition":"to have fun","translation":"玩"}]', '[{"sentence":"I play with my friends.","translation":"我和朋友一起玩。"}]', NULL, 'raz-a', 1, NOW()),
(UUID(), 'sing', '/sɪŋ/', NULL, '[{"partOfSpeech":"v.","definition":"to make music with voice","translation":"唱歌"}]', '[{"sentence":"I like to sing.","translation":"我喜欢唱歌。"}]', NULL, 'raz-a', 1, NOW()),
(UUID(), 'read', '/riːd/', NULL, '[{"partOfSpeech":"v.","definition":"to look at words","translation":"阅读"}]', '[{"sentence":"I read books.","translation":"我读书。"}]', NULL, 'raz-a', 1, NOW()),
(UUID(), 'write', '/raɪt/', NULL, '[{"partOfSpeech":"v.","definition":"to make letters","translation":"写"}]', '[{"sentence":"I write my name.","translation":"我写我的名字。"}]', NULL, 'raz-a', 1, NOW()),
(UUID(), 'draw', '/drɔː/', NULL, '[{"partOfSpeech":"v.","definition":"to make pictures","translation":"画画"}]', '[{"sentence":"I draw a cat.","translation":"我画了一只猫。"}]', NULL, 'raz-a', 1, NOW()),
(UUID(), 'paint', '/peɪnt/', NULL, '[{"partOfSpeech":"v.","definition":"to color with brush","translation":"绘画，涂色"}]', '[{"sentence":"I paint a flower.","translation":"我画了一朵花。"}]', NULL, 'raz-a', 1, NOW()),
(UUID(), 'climb', '/klaɪm/', NULL, '[{"partOfSpeech":"v.","definition":"to go up","translation":"爬"}]', '[{"sentence":"I climb the tree.","translation":"我爬树。"}]', NULL, 'raz-a', 1, NOW()),

-- ============================================
-- RAZ B 级 - 常用词汇（约30词）
-- ============================================
(UUID(), 'big', '/bɪɡ/', NULL, '[{"partOfSpeech":"adj.","definition":"large in size","translation":"大的"}]', '[{"sentence":"The elephant is big.","translation":"大象很大。"}]', NULL, 'raz-b', 1, NOW()),
(UUID(), 'small', '/smɔːl/', NULL, '[{"partOfSpeech":"adj.","definition":"little in size","translation":"小的"}]', '[{"sentence":"The mouse is small.","translation":"老鼠很小。"}]', NULL, 'raz-b', 1, NOW()),
(UUID(), 'tall', '/tɔːl/', NULL, '[{"partOfSpeech":"adj.","definition":"high in height","translation":"高的"}]', '[{"sentence":"He is tall.","translation":"他很高。"}]', NULL, 'raz-b', 1, NOW()),
(UUID(), 'short', '/ʃɔːt/', NULL, '[{"partOfSpeech":"adj.","definition":"not tall","translation":"矮的，短的"}]', '[{"sentence":"She is short.","translation":"她很矮。"}]', NULL, 'raz-b', 1, NOW()),
(UUID(), 'long', '/lɒŋ/', NULL, '[{"partOfSpeech":"adj.","definition":"not short","translation":"长的"}]', '[{"sentence":"The snake is long.","translation":"蛇很长。"}]', NULL, 'raz-b', 1, NOW()),
(UUID(), 'hot', '/hɒt/', NULL, '[{"partOfSpeech":"adj.","definition":"high temperature","translation":"热的"}]', '[{"sentence":"The soup is hot.","translation":"汤很热。"}]', NULL, 'raz-b', 1, NOW()),
(UUID(), 'cold', '/kəʊld/', NULL, '[{"partOfSpeech":"adj.","definition":"low temperature","translation":"冷的"}]', '[{"sentence":"The ice is cold.","translation":"冰是冷的。"}]', NULL, 'raz-b', 1, NOW()),
(UUID(), 'fast', '/fɑːst/', NULL, '[{"partOfSpeech":"adj.","definition":"moving quickly","translation":"快的"}]', '[{"sentence":"The cheetah is fast.","translation":"猎豹很快。"}]', NULL, 'raz-b', 1, NOW()),
(UUID(), 'slow', '/sləʊ/', NULL, '[{"partOfSpeech":"adj.","definition":"not fast","translation":"慢的"}]', '[{"sentence":"The turtle is slow.","translation":"乌龟很慢。"}]', NULL, 'raz-b', 1, NOW()),
(UUID(), 'new', '/njuː/', NULL, '[{"partOfSpeech":"adj.","definition":"not old","translation":"新的"}]', '[{"sentence":"I have a new toy.","translation":"我有一个新玩具。"}]', NULL, 'raz-b', 1, NOW()),
(UUID(), 'old', '/əʊld/', NULL, '[{"partOfSpeech":"adj.","definition":"not young or new","translation":"旧的，老的"}]', '[{"sentence":"This is an old book.","translation":"这是一本旧书。"}]', NULL, 'raz-b', 1, NOW()),
(UUID(), 'good', '/ɡʊd/', NULL, '[{"partOfSpeech":"adj.","definition":"nice, positive","translation":"好的"}]', '[{"sentence":"You are good!","translation":"你真棒！"}]', NULL, 'raz-b', 1, NOW()),
(UUID(), 'bad', '/bæd/', NULL, '[{"partOfSpeech":"adj.","definition":"not good","translation":"坏的"}]', '[{"sentence":"The weather is bad.","translation":"天气不好。"}]', NULL, 'raz-b', 1, NOW()),
(UUID(), 'happy', '/ˈhæpi/', NULL, '[{"partOfSpeech":"adj.","definition":"feeling joy","translation":"快乐的"}]', '[{"sentence":"I am happy.","translation":"我很快乐。"}]', NULL, 'raz-b', 1, NOW()),
(UUID(), 'sad', '/sæd/', NULL, '[{"partOfSpeech":"adj.","definition":"not happy","translation":"伤心的"}]', '[{"sentence":"He looks sad.","translation":"他看起来很伤心。"}]', NULL, 'raz-b', 1, NOW()),

-- ============================================
-- RAZ C 级 - 进阶基础词汇（约30词）
-- ============================================
(UUID(), 'teacher', '/ˈtiːtʃə/', NULL, '[{"partOfSpeech":"n.","definition":"a person who teaches","translation":"老师"}]', '[{"sentence":"My teacher is kind.","translation":"我的老师很和蔼。"}]', NULL, 'raz-c', 2, NOW()),
(UUID(), 'student', '/ˈstjuːdənt/', NULL, '[{"partOfSpeech":"n.","definition":"a person who learns","translation":"学生"}]', '[{"sentence":"I am a student.","translation":"我是一名学生。"}]', NULL, 'raz-c', 2, NOW()),
(UUID(), 'classroom', '/ˈklɑːsruːm/', NULL, '[{"partOfSpeech":"n.","definition":"a room for learning","translation":"教室"}]', '[{"sentence":"We are in the classroom.","translation":"我们在教室里。"}]', NULL, 'raz-c', 2, NOW()),
(UUID(), 'playground', '/ˈpleɪɡraʊnd/', NULL, '[{"partOfSpeech":"n.","definition":"a place for playing","translation":"操场"}]', '[{"sentence":"We play on the playground.","translation":"我们在操场上玩。"}]', NULL, 'raz-c', 2, NOW()),
(UUID(), 'lunch', '/lʌntʃ/', NULL, '[{"partOfSpeech":"n.","definition":"midday meal","translation":"午餐"}]', '[{"sentence":"I eat lunch at school.","translation":"我在学校吃午餐。"}]', NULL, 'raz-c', 2, NOW()),
(UUID(), 'breakfast', '/ˈbrekfəst/', NULL, '[{"partOfSpeech":"n.","definition":"morning meal","translation":"早餐"}]', '[{"sentence":"I have breakfast at 7.","translation":"我7点吃早餐。"}]', NULL, 'raz-c', 2, NOW()),
(UUID(), 'dinner', '/ˈdɪnə/', NULL, '[{"partOfSpeech":"n.","definition":"evening meal","translation":"晚餐"}]', '[{"sentence":"We eat dinner together.","translation":"我们一起吃晚餐。"}]', NULL, 'raz-c', 2, NOW()),
(UUID(), 'morning', '/ˈmɔːnɪŋ/', NULL, '[{"partOfSpeech":"n.","definition":"early part of day","translation":"早上"}]', '[{"sentence":"Good morning!","translation":"早上好！"}]', NULL, 'raz-c', 2, NOW()),
(UUID(), 'afternoon', '/ˌɑːftəˈnuːn/', NULL, '[{"partOfSpeech":"n.","definition":"middle of day","translation":"下午"}]', '[{"sentence":"Good afternoon!","translation":"下午好！"}]', NULL, 'raz-c', 2, NOW()),
(UUID(), 'evening', '/ˈiːvnɪŋ/', NULL, '[{"partOfSpeech":"n.","definition":"end of day","translation":"晚上"}]', '[{"sentence":"Good evening!","translation":"晚上好！"}]', NULL, 'raz-c', 2, NOW()),
(UUID(), 'night', '/naɪt/', NULL, '[{"partOfSpeech":"n.","definition":"dark time","translation":"夜晚"}]', '[{"sentence":"Good night!","translation":"晚安！"}]', NULL, 'raz-c', 2, NOW()),
(UUID(), 'today', '/təˈdeɪ/', NULL, '[{"partOfSpeech":"n.","definition":"this day","translation":"今天"}]', '[{"sentence":"Today is Monday.","translation":"今天是星期一。"}]', NULL, 'raz-c', 2, NOW()),
(UUID(), 'tomorrow', '/təˈmɒrəʊ/', NULL, '[{"partOfSpeech":"n.","definition":"the next day","translation":"明天"}]', '[{"sentence":"Tomorrow is Tuesday.","translation":"明天是星期二。"}]', NULL, 'raz-c', 2, NOW()),
(UUID(), 'yesterday', '/ˈjestədeɪ/', NULL, '[{"partOfSpeech":"n.","definition":"the day before","translation":"昨天"}]', '[{"sentence":"Yesterday was Sunday.","translation":"昨天是星期日。"}]', NULL, 'raz-c', 2, NOW()),
(UUID(), 'week', '/wiːk/', NULL, '[{"partOfSpeech":"n.","definition":"seven days","translation":"星期，周"}]', '[{"sentence":"There are seven days in a week.","translation":"一周有七天。"}]', NULL, 'raz-c', 2, NOW()),

-- ============================================
-- RAZ D 级 - 扩展词汇（约30词）
-- ============================================
(UUID(), 'spring', '/sprɪŋ/', NULL, '[{"partOfSpeech":"n.","definition":"season after winter","translation":"春天"}]', '[{"sentence":"Flowers bloom in spring.","translation":"春天花朵盛开。"}]', NULL, 'raz-d', 2, NOW()),
(UUID(), 'summer', '/ˈsʌmə/', NULL, '[{"partOfSpeech":"n.","definition":"hottest season","translation":"夏天"}]', '[{"sentence":"We swim in summer.","translation":"我们夏天游泳。"}]', NULL, 'raz-d', 2, NOW()),
(UUID(), 'fall', '/fɔːl/', NULL, '[{"partOfSpeech":"n.","definition":"season after summer","translation":"秋天"}]', '[{"sentence":"Leaves fall in autumn.","translation":"秋天树叶落下。"}]', NULL, 'raz-d', 2, NOW()),
(UUID(), 'winter', '/ˈwɪntə/', NULL, '[{"partOfSpeech":"n.","definition":"coldest season","translation":"冬天"}]', '[{"sentence":"It snows in winter.","translation":"冬天会下雪。"}]', NULL, 'raz-d', 2, NOW()),
(UUID(), 'weather', '/ˈweðə/', NULL, '[{"partOfSpeech":"n.","definition":"condition of air","translation":"天气"}]', '[{"sentence":"The weather is nice.","translation":"天气很好。"}]', NULL, 'raz-d', 2, NOW()),
(UUID(), 'cloud', '/klaʊd/', NULL, '[{"partOfSpeech":"n.","definition":"white in sky","translation":"云"}]', '[{"sentence":"Look at the cloud.","translation":"看那朵云。"}]', NULL, 'raz-d', 2, NOW()),
(UUID(), 'rain', '/reɪn/', NULL, '[{"partOfSpeech":"n.","definition":"water from sky","translation":"雨"}]', '[{"sentence":"The rain is falling.","translation":"正在下雨。"}]', NULL, 'raz-d', 2, NOW()),
(UUID(), 'snow', '/snəʊ/', NULL, '[{"partOfSpeech":"n.","definition":"frozen rain","translation":"雪"}]', '[{"sentence":"The snow is white.","translation":"雪是白色的。"}]', NULL, 'raz-d', 2, NOW()),
(UUID(), 'wind', '/wɪnd/', NULL, '[{"partOfSpeech":"n.","definition":"moving air","translation":"风"}]', '[{"sentence":"The wind is strong.","translation":"风很大。"}]', NULL, 'raz-d', 2, NOW()),
(UUID(), 'flower', '/ˈflaʊə/', NULL, '[{"partOfSpeech":"n.","definition":"colorful plant part","translation":"花"}]', '[{"sentence":"The flower is beautiful.","translation":"这朵花很美。"}]', NULL, 'raz-d', 2, NOW()),
(UUID(), 'garden', '/ˈɡɑːdən/', NULL, '[{"partOfSpeech":"n.","definition":"place to grow plants","translation":"花园"}]', '[{"sentence":"I work in the garden.","translation":"我在花园里干活。"}]', NULL, 'raz-d', 2, NOW()),
(UUID(), 'farm', '/fɑːm/', NULL, '[{"partOfSpeech":"n.","definition":"land for growing food","translation":"农场"}]', '[{"sentence":"We visit a farm.","translation":"我们参观农场。"}]', NULL, 'raz-d', 2, NOW()),
(UUID(), 'city', '/ˈsɪti/', NULL, '[{"partOfSpeech":"n.","definition":"large town","translation":"城市"}]', '[{"sentence":"I live in a city.","translation":"我住在城市里。"}]', NULL, 'raz-d', 2, NOW()),
(UUID(), 'country', '/ˈkʌntri/', NULL, '[{"partOfSpeech":"n.","definition":"a nation","translation":"国家"}]', '[{"sentence":"I love my country.","translation":"我爱我的国家。"}]', NULL, 'raz-d', 2, NOW()),
(UUID(), 'mountain', '/ˈmaʊntən/', NULL, '[{"partOfSpeech":"n.","definition":"very high land","translation":"山"}]', '[{"sentence":"The mountain is high.","translation":"这座山很高。"}]', NULL, 'raz-d', 2, NOW()),

-- ============================================
-- RAZ E 级 - 进阶词汇（约30词）
-- ============================================
(UUID(), 'help', '/help/', NULL, '[{"partOfSpeech":"v.","definition":"to assist someone","translation":"帮助"}]', '[{"sentence":"Can you help me?","translation":"你能帮我吗？"}]', NULL, 'raz-e', 2, NOW()),
(UUID(), 'make', '/meɪk/', NULL, '[{"partOfSpeech":"v.","definition":"to create something","translation":"制作"}]', '[{"sentence":"I make a cake.","translation":"我做了一个蛋糕。"}]', NULL, 'raz-e', 2, NOW()),
(UUID(), 'take', '/teɪk/', NULL, '[{"partOfSpeech":"v.","definition":"to get and hold","translation":"拿，取"}]', '[{"sentence":"Take this book.","translation":"拿这本书。"}]', NULL, 'raz-e', 2, NOW()),
(UUID(), 'give', '/ɡɪv/', NULL, '[{"partOfSpeech":"v.","definition":"to hand over","translation":"给"}]', '[{"sentence":"Please give me water.","translation":"请给我水。"}]', NULL, 'raz-e', 2, NOW()),
(UUID(), 'find', '/faɪnd/', NULL, '[{"partOfSpeech":"v.","definition":"to discover","translation":"找到"}]', '[{"sentence":"I find my book.","translation":"我找到了我的书。"}]', NULL, 'raz-e', 2, NOW()),
(UUID(), 'look', '/lʊk/', NULL, '[{"partOfSpeech":"v.","definition":"to use eyes","translation":"看"}]', '[{"sentence":"Look at the picture.","translation":"看这幅画。"}]', NULL, 'raz-e', 2, NOW()),
(UUID(), 'listen', '/ˈlɪsn/', NULL, '[{"partOfSpeech":"v.","definition":"to use ears","translation":"听"}]', '[{"sentence":"Listen to the music.","translation":"听音乐。"}]', NULL, 'raz-e', 2, NOW()),
(UUID(), 'hear', '/hɪə/', NULL, '[{"partOfSpeech":"v.","definition":"to perceive sound","translation":"听到"}]', '[{"sentence":"I hear a bird.","translation":"我听到一只鸟。"}]', NULL, 'raz-e', 2, NOW()),
(UUID(), 'feel', '/fiːl/', NULL, '[{"partOfSpeech":"v.","definition":"to touch or sense","translation":"感觉"}]', '[{"sentence":"I feel happy.","translation":"我感到快乐。"}]', NULL, 'raz-e', 2, NOW()),
(UUID(), 'smell', '/smel/', NULL, '[{"partOfSpeech":"v.","definition":"to use nose","translation":"闻"}]', '[{"sentence":"I smell flowers.","translation":"我闻花香。"}]', NULL, 'raz-e', 2, NOW()),
(UUID(), 'taste', '/teɪst/', NULL, '[{"partOfSpeech":"v.","definition":"to use tongue","translation":"尝"}]', '[{"sentence":"Taste the soup.","translation":"尝尝这汤。"}]', NULL, 'raz-e', 2, NOW()),
(UUID(), 'touch', '/tʌtʃ/', NULL, '[{"partOfSpeech":"v.","definition":"to feel with fingers","translation":"触摸"}]', '[{"sentence":"Dont touch!","translation":"不要触摸！"}]', NULL, 'raz-e', 2, NOW()),
(UUID(), 'show', '/ʃəʊ/', NULL, '[{"partOfSpeech":"v.","definition":"to let see","translation":"展示"}]', '[{"sentence":"Show me your book.","translation":"给我看你的书。"}]', NULL, 'raz-e', 2, NOW()),
(UUID(), 'tell', '/tel/', NULL, '[{"partOfSpeech":"v.","definition":"to say to someone","translation":"告诉"}]', '[{"sentence":"Tell me a story.","translation":"给我讲个故事。"}]', NULL, 'raz-e', 2, NOW()),
(UUID(), 'ask', '/ɑːsk/', NULL, '[{"partOfSpeech":"v.","definition":"to question","translation":"问"}]', '[{"sentence":"Ask your teacher.","translation":"问你的老师。"}]', NULL, 'raz-e', 2, NOW()),

-- ============================================
-- RAZ F-H 级 - 中级词汇（约40词）
-- ============================================
(UUID(), 'because', '/bɪˈkɒz/', NULL, '[{"partOfSpeech":"conj.","definition":"for the reason","translation":"因为"}]', '[{"sentence":"I am happy because today is my birthday.","translation":"我很高兴因为今天是我的生日。"}]', NULL, 'raz-f', 3, NOW()),
(UUID(), 'but', '/bʌt/', NULL, '[{"partOfSpeech":"conj.","definition":"however","translation":"但是"}]', '[{"sentence":"I want to go but I cant.","translation":"我想去但是我去不了。"}]', NULL, 'raz-f', 3, NOW()),
(UUID(), 'or', '/ɔː/', NULL, '[{"partOfSpeech":"conj.","definition":"showing choice","translation":"或者"}]', '[{"sentence":"Do you want tea or coffee?","translation":"你想要茶还是咖啡？"}]', NULL, 'raz-f', 3, NOW()),
(UUID(), 'so', '/səʊ/', NULL, '[{"partOfSpeech":"conj.","definition":"therefore","translation":"所以"}]', '[{"sentence":"It is raining so I stay home.","translation":"下雨了所以我待在家。"}]', NULL, 'raz-f', 3, NOW()),
(UUID(), 'when', '/wen/', NULL, '[{"partOfSpeech":"conj.","definition":"at what time","translation":"当...时"}]', '[{"sentence":"When I grow up, I want to be a teacher.","translation":"当我长大后，我想当老师。"}]', NULL, 'raz-f', 3, NOW()),
(UUID(), 'where', '/weə/', NULL, '[{"partOfSpeech":"adv.","definition":"at what place","translation":"哪里"}]', '[{"sentence":"Where do you live?","translation":"你住在哪里？"}]', NULL, 'raz-f', 3, NOW()),
(UUID(), 'why', '/waɪ/', NULL, '[{"partOfSpeech":"adv.","definition":"for what reason","translation":"为什么"}]', '[{"sentence":"Why are you sad?","translation":"你为什么伤心？"}]', NULL, 'raz-f', 3, NOW()),
(UUID(), 'how', '/haʊ/', NULL, '[{"partOfSpeech":"adv.","definition":"in what way","translation":"怎样"}]', '[{"sentence":"How are you?","translation":"你好吗？"}]', NULL, 'raz-f', 3, NOW()),
(UUID(), 'what', '/wɒt/', NULL, '[{"partOfSpeech":"pron.","definition":"what thing","translation":"什么"}]', '[{"sentence":"What is this?","translation":"这是什么？"}]', NULL, 'raz-f', 3, NOW()),
(UUID(), 'who', '/huː/', NULL, '[{"partOfSpeech":"pron.","definition":"what person","translation":"谁"}]', '[{"sentence":"Who is that?","translation":"那是谁？"}]', NULL, 'raz-f', 3, NOW()),
(UUID(), 'sometimes', '/ˈsʌmtaɪmz/', NULL, '[{"partOfSpeech":"adv.","definition":"occasionally","translation":"有时"}]', '[{"sentence":"Sometimes I walk to school.","translation":"有时我走路去学校。"}]', NULL, 'raz-g', 3, NOW()),
(UUID(), 'always', '/ˈɔːlweɪz/', NULL, '[{"partOfSpeech":"adv.","definition":"every time","translation":"总是"}]', '[{"sentence":"I always brush my teeth.","translation":"我总是刷牙。"}]', NULL, 'raz-g', 3, NOW()),
(UUID(), 'never', '/ˈnevə/', NULL, '[{"partOfSpeech":"adv.","definition":"not ever","translation":"从不"}]', '[{"sentence":"I never eat bugs.","translation":"我从不吃虫子。"}]', NULL, 'raz-g', 3, NOW()),
(UUID(), 'usually', '/ˈjuːʒuəli/', NULL, '[{"partOfSpeech":"adv.","definition":"most of the time","translation":"通常"}]', '[{"sentence":"I usually wake up at 7.","translation":"我通常7点醒来。"}]', NULL, 'raz-g', 3, NOW()),
(UUID(), 'often', '/ˈɒfn/', NULL, '[{"partOfSpeech":"adv.","definition":"many times","translation":"经常"}]', '[{"sentence":"I often go to the park.","translation":"我经常去公园。"}]', NULL, 'raz-g', 3, NOW()),
(UUID(), 'before', '/bɪˈfɔː/', NULL, '[{"partOfSpeech":"prep.","definition":"earlier than","translation":"在...之前"}]', '[{"sentence":"Wash your hands before eating.","translation":"吃饭前洗手。"}]', NULL, 'raz-h', 3, NOW()),
(UUID(), 'after', '/ˈɑːftə/', NULL, '[{"partOfSpeech":"prep.","definition":"later than","translation":"在...之后"}]', '[{"sentence":"We play after school.","translation":"放学后我们玩。"}]', NULL, 'raz-h', 3, NOW()),
(UUID(), 'during', '/ˈdjʊərɪŋ/', NULL, '[{"partOfSpeech":"prep.","definition":"throughout","translation":"在...期间"}]', '[{"sentence":"We read during class.","translation":"我们在课上阅读。"}]', NULL, 'raz-h', 3, NOW()),
(UUID(), 'between', '/bɪˈtwiːn/', NULL, '[{"partOfSpeech":"prep.","definition":"in the middle","translation":"在...之间"}]', '[{"sentence":"I sit between my friends.","translation":"我坐在朋友之间。"}]', NULL, 'raz-h', 3, NOW()),
(UUID(), 'around', '/əˈraʊnd/', NULL, '[{"partOfSpeech":"prep.","definition":"on all sides","translation":"围绕"}]', '[{"sentence":"We walk around the park.","translation":"我们在公园周围散步。"}]', NULL, 'raz-h', 3, NOW()),

-- ============================================
-- RAZ I-L 级 - 中高级词汇（约40词）
-- ============================================
(UUID(), 'start', '/stɑːt/', NULL, '[{"partOfSpeech":"v.","definition":"to begin","translation":"开始"}]', '[{"sentence":"Lets start the game.","translation":"让我们开始游戏。"}]', NULL, 'raz-i', 3, NOW()),
(UUID(), 'finish', '/ˈfɪnɪʃ/', NULL, '[{"partOfSpeech":"v.","definition":"to complete","translation":"完成"}]', '[{"sentence":"I finish my homework.","translation":"我完成了作业。"}]', NULL, 'raz-i', 3, NOW()),
(UUID(), 'begin', '/bɪˈɡɪn/', NULL, '[{"partOfSpeech":"v.","definition":"to start","translation":"开始"}]', '[{"sentence":"Class begins at 8.","translation":"8点开始上课。"}]', NULL, 'raz-i', 3, NOW()),
(UUID(), 'end', '/end/', NULL, '[{"partOfSpeech":"v.","definition":"to stop","translation":"结束"}]', '[{"sentence":"The movie ends at 10.","translation":"电影10点结束。"}]', NULL, 'raz-i', 3, NOW()),
(UUID(), 'change', '/tʃeɪndʒ/', NULL, '[{"partOfSpeech":"v.","definition":"to make different","translation":"改变"}]', '[{"sentence":"I change my clothes.","translation":"我换衣服。"}]', NULL, 'raz-i', 3, NOW()),
(UUID(), 'move', '/muːv/', NULL, '[{"partOfSpeech":"v.","definition":"to change position","translation":"移动"}]', '[{"sentence":"Please move your car.","translation":"请移动你的车。"}]', NULL, 'raz-i', 3, NOW()),
(UUID(), 'stay', '/steɪ/', NULL, '[{"partOfSpeech":"v.","definition":"to remain","translation":"停留"}]', '[{"sentence":"Stay here please.","translation":"请待在这里。"}]', NULL, 'raz-i', 3, NOW()),
(UUID(), 'wait', '/weɪt/', NULL, '[{"partOfSpeech":"v.","definition":"to stay until","translation":"等待"}]', '[{"sentence":"Please wait for me.","translation":"请等我。"}]', NULL, 'raz-i', 3, NOW()),
(UUID(), 'try', '/traɪ/', NULL, '[{"partOfSpeech":"v.","definition":"to attempt","translation":"尝试"}]', '[{"sentence":"Try your best!","translation":"尽力而为！"}]', NULL, 'raz-j', 3, NOW()),
(UUID(), 'need', '/niːd/', NULL, '[{"partOfSpeech":"v.","definition":"to require","translation":"需要"}]', '[{"sentence":"I need some help.","translation":"我需要帮助。"}]', NULL, 'raz-j', 3, NOW()),
(UUID(), 'want', '/wɒnt/', NULL, '[{"partOfSpeech":"v.","definition":"to desire","translation":"想要"}]', '[{"sentence":"I want a new toy.","translation":"我想要一个新玩具。"}]', NULL, 'raz-j', 3, NOW()),
(UUID(), 'like', '/laɪk/', NULL, '[{"partOfSpeech":"v.","definition":"to enjoy","translation":"喜欢"}]', '[{"sentence":"I like pizza.","translation":"我喜欢披萨。"}]', NULL, 'raz-j', 3, NOW()),
(UUID(), 'hate', '/heɪt/', NULL, '[{"partOfSpeech":"v.","definition":"to dislike strongly","translation":"讨厌"}]', '[{"sentence":"I hate rain.","translation":"我讨厌下雨。"}]', NULL, 'raz-j', 3, NOW()),
(UUID(), 'hope', '/həʊp/', NULL, '[{"partOfSpeech":"v.","definition":"to wish for","translation":"希望"}]', '[{"sentence":"I hope you are well.","translation":"希望你一切都好。"}]', NULL, 'raz-j', 3, NOW()),
(UUID(), 'wish', '/wɪʃ/', NULL, '[{"partOfSpeech":"v.","definition":"to want strongly","translation":"希望，祝愿"}]', '[{"sentence":"I wish you success.","translation":"祝你成功。"}]', NULL, 'raz-j', 3, NOW()),
(UUID(), 'should', '/ʃʊd/', NULL, '[{"partOfSpeech":"aux.","definition":"ought to","translation":"应该"}]', '[{"sentence":"You should study hard.","translation":"你应该努力学习。"}]', NULL, 'raz-k', 4, NOW()),
(UUID(), 'could', '/kʊd/', NULL, '[{"partOfSpeech":"aux.","definition":"was able to","translation":"能，可以"}]', '[{"sentence":"I could help you.","translation":"我可以帮你。"}]', NULL, 'raz-k', 4, NOW()),
(UUID(), 'would', '/wʊd/', NULL, '[{"partOfSpeech":"aux.","definition":"will in past","translation":"会，将要"}]', '[{"sentence":"I would like tea.","translation":"我想要茶。"}]', NULL, 'raz-k', 4, NOW()),
(UUID(), 'might', '/maɪt/', NULL, '[{"partOfSpeech":"aux.","definition":"possibly","translation":"可能"}]', '[{"sentence":"It might rain.","translation":"可能会下雨。"}]', NULL, 'raz-k', 4, NOW()),
(UUID(), 'must', '/mʌst/', NULL, '[{"partOfSpeech":"aux.","definition":"have to","translation":"必须"}]', '[{"sentence":"You must go now.","translation":"你必须现在走。"}]', NULL, 'raz-k', 4, NOW()),

-- ============================================
-- RAZ M-P 级 - 高级词汇（约40词）
-- ============================================
(UUID(), 'different', '/ˈdɪfrənt/', NULL, '[{"partOfSpeech":"adj.","definition":"not the same","translation":"不同的"}]', '[{"sentence":"We have different ideas.","translation":"我们有不同的想法。"}]', NULL, 'raz-m', 4, NOW()),
(UUID(), 'similar', '/ˈsɪmɪlə/', NULL, '[{"partOfSpeech":"adj.","definition":"almost the same","translation":"相似的"}]', '[{"sentence":"These two pictures are similar.","translation":"这两幅画很相似。"}]', NULL, 'raz-m', 4, NOW()),
(UUID(), 'important', '/ɪmˈpɔːtənt/', NULL, '[{"partOfSpeech":"adj.","definition":"of great value","translation":"重要的"}]', '[{"sentence":"This is very important.","translation":"这很重要。"}]', NULL, 'raz-m', 4, NOW()),
(UUID(), 'special', '/ˈspeʃəl/', NULL, '[{"partOfSpeech":"adj.","definition":"not ordinary","translation":"特别的"}]', '[{"sentence":"Today is a special day.","translation":"今天是个特别的日子。"}]', NULL, 'raz-m', 4, NOW()),
(UUID(), 'wonderful', '/ˈwʌndəfl/', NULL, '[{"partOfSpeech":"adj.","definition":"very good","translation":"精彩的"}]', '[{"sentence":"What a wonderful idea!","translation":"多么精彩的主意！"}]', NULL, 'raz-m', 4, NOW()),
(UUID(), 'beautiful', '/ˈbjuːtɪfl/', NULL, '[{"partOfSpeech":"adj.","definition":"pleasing to look at","translation":"美丽的"}]', '[{"sentence":"The flower is beautiful.","translation":"这朵花很美。"}]', NULL, 'raz-m', 4, NOW()),
(UUID(), 'interesting', '/ˈɪntrəstɪŋ/', NULL, '[{"partOfSpeech":"adj.","definition":"engaging attention","translation":"有趣的"}]', '[{"sentence":"This book is interesting.","translation":"这本书很有趣。"}]', NULL, 'raz-n', 4, NOW()),
(UUID(), 'exciting', '/ɪkˈsaɪtɪŋ/', NULL, '[{"partOfSpeech":"adj.","definition":"causing excitement","translation":"令人兴奋的"}]', '[{"sentence":"The game was exciting.","translation":"比赛很刺激。"}]', NULL, 'raz-n', 4, NOW()),
(UUID(), 'surprising', '/səˈpraɪzɪŋ/', NULL, '[{"partOfSpeech":"adj.","definition":"unexpected","translation":"令人惊讶的"}]', '[{"sentence":"The ending was surprising.","translation":"结局出人意料。"}]', NULL, 'raz-n', 4, NOW()),
(UUID(), 'amazing', '/əˈmeɪzɪŋ/', NULL, '[{"partOfSpeech":"adj.","definition":"very surprising","translation":"惊人的"}]', '[{"sentence":"You are amazing!","translation":"你太棒了！"}]', NULL, 'raz-n', 4, NOW()),
(UUID(), 'difficult', '/ˈdɪfɪkəlt/', NULL, '[{"partOfSpeech":"adj.","definition":"not easy","translation":"困难的"}]', '[{"sentence":"This question is difficult.","translation":"这个问题很难。"}]', NULL, 'raz-n', 4, NOW()),
(UUID(), 'easy', '/ˈiːzi/', NULL, '[{"partOfSpeech":"adj.","definition":"not hard","translation":"容易的"}]', '[{"sentence":"This test is easy.","translation":"这个测试很简单。"}]', NULL, 'raz-n', 4, NOW()),
(UUID(), 'possible', '/ˈpɒsəbl/', NULL, '[{"partOfSpeech":"adj.","definition":"can happen","translation":"可能的"}]', '[{"sentence":"Anything is possible.","translation":"一切皆有可能。"}]', NULL, 'raz-o', 4, NOW()),
(UUID(), 'impossible', '/ɪmˈpɒsəbl/', NULL, '[{"partOfSpeech":"adj.","definition":"cannot happen","translation":"不可能的"}]', '[{"sentence":"Nothing is impossible.","translation":"没有不可能的事。"}]', NULL, 'raz-o', 4, NOW()),
(UUID(), 'necessary', '/ˈnesəsəri/', NULL, '[{"partOfSpeech":"adj.","definition":"needed","translation":"必要的"}]', '[{"sentence":"Sleep is necessary.","translation":"睡眠是必要的。"}]', NULL, 'raz-o', 4, NOW()),
(UUID(), 'popular', '/ˈpɒpjələ/', NULL, '[{"partOfSpeech":"adj.","definition":"liked by many","translation":"流行的"}]', '[{"sentence":"This song is popular.","translation":"这首歌很流行。"}]', NULL, 'raz-o', 4, NOW()),
(UUID(), 'famous', '/ˈfeɪməs/', NULL, '[{"partOfSpeech":"adj.","definition":"well known","translation":"著名的"}]', '[{"sentence":"He is a famous actor.","translation":"他是著名演员。"}]', NULL, 'raz-o', 4, NOW()),
(UUID(), 'dangerous', '/ˈdeɪndʒərəs/', NULL, '[{"partOfSpeech":"adj.","definition":"not safe","translation":"危险的"}]', '[{"sentence":"Swimming alone is dangerous.","translation":"独自游泳是危险的。"}]', NULL, 'raz-p', 4, NOW()),
(UUID(), 'safe', '/seɪf/', NULL, '[{"partOfSpeech":"adj.","definition":"not dangerous","translation":"安全的"}]', '[{"sentence":"This place is safe.","translation":"这个地方很安全。"}]', NULL, 'raz-p', 4, NOW()),
(UUID(), 'healthy', '/ˈhelθi/', NULL, '[{"partOfSpeech":"adj.","definition":"in good health","translation":"健康的"}]', '[{"sentence":"Eating vegetables is healthy.","translation":"吃蔬菜很健康。"}]', NULL, 'raz-p', 4, NOW()),

-- ============================================
-- RAZ Q-Z 级 - 高级进阶词汇（约40词）
-- ============================================
(UUID(), 'decide', '/dɪˈsaɪd/', NULL, '[{"partOfSpeech":"v.","definition":"to make a choice","translation":"决定"}]', '[{"sentence":"I decide to study harder.","translation":"我决定更加努力学习。"}]', NULL, 'raz-q', 5, NOW()),
(UUID(), 'discover', '/dɪˈskʌvə/', NULL, '[{"partOfSpeech":"v.","definition":"to find something new","translation":"发现"}]', '[{"sentence":"Scientists discover new things.","translation":"科学家发现新事物。"}]', NULL, 'raz-q', 5, NOW()),
(UUID(), 'imagine', '/ɪˈmædʒɪn/', NULL, '[{"partOfSpeech":"v.","definition":"to form a picture in mind","translation":"想象"}]', '[{"sentence":"Imagine you are flying.","translation":"想象你在飞翔。"}]', NULL, 'raz-q', 5, NOW()),
(UUID(), 'believe', '/bɪˈliːv/', NULL, '[{"partOfSpeech":"v.","definition":"to think something is true","translation":"相信"}]', '[{"sentence":"I believe in you.","translation":"我相信你。"}]', NULL, 'raz-q', 5, NOW()),
(UUID(), 'remember', '/rɪˈmembə/', NULL, '[{"partOfSpeech":"v.","definition":"to keep in mind","translation":"记住"}]', '[{"sentence":"I remember your name.","translation":"我记得你的名字。"}]', NULL, 'raz-q', 5, NOW()),
(UUID(), 'forget', '/fəˈɡet/', NULL, '[{"partOfSpeech":"v.","definition":"to not remember","translation":"忘记"}]', '[{"sentence":"Dont forget your keys.","translation":"别忘了你的钥匙。"}]', NULL, 'raz-q', 5, NOW()),
(UUID(), 'understand', '/ˌʌndəˈstænd/', NULL, '[{"partOfSpeech":"v.","definition":"to know the meaning","translation":"理解"}]', '[{"sentence":"I understand now.","translation":"我现在明白了。"}]', NULL, 'raz-r', 5, NOW()),
(UUID(), 'explain', '/ɪkˈspleɪn/', NULL, '[{"partOfSpeech":"v.","definition":"to make clear","translation":"解释"}]', '[{"sentence":"Please explain again.","translation":"请再解释一遍。"}]', NULL, 'raz-r', 5, NOW()),
(UUID(), 'describe', '/dɪˈskraɪb/', NULL, '[{"partOfSpeech":"v.","definition":"to tell about","translation":"描述"}]', '[{"sentence":"Describe your dream house.","translation":"描述你梦想的房子。"}]', NULL, 'raz-r', 5, NOW()),
(UUID(), 'compare', '/kəmˈpeə/', NULL, '[{"partOfSpeech":"v.","definition":"to examine differences","translation":"比较"}]', '[{"sentence":"Compare these two books.","translation":"比较这两本书。"}]', NULL, 'raz-r', 5, NOW()),
(UUID(), 'consider', '/kənˈsɪdə/', NULL, '[{"partOfSpeech":"v.","definition":"to think about","translation":"考虑"}]', '[{"sentence":"I will consider your offer.","translation":"我会考虑你的提议。"}]', NULL, 'raz-s', 5, NOW()),
(UUID(), 'realize', '/ˈriːəlaɪz/', NULL, '[{"partOfSpeech":"v.","definition":"to become aware","translation":"意识到"}]', '[{"sentence":"I realize my mistake.","translation":"我意识到了我的错误。"}]', NULL, 'raz-s', 5, NOW()),
(UUID(), 'suppose', '/səˈpəʊz/', NULL, '[{"partOfSpeech":"v.","definition":"to assume","translation":"假设，认为"}]', '[{"sentence":"I suppose you are right.","translation":"我认为你是对的。"}]', NULL, 'raz-s', 5, NOW()),
(UUID(), 'expect', '/ɪkˈspekt/', NULL, '[{"partOfSpeech":"v.","definition":"to anticipate","translation":"期待"}]', '[{"sentence":"I expect to win.","translation":"我期待获胜。"}]', NULL, 'raz-s', 5, NOW()),
(UUID(), 'succeed', '/səkˈsiːd/', NULL, '[{"partOfSpeech":"v.","definition":"to achieve a goal","translation":"成功"}]', '[{"sentence":"You will succeed if you try.","translation":"如果你尝试，你就会成功。"}]', NULL, 'raz-t', 5, NOW()),
(UUID(), 'improve', '/ɪmˈpruːv/', NULL, '[{"partOfSpeech":"v.","definition":"to make better","translation":"改进"}]', '[{"sentence":"I want to improve my English.","translation":"我想提高我的英语。"}]', NULL, 'raz-t', 5, NOW()),
(UUID(), 'develop', '/dɪˈveləp/', NULL, '[{"partOfSpeech":"v.","definition":"to grow or create","translation":"发展"}]', '[{"sentence":"We develop new skills.","translation":"我们发展新技能。"}]', NULL, 'raz-t', 5, NOW()),
(UUID(), 'achieve', '/əˈtʃiːv/', NULL, '[{"partOfSpeech":"v.","definition":"to accomplish","translation":"实现"}]', '[{"sentence":"You can achieve your dreams.","translation":"你可以实现你的梦想。"}]', NULL, 'raz-t', 5, NOW()),
(UUID(), 'environment', '/ɪnˈvaɪrənmənt/', NULL, '[{"partOfSpeech":"n.","definition":"natural world","translation":"环境"}]', '[{"sentence":"We must protect the environment.","translation":"我们必须保护环境。"}]', NULL, 'raz-u', 5, NOW()),
(UUID(), 'experience', '/ɪkˈspɪəriəns/', NULL, '[{"partOfSpeech":"n.","definition":"knowledge from doing","translation":"经验"}]', '[{"sentence":"I have experience in teaching.","translation":"我有教学经验。"}]', NULL, 'raz-u', 5, NOW());

-- 显示导入统计
SELECT COUNT(*) as total_words FROM words WHERE category LIKE 'raz-%';
SELECT category, COUNT(*) as count FROM words WHERE category LIKE 'raz-%' GROUP BY category ORDER BY category;