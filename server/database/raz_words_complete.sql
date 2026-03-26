-- RAZ完整单词库 - 每个级别50+单词
-- Complete RAZ Vocabulary Library

SET NAMES utf8mb4;

USE word_study;

-- ============================================
-- RAZ aa 级 - 入门词汇 (补充到50+)
-- ============================================
INSERT INTO words (id, word, phonetic, meanings, examples, category, difficulty, createdAt) VALUES
-- 数字
(UUID(), 'zero', '/ˈzɪərəʊ/', '[{"partOfSpeech":"num.","translation":"零"}]', '[{"sentence":"I have zero apples.","translation":"我没有苹果。"}]', 'raz-aa', 1, NOW()),
-- 更多动物
(UUID(), 'ant', '/ænt/', '[{"partOfSpeech":"n.","translation":"蚂蚁"}]', '[{"sentence":"The ant is small.","translation":"蚂蚁很小。"}]', 'raz-aa', 1, NOW()),
(UUID(), 'bat', '/bæt/', '[{"partOfSpeech":"n.","translation":"蝙蝠"}]', '[{"sentence":"Bats sleep in the day.","translation":"蝙蝠白天睡觉。"}]', 'raz-aa', 1, NOW()),
(UUID(), 'bee', '/biː/', '[{"partOfSpeech":"n.","translation":"蜜蜂"}]', '[{"sentence":"Bees make honey.","translation":"蜜蜂酿蜜。"}]', 'raz-aa', 1, NOW()),
(UUID(), 'hen', '/hen/', '[{"partOfSpeech":"n.","translation":"母鸡"}]', '[{"sentence":"The hen lays eggs.","translation":"母鸡下蛋。"}]', 'raz-aa', 1, NOW()),
(UUID(), 'fox', '/fɒks/', '[{"partOfSpeech":"n.","translation":"狐狸"}]', '[{"sentence":"The fox is clever.","translation":"狐狸很聪明。"}]', 'raz-aa', 1, NOW()),
(UUID(), 'ox', '/ɒks/', '[{"partOfSpeech":"n.","translation":"公牛"}]', '[{"sentence":"The ox is strong.","translation":"公牛很强壮。"}]', 'raz-aa', 1, NOW()),
(UUID(), 'rat', '/ræt/', '[{"partOfSpeech":"n.","translation":"老鼠"}]', '[{"sentence":"The rat runs fast.","translation":"老鼠跑得快。"}]', 'raz-aa', 1, NOW()),
(UUID(), 'yak', '/jæk/', '[{"partOfSpeech":"n.","translation":"牦牛"}]', '[{"sentence":"Yaks live in mountains.","translation":"牦牛住在山里。"}]', 'raz-aa', 1, NOW()),
(UUID(), 'zebra', '/ˈzebrə/', '[{"partOfSpeech":"n.","translation":"斑马"}]', '[{"sentence":"Zebras have stripes.","translation":"斑马有条纹。"}]', 'raz-aa', 1, NOW()),
-- 身体部位
(UUID(), 'arm', '/ɑːm/', '[{"partOfSpeech":"n.","translation":"手臂"}]', '[{"sentence":"I have two arms.","translation":"我有两只手臂。"}]', 'raz-aa', 1, NOW()),
(UUID(), 'ear', '/ɪə/', '[{"partOfSpeech":"n.","translation":"耳朵"}]', '[{"sentence":"I hear with my ears.","translation":"我用耳朵听。"}]', 'raz-aa', 1, NOW()),
(UUID(), 'eye', '/aɪ/', '[{"partOfSpeech":"n.","translation":"眼睛"}]', '[{"sentence":"I see with my eyes.","translation":"我用眼睛看。"}]', 'raz-aa', 1, NOW()),
(UUID(), 'face', '/feɪs/', '[{"partOfSpeech":"n.","translation":"脸"}]', '[{"sentence":"This is my face.","translation":"这是我的脸。"}]', 'raz-aa', 1, NOW()),
(UUID(), 'foot', '/fʊt/', '[{"partOfSpeech":"n.","translation":"脚"}]', '[{"sentence":"I walk with my feet.","translation":"我用脚走路。"}]', 'raz-aa', 1, NOW()),
(UUID(), 'hand', '/hænd/', '[{"partOfSpeech":"n.","translation":"手"}]', '[{"sentence":"I write with my hand.","translation":"我用手写字。"}]', 'raz-aa', 1, NOW()),
(UUID(), 'head', '/hed/', '[{"partOfSpeech":"n.","translation":"头"}]', '[{"sentence":"I have one head.","translation":"我有一个头。"}]', 'raz-aa', 1, NOW()),
(UUID(), 'leg', '/leɡ/', '[{"partOfSpeech":"n.","translation":"腿"}]', '[{"sentence":"I have two legs.","translation":"我有两条腿。"}]', 'raz-aa', 1, NOW()),
(UUID(), 'mouth', '/maʊθ/', '[{"partOfSpeech":"n.","translation":"嘴巴"}]', '[{"sentence":"I eat with my mouth.","translation":"我用嘴巴吃东西。"}]', 'raz-aa', 1, NOW()),
(UUID(), 'nose', '/nəʊz/', '[{"partOfSpeech":"n.","translation":"鼻子"}]', '[{"sentence":"I smell with my nose.","translation":"我用鼻子闻。"}]', 'raz-aa', 1, NOW()),
-- 更多颜色
(UUID(), 'black', '/blæk/', '[{"partOfSpeech":"adj.","translation":"黑色的"}]', '[{"sentence":"The cat is black.","translation":"猫是黑色的。"}]', 'raz-aa', 1, NOW()),
(UUID(), 'white', '/waɪt/', '[{"partOfSpeech":"adj.","translation":"白色的"}]', '[{"sentence":"Snow is white.","translation":"雪是白色的。"}]', 'raz-aa', 1, NOW()),
(UUID(), 'orange', '/ˈɒrɪndʒ/', '[{"partOfSpeech":"adj.","translation":"橙色的"}]', '[{"sentence":"The orange is orange.","translation":"橙子是橙色的。"}]', 'raz-aa', 1, NOW()),
(UUID(), 'pink', '/pɪŋk/', '[{"partOfSpeech":"adj.","translation":"粉色的"}]', '[{"sentence":"The flower is pink.","translation":"花是粉色的。"}]', 'raz-aa', 1, NOW()),
(UUID(), 'purple', '/ˈpɜːpl/', '[{"partOfSpeech":"adj.","translation":"紫色的"}]', '[{"sentence":"Grapes are purple.","translation":"葡萄是紫色的。"}]', 'raz-aa', 1, NOW()),
(UUID(), 'brown', '/braʊn/', '[{"partOfSpeech":"adj.","translation":"棕色的"}]', '[{"sentence":"The bear is brown.","translation":"熊是棕色的。"}]', 'raz-aa', 1, NOW()),

-- ============================================
-- RAZ A 级 - 基础动词 (补充到50+)
-- ============================================
(UUID(), 'add', '/æd/', '[{"partOfSpeech":"v.","translation":"加"}]', '[{"sentence":"Add two and two.","translation":"二加二。"}]', 'raz-a', 1, NOW()),
(UUID(), 'ask', '/ɑːsk/', '[{"partOfSpeech":"v.","translation":"问"}]', '[{"sentence":"Ask a question.","translation":"问一个问题。"}]', 'raz-a', 1, NOW()),
(UUID(), 'buy', '/baɪ/', '[{"partOfSpeech":"v.","translation":"买"}]', '[{"sentence":"I buy a book.","translation":"我买一本书。"}]', 'raz-a', 1, NOW()),
(UUID(), 'call', '/kɔːl/', '[{"partOfSpeech":"v.","translation":"叫，打电话"}]', '[{"sentence":"Call me later.","translation":"回头给我打电话。"}]', 'raz-a', 1, NOW()),
(UUID(), 'clean', '/kliːn/', '[{"partOfSpeech":"v.","translation":"打扫"}]', '[{"sentence":"Clean your room.","translation":"打扫你的房间。"}]', 'raz-a', 1, NOW()),
(UUID(), 'cut', '/kʌt/', '[{"partOfSpeech":"v.","translation":"切"}]', '[{"sentence":"Cut the paper.","translation":"剪纸。"}]', 'raz-a', 1, NOW()),
(UUID(), 'do', '/duː/', '[{"partOfSpeech":"v.","translation":"做"}]', '[{"sentence":"Do your homework.","translation":"做作业。"}]', 'raz-a', 1, NOW()),
(UUID(), 'draw', '/drɔː/', '[{"partOfSpeech":"v.","translation":"画"}]', '[{"sentence":"Draw a picture.","translation":"画一幅画。"}]', 'raz-a', 1, NOW()),
(UUID(), 'drink', '/drɪŋk/', '[{"partOfSpeech":"v.","translation":"喝"}]', '[{"sentence":"Drink water.","translation":"喝水。"}]', 'raz-a', 1, NOW()),
(UUID(), 'drive', '/draɪv/', '[{"partOfSpeech":"v.","translation":"开车"}]', '[{"sentence":"I drive a car.","translation":"我开车。"}]', 'raz-a', 1, NOW()),
(UUID(), 'fall', '/fɔːl/', '[{"partOfSpeech":"v.","translation":"落下"}]', '[{"sentence":"Leaves fall in autumn.","translation":"秋天树叶落下。"}]', 'raz-a', 1, NOW()),
(UUID(), 'find', '/faɪnd/', '[{"partOfSpeech":"v.","translation":"找到"}]', '[{"sentence":"Find your book.","translation":"找到你的书。"}]', 'raz-a', 1, NOW()),
(UUID(), 'get', '/ɡet/', '[{"partOfSpeech":"v.","translation":"得到"}]', '[{"sentence":"Get the book.","translation":"拿那本书。"}]', 'raz-a', 1, NOW()),
(UUID(), 'give', '/ɡɪv/', '[{"partOfSpeech":"v.","translation":"给"}]', '[{"sentence":"Give me a pen.","translation":"给我一支笔。"}]', 'raz-a', 1, NOW()),
(UUID(), 'help', '/help/', '[{"partOfSpeech":"v.","translation":"帮助"}]', '[{"sentence":"Help me please.","translation":"请帮帮我。"}]', 'raz-a', 1, NOW()),
(UUID(), 'keep', '/kiːp/', '[{"partOfSpeech":"v.","translation":"保持"}]', '[{"sentence":"Keep quiet.","translation":"保持安静。"}]', 'raz-a', 1, NOW()),
(UUID(), 'know', '/nəʊ/', '[{"partOfSpeech":"v.","translation":"知道"}]', '[{"sentence":"I know you.","translation":"我认识你。"}]', 'raz-a', 1, NOW()),
(UUID(), 'let', '/let/', '[{"partOfSpeech":"v.","translation":"让"}]', '[{"sentence":"Let me help.","translation":"让我帮忙。"}]', 'raz-a', 1, NOW()),
(UUID(), 'live', '/lɪv/', '[{"partOfSpeech":"v.","translation":"居住"}]', '[{"sentence":"I live here.","translation":"我住在这里。"}]', 'raz-a', 1, NOW()),
(UUID(), 'look', '/lʊk/', '[{"partOfSpeech":"v.","translation":"看"}]', '[{"sentence":"Look at me.","translation":"看着我。"}]', 'raz-a', 1, NOW()),
(UUID(), 'make', '/meɪk/', '[{"partOfSpeech":"v.","translation":"制作"}]', '[{"sentence":"Make a cake.","translation":"做一个蛋糕。"}]', 'raz-a', 1, NOW()),
(UUID(), 'meet', '/miːt/', '[{"partOfSpeech":"v.","translation":"遇见"}]', '[{"sentence":"Nice to meet you.","translation":"很高兴见到你。"}]', 'raz-a', 1, NOW()),
(UUID(), 'play', '/pleɪ/', '[{"partOfSpeech":"v.","translation":"玩"}]', '[{"sentence":"Let us play!","translation":"让我们玩吧！"}]', 'raz-a', 1, NOW()),
(UUID(), 'put', '/pʊt/', '[{"partOfSpeech":"v.","translation":"放"}]', '[{"sentence":"Put it here.","translation":"把它放这儿。"}]', 'raz-a', 1, NOW()),
(UUID(), 'read', '/riːd/', '[{"partOfSpeech":"v.","translation":"阅读"}]', '[{"sentence":"Read this book.","translation":"读这本书。"}]', 'raz-a', 1, NOW()),
(UUID(), 'ride', '/raɪd/', '[{"partOfSpeech":"v.","translation":"骑"}]', '[{"sentence":"Ride a bike.","translation":"骑自行车。"}]', 'raz-a', 1, NOW()),
(UUID(), 'run', '/rʌn/', '[{"partOfSpeech":"v.","translation":"跑"}]', '[{"sentence":"Run fast!","translation":"快跑！"}]', 'raz-a', 1, NOW()),
(UUID(), 'say', '/seɪ/', '[{"partOfSpeech":"v.","translation":"说"}]', '[{"sentence":"Say hello.","translation":"说你好。"}]', 'raz-a', 1, NOW()),
(UUID(), 'see', '/siː/', '[{"partOfSpeech":"v.","translation":"看见"}]', '[{"sentence":"I see you.","translation":"我看见你了。"}]', 'raz-a', 1, NOW()),
(UUID(), 'sell', '/sel/', '[{"partOfSpeech":"v.","translation":"卖"}]', '[{"sentence":"Sell the car.","translation":"卖车。"}]', 'raz-a', 1, NOW()),
(UUID(), 'show', '/ʃəʊ/', '[{"partOfSpeech":"v.","translation":"展示"}]', '[{"sentence":"Show me.","translation":"给我看看。"}]', 'raz-a', 1, NOW()),
(UUID(), 'sing', '/sɪŋ/', '[{"partOfSpeech":"v.","translation":"唱歌"}]', '[{"sentence":"Sing a song.","translation":"唱首歌。"}]', 'raz-a', 1, NOW()),
(UUID(), 'sit', '/sɪt/', '[{"partOfSpeech":"v.","translation":"坐"}]', '[{"sentence":"Sit down.","translation":"坐下。"}]', 'raz-a', 1, NOW()),
(UUID(), 'sleep', '/sliːp/', '[{"partOfSpeech":"v.","translation":"睡觉"}]', '[{"sentence":"I sleep at night.","translation":"我晚上睡觉。"}]', 'raz-a', 1, NOW()),
(UUID(), 'stop', '/stɒp/', '[{"partOfSpeech":"v.","translation":"停止"}]', '[{"sentence":"Stop!","translation":"停！"}]', 'raz-a', 1, NOW()),

-- ============================================
-- RAZ B 级 - 形容词 (补充到50+)
-- ============================================
(UUID(), 'angry', '/ˈæŋɡri/', '[{"partOfSpeech":"adj.","translation":"生气的"}]', '[{"sentence":"He looks angry.","translation":"他看起来很生气。"}]', 'raz-b', 1, NOW()),
(UUID(), 'busy', '/ˈbɪzi/', '[{"partOfSpeech":"adj.","translation":"忙碌的"}]', '[{"sentence":"I am busy now.","translation":"我现在很忙。"}]', 'raz-b', 1, NOW()),
(UUID(), 'clean', '/kliːn/', '[{"partOfSpeech":"adj.","translation":"干净的"}]', '[{"sentence":"The room is clean.","translation":"房间很干净。"}]', 'raz-b', 1, NOW()),
(UUID(), 'dirty', '/ˈdɜːti/', '[{"partOfSpeech":"adj.","translation":"脏的"}]', '[{"sentence":"Your hands are dirty.","translation":"你的手很脏。"}]', 'raz-b', 1, NOW()),
(UUID(), 'dry', '/draɪ/', '[{"partOfSpeech":"adj.","translation":"干的"}]', '[{"sentence":"The ground is dry.","translation":"地面是干的。"}]', 'raz-b', 1, NOW()),
(UUID(), 'wet', '/wet/', '[{"partOfSpeech":"adj.","translation":"湿的"}]', '[{"sentence":"My clothes are wet.","translation":"我的衣服湿了。"}]', 'raz-b', 1, NOW()),
(UUID(), 'empty', '/ˈempti/', '[{"partOfSpeech":"adj.","translation":"空的"}]', '[{"sentence":"The box is empty.","translation":"盒子是空的。"}]', 'raz-b', 1, NOW()),
(UUID(), 'full', '/fʊl/', '[{"partOfSpeech":"adj.","translation":"满的"}]', '[{"sentence":"The cup is full.","translation":"杯子是满的。"}]', 'raz-b', 1, NOW()),
(UUID(), 'fast', '/fɑːst/', '[{"partOfSpeech":"adj.","translation":"快的"}]', '[{"sentence":"The car is fast.","translation":"这辆车很快。"}]', 'raz-b', 1, NOW()),
(UUID(), 'slow', '/sləʊ/', '[{"partOfSpeech":"adj.","translation":"慢的"}]', '[{"sentence":"The turtle is slow.","translation":"乌龟很慢。"}]', 'raz-b', 1, NOW()),
(UUID(), 'fat', '/fæt/', '[{"partOfSpeech":"adj.","translation":"胖的"}]', '[{"sentence":"The cat is fat.","translation":"这只猫很胖。"}]', 'raz-b', 1, NOW()),
(UUID(), 'thin', '/θɪn/', '[{"partOfSpeech":"adj.","translation":"瘦的"}]', '[{"sentence":"He is thin.","translation":"他很瘦。"}]', 'raz-b', 1, NOW()),
(UUID(), 'hard', '/hɑːd/', '[{"partOfSpeech":"adj.","translation":"硬的，困难的"}]', '[{"sentence":"This is hard work.","translation":"这是困难的工作。"}]', 'raz-b', 1, NOW()),
(UUID(), 'soft', '/sɒft/', '[{"partOfSpeech":"adj.","translation":"软的"}]', '[{"sentence":"The pillow is soft.","translation":"枕头很软。"}]', 'raz-b', 1, NOW()),
(UUID(), 'heavy', '/ˈhevi/', '[{"partOfSpeech":"adj.","translation":"重的"}]', '[{"sentence":"The box is heavy.","translation":"盒子很重。"}]', 'raz-b', 1, NOW()),
(UUID(), 'light', '/laɪt/', '[{"partOfSpeech":"adj.","translation":"轻的，明亮的"}]', '[{"sentence":"The feather is light.","translation":"羽毛很轻。"}]', 'raz-b', 1, NOW()),
(UUID(), 'hungry', '/ˈhʌŋɡri/', '[{"partOfSpeech":"adj.","translation":"饿的"}]', '[{"sentence":"I am hungry.","translation":"我饿了。"}]', 'raz-b', 1, NOW()),
(UUID(), 'thirsty', '/ˈθɜːsti/', '[{"partOfSpeech":"adj.","translation":"渴的"}]', '[{"sentence":"I am thirsty.","translation":"我渴了。"}]', 'raz-b', 1, NOW()),
(UUID(), 'loud', '/laʊd/', '[{"partOfSpeech":"adj.","translation":"大声的"}]', '[{"sentence":"The music is loud.","translation":"音乐很大声。"}]', 'raz-b', 1, NOW()),
(UUID(), 'quiet', '/ˈkwaɪət/', '[{"partOfSpeech":"adj.","translation":"安静的"}]', '[{"sentence":"Be quiet please.","translation":"请安静。"}]', 'raz-b', 1, NOW()),
(UUID(), 'nice', '/naɪs/', '[{"partOfSpeech":"adj.","translation":"好的"}]', '[{"sentence":"You are nice.","translation":"你很好。"}]', 'raz-b', 1, NOW()),
(UUID(), 'mean', '/miːn/', '[{"partOfSpeech":"adj.","translation":"刻薄的"}]', '[{"sentence":"Dont be mean.","translation":"不要刻薄。"}]', 'raz-b', 1, NOW()),
(UUID(), 'old', '/əʊld/', '[{"partOfSpeech":"adj.","translation":"老的"}]', '[{"sentence":"The dog is old.","translation":"这只狗老了。"}]', 'raz-b', 1, NOW()),
(UUID(), 'young', '/jʌŋ/', '[{"partOfSpeech":"adj.","translation":"年轻的"}]', '[{"sentence":"She is young.","translation":"她很年轻。"}]', 'raz-b', 1, NOW()),
(UUID(), 'right', '/raɪt/', '[{"partOfSpeech":"adj.","translation":"对的，右边的"}]', '[{"sentence":"You are right.","translation":"你是对的。"}]', 'raz-b', 1, NOW()),
(UUID(), 'wrong', '/rɒŋ/', '[{"partOfSpeech":"adj.","translation":"错的"}]', '[{"sentence":"That is wrong.","translation":"那是错的。"}]', 'raz-b', 1, NOW()),
(UUID(), 'same', '/seɪm/', '[{"partOfSpeech":"adj.","translation":"相同的"}]', '[{"sentence":"We have the same book.","translation":"我们有同样的书。"}]', 'raz-b', 1, NOW()),
(UUID(), 'different', '/ˈdɪfrənt/', '[{"partOfSpeech":"adj.","translation":"不同的"}]', '[{"sentence":"They are different.","translation":"它们是不同的。"}]', 'raz-b', 1, NOW()),
(UUID(), 'scared', '/skeəd/', '[{"partOfSpeech":"adj.","translation":"害怕的"}]', '[{"sentence":"I am scared.","translation":"我害怕。"}]', 'raz-b', 1, NOW()),
(UUID(), 'tired', '/ˈtaɪəd/', '[{"partOfSpeech":"adj.","translation":"累的"}]', '[{"sentence":"I am tired.","translation":"我累了。"}]', 'raz-b', 1, NOW()),
(UUID(), 'sick', '/sɪk/', '[{"partOfSpeech":"adj.","translation":"生病的"}]', '[{"sentence":"He is sick.","translation":"他病了。"}]', 'raz-b', 1, NOW()),
(UUID(), 'well', '/wel/', '[{"partOfSpeech":"adj.","translation":"健康的"}]', '[{"sentence":"I am well.","translation":"我很健康。"}]', 'raz-b', 1, NOW()),

-- ============================================
-- RAZ C 级 - 日常词汇 (补充到50+)
-- ============================================
(UUID(), 'bathroom', '/ˈbɑːθruːm/', '[{"partOfSpeech":"n.","translation":"浴室"}]', '[{"sentence":"I wash in the bathroom.","translation":"我在浴室洗漱。"}]', 'raz-c', 2, NOW()),
(UUID(), 'bedroom', '/ˈbedruːm/', '[{"partOfSpeech":"n.","translation":"卧室"}]', '[{"sentence":"I sleep in the bedroom.","translation":"我在卧室睡觉。"}]', 'raz-c', 2, NOW()),
(UUID(), 'kitchen', '/ˈkɪtʃɪn/', '[{"partOfSpeech":"n.","translation":"厨房"}]', '[{"sentence":"Mom cooks in the kitchen.","translation":"妈妈在厨房做饭。"}]', 'raz-c', 2, NOW()),
(UUID(), 'living room', '/ˈlɪvɪŋ ruːm/', '[{"partOfSpeech":"n.","translation":"客厅"}]', '[{"sentence":"We watch TV in the living room.","translation":"我们在客厅看电视。"}]', 'raz-c', 2, NOW()),
(UUID(), 'yard', '/jɑːd/', '[{"partOfSpeech":"n.","translation":"院子"}]', '[{"sentence":"We play in the yard.","translation":"我们在院子里玩。"}]', 'raz-c', 2, NOW()),
(UUID(), 'street', '/striːt/', '[{"partOfSpeech":"n.","translation":"街道"}]', '[{"sentence":"We walk on the street.","translation":"我们在街上走。"}]', 'raz-c', 2, NOW()),
(UUID(), 'store', '/stɔː/', '[{"partOfSpeech":"n.","translation":"商店"}]', '[{"sentence":"We shop at the store.","translation":"我们在商店购物。"}]', 'raz-c', 2, NOW()),
(UUID(), 'office', '/ˈɒfɪs/', '[{"partOfSpeech":"n.","translation":"办公室"}]', '[{"sentence":"Dad works in an office.","translation":"爸爸在办公室工作。"}]', 'raz-c', 2, NOW()),
(UUID(), 'station', '/ˈsteɪʃn/', '[{"partOfSpeech":"n.","translation":"车站"}]', '[{"sentence":"The train stops at the station.","translation":"火车停在车站。"}]', 'raz-c', 2, NOW()),
(UUID(), 'airport', '/ˈeəpɔːt/', '[{"partOfSpeech":"n.","translation":"机场"}]', '[{"sentence":"We go to the airport.","translation":"我们去机场。"}]', 'raz-c', 2, NOW()),
(UUID(), 'school', '/skuːl/', '[{"partOfSpeech":"n.","translation":"学校"}]', '[{"sentence":"I go to school.","translation":"我去上学。"}]', 'raz-c', 2, NOW()),
(UUID(), 'church', '/tʃɜːtʃ/', '[{"partOfSpeech":"n.","translation":"教堂"}]', '[{"sentence":"We go to church.","translation":"我们去教堂。"}]', 'raz-c', 2, NOW()),
(UUID(), 'market', '/ˈmɑːkɪt/', '[{"partOfSpeech":"n.","translation":"市场"}]', '[{"sentence":"We buy food at the market.","translation":"我们在市场买食物。"}]', 'raz-c', 2, NOW()),
(UUID(), 'bank', '/bæŋk/', '[{"partOfSpeech":"n.","translation":"银行"}]', '[{"sentence":"I go to the bank.","translation":"我去银行。"}]', 'raz-c', 2, NOW()),
(UUID(), 'post office', '/pəʊst ˈɒfɪs/', '[{"partOfSpeech":"n.","translation":"邮局"}]', '[{"sentence":"I mail a letter at the post office.","translation":"我在邮局寄信。"}]', 'raz-c', 2, NOW()),
(UUID(), 'police station', '/pəˈliːs ˈsteɪʃn/', '[{"partOfSpeech":"n.","translation":"警察局"}]', '[{"sentence":"We go to the police station.","translation":"我们去警察局。"}]', 'raz-c', 2, NOW()),
(UUID(), 'fire station', '/faɪə ˈsteɪʃn/', '[{"partOfSpeech":"n.","translation":"消防站"}]', '[{"sentence":"Fire trucks are at the fire station.","translation":"消防车在消防站。"}]', 'raz-c', 2, NOW()),
(UUID(), 'zoo', '/zuː/', '[{"partOfSpeech":"n.","translation":"动物园"}]', '[{"sentence":"We see animals at the zoo.","translation":"我们在动物园看动物。"}]', 'raz-c', 2, NOW()),
(UUID(), 'pool', '/puːl/', '[{"partOfSpeech":"n.","translation":"游泳池"}]', '[{"sentence":"We swim in the pool.","translation":"我们在游泳池游泳。"}]', 'raz-c', 2, NOW()),
(UUID(), 'movie theater', '/ˈmuːvi θɪətə/', '[{"partOfSpeech":"n.","translation":"电影院"}]', '[{"sentence":"We watch movies at the theater.","translation":"我们在电影院看电影。"}]', 'raz-c', 2, NOW()),

-- ============================================
-- RAZ D 级 - 自然词汇 (补充到50+)
-- ============================================
(UUID(), 'plant', '/plɑːnt/', '[{"partOfSpeech":"n.","translation":"植物"}]', '[{"sentence":"The plant needs water.","translation":"植物需要水。"}]', 'raz-d', 2, NOW()),
(UUID(), 'leaf', '/liːf/', '[{"partOfSpeech":"n.","translation":"叶子"}]', '[{"sentence":"The leaf is green.","translation":"叶子是绿色的。"}]', 'raz-d', 2, NOW()),
(UUID(), 'grass', '/ɡrɑːs/', '[{"partOfSpeech":"n.","translation":"草"}]', '[{"sentence":"The grass is soft.","translation":"草很软。"}]', 'raz-d', 2, NOW()),
(UUID(), 'river', '/ˈrɪvə/', '[{"partOfSpeech":"n.","translation":"河流"}]', '[{"sentence":"The river is long.","translation":"河流很长。"}]', 'raz-d', 2, NOW()),
(UUID(), 'lake', '/leɪk/', '[{"partOfSpeech":"n.","translation":"湖"}]', '[{"sentence":"We fish in the lake.","translation":"我们在湖里钓鱼。"}]', 'raz-d', 2, NOW()),
(UUID(), 'ocean', '/ˈəʊʃn/', '[{"partOfSpeech":"n.","translation":"海洋"}]', '[{"sentence":"The ocean is big.","translation":"海洋很大。"}]', 'raz-d', 2, NOW()),
(UUID(), 'beach', '/biːtʃ/', '[{"partOfSpeech":"n.","translation":"海滩"}]', '[{"sentence":"We play on the beach.","translation":"我们在海滩上玩。"}]', 'raz-d', 2, NOW()),
(UUID(), 'island', '/ˈaɪlənd/', '[{"partOfSpeech":"n.","translation":"岛屿"}]', '[{"sentence":"We live on an island.","translation":"我们住在岛上。"}]', 'raz-d', 2, NOW()),
(UUID(), 'desert', '/ˈdezət/', '[{"partOfSpeech":"n.","translation":"沙漠"}]', '[{"sentence":"The desert is hot and dry.","translation":"沙漠又热又干。"}]', 'raz-d', 2, NOW()),
(UUID(), 'forest', '/ˈfɒrɪst/', '[{"partOfSpeech":"n.","translation":"森林"}]', '[{"sentence":"Many trees are in the forest.","translation":"森林里有很多树。"}]', 'raz-d', 2, NOW()),
(UUID(), 'hill', '/hɪl/', '[{"partOfSpeech":"n.","translation":"小山"}]', '[{"sentence":"We climb the hill.","translation":"我们爬小山。"}]', 'raz-d', 2, NOW()),
(UUID(), 'valley', '/ˈvæli/', '[{"partOfSpeech":"n.","translation":"山谷"}]', '[{"sentence":"We walk through the valley.","translation":"我们穿过山谷。"}]', 'raz-d', 2, NOW()),
(UUID(), 'cave', '/keɪv/', '[{"partOfSpeech":"n.","translation":"洞穴"}]', '[{"sentence":"Bats live in caves.","translation":"蝙蝠住在洞穴里。"}]', 'raz-d', 2, NOW()),
(UUID(), 'rock', '/rɒk/', '[{"partOfSpeech":"n.","translation":"岩石"}]', '[{"sentence":"The rock is hard.","translation":"岩石很硬。"}]', 'raz-d', 2, NOW()),
(UUID(), 'stone', '/stəʊn/', '[{"partOfSpeech":"n.","translation":"石头"}]', '[{"sentence":"I pick up a stone.","translation":"我捡起一块石头。"}]', 'raz-d', 2, NOW()),
(UUID(), 'sand', '/sænd/', '[{"partOfSpeech":"n.","translation":"沙子"}]', '[{"sentence":"The sand is warm.","translation":"沙子是暖的。"}]', 'raz-d', 2, NOW()),
(UUID(), 'mud', '/mʌd/', '[{"partOfSpeech":"n.","translation":"泥"}]', '[{"sentence":"My shoes have mud.","translation":"我的鞋子有泥。"}]', 'raz-d', 2, NOW()),
(UUID(), 'dirt', '/dɜːt/', '[{"partOfSpeech":"n.","translation":"泥土"}]', '[{"sentence":"Wash the dirt off.","translation":"把泥土洗掉。"}]', 'raz-d', 2, NOW()),
(UUID(), 'sky', '/skaɪ/', '[{"partOfSpeech":"n.","translation":"天空"}]', '[{"sentence":"Look at the sky.","translation":"看天空。"}]', 'raz-d', 2, NOW()),
(UUID(), 'star', '/stɑː/', '[{"partOfSpeech":"n.","translation":"星星"}]', '[{"sentence":"Stars shine at night.","translation":"星星在夜晚闪烁。"}]', 'raz-d', 2, NOW()),

-- ============================================
-- RAZ E 级 - 食物词汇 (补充到50+)
-- ============================================
(UUID(), 'rice', '/raɪs/', '[{"partOfSpeech":"n.","translation":"米饭"}]', '[{"sentence":"I eat rice every day.","translation":"我每天吃米饭。"}]', 'raz-e', 2, NOW()),
(UUID(), 'noodle', '/ˈnuːdl/', '[{"partOfSpeech":"n.","translation":"面条"}]', '[{"sentence":"I like noodles.","translation":"我喜欢面条。"}]', 'raz-e', 2, NOW()),
(UUID(), 'pasta', '/ˈpæstə/', '[{"partOfSpeech":"n.","translation":"意大利面"}]', '[{"sentence":"Pasta is from Italy.","translation":"意大利面来自意大利。"}]', 'raz-e', 2, NOW()),
(UUID(), 'meat', '/miːt/', '[{"partOfSpeech":"n.","translation":"肉"}]', '[{"sentence":"I eat meat.","translation":"我吃肉。"}]', 'raz-e', 2, NOW()),
(UUID(), 'beef', '/biːf/', '[{"partOfSpeech":"n.","translation":"牛肉"}]', '[{"sentence":"Beef is red meat.","translation":"牛肉是红肉。"}]', 'raz-e', 2, NOW()),
(UUID(), 'pork', '/pɔːk/', '[{"partOfSpeech":"n.","translation":"猪肉"}]', '[{"sentence":"Pork comes from pigs.","translation":"猪肉来自猪。"}]', 'raz-e', 2, NOW()),
(UUID(), 'chicken', '/ˈtʃɪkɪn/', '[{"partOfSpeech":"n.","translation":"鸡肉"}]', '[{"sentence":"Chicken is my favorite.","translation":"鸡肉是我的最爱。"}]', 'raz-e', 2, NOW()),
(UUID(), 'fish', '/fɪʃ/', '[{"partOfSpeech":"n.","translation":"鱼"}]', '[{"sentence":"Fish live in water.","translation":"鱼住在水里。"}]', 'raz-e', 2, NOW()),
(UUID(), 'egg', '/eɡ/', '[{"partOfSpeech":"n.","translation":"鸡蛋"}]', '[{"sentence":"I eat eggs for breakfast.","translation":"我早餐吃鸡蛋。"}]', 'raz-e', 2, NOW()),
(UUID(), 'vegetable', '/ˈvedʒtəbl/', '[{"partOfSpeech":"n.","translation":"蔬菜"}]', '[{"sentence":"Eat your vegetables.","translation":"吃你的蔬菜。"}]', 'raz-e', 2, NOW()),
(UUID(), 'carrot', '/ˈkærət/', '[{"partOfSpeech":"n.","translation":"胡萝卜"}]', '[{"sentence":"Carrots are orange.","translation":"胡萝卜是橙色的。"}]', 'raz-e', 2, NOW()),
(UUID(), 'potato', '/pəˈteɪtəʊ/', '[{"partOfSpeech":"n.","translation":"土豆"}]', '[{"sentence":"Potatoes are good for you.","translation":"土豆对你有好处。"}]', 'raz-e', 2, NOW()),
(UUID(), 'tomato', '/təˈmɑːtəʊ/', '[{"partOfSpeech":"n.","translation":"西红柿"}]', '[{"sentence":"Tomatoes are red.","translation":"西红柿是红色的。"}]', 'raz-e', 2, NOW()),
(UUID(), 'onion', '/ˈʌnjən/', '[{"partOfSpeech":"n.","translation":"洋葱"}]', '[{"sentence":"Onions make me cry.","translation":"洋葱让我流泪。"}]', 'raz-e', 2, NOW()),
(UUID(), 'pepper', '/ˈpepə/', '[{"partOfSpeech":"n.","translation":"辣椒，胡椒"}]', '[{"sentence":"Peppers can be spicy.","translation":"辣椒可能是辣的。"}]', 'raz-e', 2, NOW()),
(UUID(), 'cabbage', '/ˈkæbɪdʒ/', '[{"partOfSpeech":"n.","translation":"卷心菜"}]', '[{"sentence":"Cabbage is green.","translation":"卷心菜是绿色的。"}]', 'raz-e', 2, NOW()),
(UUID(), 'corn', '/kɔːn/', '[{"partOfSpeech":"n.","translation":"玉米"}]', '[{"sentence":"Corn is yellow.","translation":"玉米是黄色的。"}]', 'raz-e', 2, NOW()),
(UUID(), 'bean', '/biːn/', '[{"partOfSpeech":"n.","translation":"豆子"}]', '[{"sentence":"Beans are healthy.","translation":"豆子很健康。"}]', 'raz-e', 2, NOW()),
(UUID(), 'pea', '/piː/', '[{"partOfSpeech":"n.","translation":"豌豆"}]', '[{"sentence":"Peas are small and round.","translation":"豌豆又小又圆。"}]', 'raz-e', 2, NOW()),
(UUID(), 'mushroom', '/ˈmʌʃruːm/', '[{"partOfSpeech":"n.","translation":"蘑菇"}]', '[{"sentence":"I like mushrooms.","translation":"我喜欢蘑菇。"}]', 'raz-e', 2, NOW()),

-- ============================================
-- RAZ F-J 级 - 进阶词汇 (补充)
-- ============================================
(UUID(), 'above', '/əˈbʌv/', '[{"partOfSpeech":"prep.","translation":"在...上方"}]', '[{"sentence":"The bird is above the tree.","translation":"鸟在树上方。"}]', 'raz-f', 3, NOW()),
(UUID(), 'across', '/əˈkrɒs/', '[{"partOfSpeech":"prep.","translation":"穿过"}]', '[{"sentence":"Walk across the street.","translation":"穿过街道。"}]', 'raz-f', 3, NOW()),
(UUID(), 'against', '/əˈɡenst/', '[{"partOfSpeech":"prep.","translation":"反对，靠着"}]', '[{"sentence":"Lean against the wall.","translation":"靠着墙。"}]', 'raz-f', 3, NOW()),
(UUID(), 'along', '/əˈlɒŋ/', '[{"partOfSpeech":"prep.","translation":"沿着"}]', '[{"sentence":"Walk along the river.","translation":"沿着河走。"}]', 'raz-f', 3, NOW()),
(UUID(), 'among', '/əˈmʌŋ/', '[{"partOfSpeech":"prep.","translation":"在...之中"}]', '[{"sentence":"I am among friends.","translation":"我在朋友中间。"}]', 'raz-f', 3, NOW()),
(UUID(), 'behind', '/bɪˈhaɪnd/', '[{"partOfSpeech":"prep.","translation":"在...后面"}]', '[{"sentence":"The cat is behind the box.","translation":"猫在盒子后面。"}]', 'raz-f', 3, NOW()),
(UUID(), 'beside', '/bɪˈsaɪd/', '[{"partOfSpeech":"prep.","translation":"在...旁边"}]', '[{"sentence":"Sit beside me.","translation":"坐在我旁边。"}]', 'raz-f', 3, NOW()),
(UUID(), 'by', '/baɪ/', '[{"partOfSpeech":"prep.","translation":"在...旁边，被"}]', '[{"sentence":"Stand by the door.","translation":"站在门边。"}]', 'raz-f', 3, NOW()),
(UUID(), 'down', '/daʊn/', '[{"partOfSpeech":"prep.","translation":"向下"}]', '[{"sentence":"Go down the stairs.","translation":"下楼去。"}]', 'raz-f', 3, NOW()),
(UUID(), 'up', '/ʌp/', '[{"partOfSpeech":"prep.","translation":"向上"}]', '[{"sentence":"Go up the hill.","translation":"上山去。"}]', 'raz-f', 3, NOW()),
(UUID(), 'inside', '/ɪnˈsaɪd/', '[{"partOfSpeech":"prep.","translation":"在...里面"}]', '[{"sentence":"The cat is inside.","translation":"猫在里面。"}]', 'raz-f', 3, NOW()),
(UUID(), 'outside', '/aʊtˈsaɪd/', '[{"partOfSpeech":"prep.","translation":"在...外面"}]', '[{"sentence":"It is cold outside.","translation":"外面很冷。"}]', 'raz-f', 3, NOW()),
(UUID(), 'near', '/nɪə/', '[{"partOfSpeech":"prep.","translation":"靠近"}]', '[{"sentence":"My house is near the school.","translation":"我家靠近学校。"}]', 'raz-f', 3, NOW()),
(UUID(), 'far', '/fɑː/', '[{"partOfSpeech":"adj.","translation":"远的"}]', '[{"sentence":"The park is far.","translation":"公园很远。"}]', 'raz-f', 3, NOW()),
(UUID(), 'over', '/ˈəʊvə/', '[{"partOfSpeech":"prep.","translation":"在...上方，超过"}]', '[{"sentence":"The bird flew over the tree.","translation":"鸟飞过了树。"}]', 'raz-f', 3, NOW()),
(UUID(), 'through', '/θruː/', '[{"partOfSpeech":"prep.","translation":"穿过"}]', '[{"sentence":"Walk through the door.","translation":"穿过门。"}]', 'raz-f', 3, NOW()),
(UUID(), 'to', '/tuː/', '[{"partOfSpeech":"prep.","translation":"向，到"}]', '[{"sentence":"Go to school.","translation":"去学校。"}]', 'raz-f', 3, NOW()),
(UUID(), 'toward', '/təˈwɔːd/', '[{"partOfSpeech":"prep.","translation":"朝向"}]', '[{"sentence":"Walk toward me.","translation":"朝我走来。"}]', 'raz-f', 3, NOW()),
(UUID(), 'with', '/wɪð/', '[{"partOfSpeech":"prep.","translation":"和...一起"}]', '[{"sentence":"Come with me.","translation":"跟我来。"}]', 'raz-f', 3, NOW()),
(UUID(), 'without', '/wɪˈðaʊt/', '[{"partOfSpeech":"prep.","translation":"没有"}]', '[{"sentence":"I cant live without water.","translation":"没有水我活不了。"}]', 'raz-f', 3, NOW()),

-- ============================================
-- RAZ G-K 级 - 中高级词汇 (补充)
-- ============================================
(UUID(), 'anybody', '/ˈenibɒdi/', '[{"partOfSpeech":"pron.","translation":"任何人"}]', '[{"sentence":"Is anybody home?","translation":"有人在家吗？"}]', 'raz-g', 3, NOW()),
(UUID(), 'everyone', '/ˈevriwʌn/', '[{"partOfSpeech":"pron.","translation":"每个人"}]', '[{"sentence":"Everyone likes ice cream.","translation":"每个人都喜欢冰淇淋。"}]', 'raz-g', 3, NOW()),
(UUID(), 'everything', '/ˈevriθɪŋ/', '[{"partOfSpeech":"pron.","translation":"一切"}]', '[{"sentence":"Everything is ready.","translation":"一切就绪。"}]', 'raz-g', 3, NOW()),
(UUID(), 'nobody', '/ˈnəʊbədi/', '[{"partOfSpeech":"pron.","翻译":"没有人"}]', '[{"sentence":"Nobody knows.","翻译":"没人知道。"}]', 'raz-g', 3, NOW()),
(UUID(), 'nothing', '/ˈnʌθɪŋ/', '[{"partOfSpeech":"pron.","翻译":"没有什么"}]', '[{"sentence":"Nothing is impossible.","翻译":"没有什么是不可能的。"}]', 'raz-g', 3, NOW()),
(UUID(), 'somebody', '/ˈsʌmbədi/', '[{"partOfSpeech":"pron.","翻译":"某人"}]', '[{"sentence":"Somebody is knocking.","翻译":"有人在敲门。"}]', 'raz-g', 3, NOW()),
(UUID(), 'something', '/ˈsʌmθɪŋ/', '[{"partOfSpeech":"pron.","翻译":"某事"}]', '[{"sentence":"I want something to eat.","翻译":"我想吃点东西。"}]', 'raz-g', 3, NOW()),
(UUID(), 'anywhere', '/ˈeniweə/', '[{"partOfSpeech":"adv.","翻译":"任何地方"}]', '[{"sentence":"I can go anywhere.","翻译":"我可以去任何地方。"}]', 'raz-g', 3, NOW()),
(UUID(), 'everywhere', '/ˈevriweə/', '[{"partOfSpeech":"adv.","翻译":"到处"}]', '[{"sentence":"I looked everywhere.","翻译":"我到处都找了。"}]', 'raz-g', 3, NOW()),
(UUID(), 'nowhere', '/ˈnəʊweə/', '[{"partOfSpeech":"adv.","翻译":"无处"}]', '[{"sentence":"There is nowhere to go.","翻译":"无处可去。"}]', 'raz-g', 3, NOW()),
(UUID(), 'somewhere', '/ˈsʌmweə/', '[{"partOfSpeech":"adv.","翻译":"某处"}]', '[{"sentence":"Lets go somewhere fun.","翻译":"去个好玩的地方吧。"}]', 'raz-g', 3, NOW()),
(UUID(), 'already', '/ɔːlˈredi/', '[{"partOfSpeech":"adv.","翻译":"已经"}]', '[{"sentence":"I already did it.","翻译":"我已经做好了。"}]', 'raz-g', 3, NOW()),
(UUID(), 'yet', '/jet/', '[{"partOfSpeech":"adv.","翻译":"还，尚未"}]', '[{"sentence":"I havent done it yet.","翻译":"我还没做。"}]', 'raz-g', 3, NOW()),
(UUID(), 'just', '/dʒʌst/', '[{"partOfSpeech":"adv.","翻译":"刚刚，只是"}]', '[{"sentence":"I just finished.","翻译":"我刚完成。"}]', 'raz-g', 3, NOW()),
(UUID(), 'soon', '/suːn/', '[{"partOfSpeech":"adv.","翻译":"很快"}]', '[{"sentence":"I will be back soon.","翻译":"我很快就回来。"}]', 'raz-g', 3, NOW()),

-- ============================================
-- RAZ L-P 级 - 高级词汇 (补充)
-- ============================================
(UUID(), 'ability', '/əˈbɪləti/', '[{"partOfSpeech":"n.","翻译":"能力"}]', '[{"sentence":"I have the ability to help.","翻译":"我有能力帮忙。"}]', 'raz-l', 4, NOW()),
(UUID(), 'accident', '/ˈæksɪdənt/', '[{"partOfSpeech":"n.","翻译":"事故"}]', '[{"sentence":"Be careful, avoid accidents.","翻译":"小心，避免事故。"}]', 'raz-l', 4, NOW()),
(UUID(), 'action', '/ˈækʃn/', '[{"partOfSpeech":"n.","翻译":"行动"}]', '[{"sentence":"Take action now!","翻译":"现在就行动！"}]', 'raz-l', 4, NOW()),
(UUID(), 'activity', '/ækˈtɪvəti/', '[{"partOfSpeech":"n.","翻译":"活动"}]', '[{"sentence":"What activity do you like?","翻译":"你喜欢什么活动？"}]', 'raz-l', 4, NOW()),
(UUID(), 'advantage', '/ədˈvɑːntɪdʒ/', '[{"partOfSpeech":"n.","翻译":"优势"}]', '[{"sentence":"This is a big advantage.","翻译":"这是一个很大的优势。"}]', 'raz-l', 4, NOW()),
(UUID(), 'adventure', '/ədˈventʃə/', '[{"partOfSpeech":"n.","翻译":"冒险"}]', '[{"sentence":"Life is an adventure.","翻译":"生活是一场冒险。"}]', 'raz-l', 4, NOW()),
(UUID(), 'agreement', '/əˈɡriːmənt/', '[{"partOfSpeech":"n.","翻译":"协议"}]', '[{"sentence":"We have an agreement.","翻译":"我们有一个协议。"}]', 'raz-l', 4, NOW()),
(UUID(), 'argument', '/ˈɑːɡjumənt/', '[{"partOfSpeech":"n.","翻译":"争论"}]', '[{"sentence":"Dont have an argument.","翻译":"不要争吵。"}]', 'raz-l', 4, NOW()),
(UUID(), 'attention', '/əˈtenʃn/', '[{"partOfSpeech":"n.","翻译":"注意力"}]', '[{"sentence":"Pay attention please.","翻译":"请注意。"}]', 'raz-l', 4, NOW()),
(UUID(), 'attitude', '/ˈætɪtjuːd/', '[{"partOfSpeech":"n.","翻译":"态度"}]', '[{"sentence":"Have a good attitude.","翻译":"保持好态度。"}]', 'raz-l', 4, NOW()),

-- ============================================
-- RAZ Q-Z 级 - 专家级词汇 (补充)
-- ============================================
(UUID(), 'achievement', '/əˈtʃiːvmənt/', '[{"partOfSpeech":"n.","翻译":"成就"}]', '[{"sentence":"This is a great achievement.","翻译":"这是一个伟大的成就。"}]', 'raz-q', 5, NOW()),
(UUID(), 'appreciate', '/əˈpriːʃieɪt/', '[{"partOfSpeech":"v.","翻译":"感激，欣赏"}]', '[{"sentence":"I appreciate your help.","翻译":"我感激你的帮助。"}]', 'raz-q', 5, NOW()),
(UUID(), 'approach', '/əˈprəʊtʃ/', '[{"partOfSpeech":"v.","翻译":"接近，处理"}]', '[{"sentence":"Lets approach this problem.","翻译":"让我们处理这个问题。"}]', 'raz-q', 5, NOW()),
(UUID(), 'appropriate', '/əˈprəʊpriət/', '[{"partOfSpeech":"adj.","翻译":"适当的"}]', '[{"sentence":"This is not appropriate.","翻译":"这不合适。"}]', 'raz-q', 5, NOW()),
(UUID(), 'assume', '/əˈsjuːm/', '[{"partOfSpeech":"v.","翻译":"假设"}]', '[{"sentence":"I assume you are right.","翻译":"我假设你是对的。"}]', 'raz-q', 5, NOW()),
(UUID(), 'available', '/əˈveɪləbl/', '[{"partOfSpeech":"adj.","翻译":"可用的"}]', '[{"sentence":"Is this seat available?","翻译":"这个座位有人吗？"}]', 'raz-q', 5, NOW()),
(UUID(), 'benefit', '/ˈbenɪfɪt/', '[{"partOfSpeech":"n.","翻译":"好处"}]', '[{"sentence":"What is the benefit?","翻译":"有什么好处？"}]', 'raz-q', 5, NOW()),
(UUID(), 'challenge', '/ˈtʃælɪndʒ/', '[{"partOfSpeech":"n.","翻译":"挑战"}]', '[{"sentence":"This is a big challenge.","翻译":"这是一个大挑战。"}]', 'raz-q', 5, NOW()),
(UUID(), 'character', '/ˈkærəktə/', '[{"partOfSpeech":"n.","翻译":"性格，角色"}]', '[{"sentence":"He has good character.","翻译":"他性格很好。"}]', 'raz-q', 5, NOW()),
(UUID(), 'community', '/kəˈmjuːnəti/', '[{"partOfSpeech":"n.","翻译":"社区"}]', '[{"sentence":"We live in a community.","翻译":"我们住在一个社区里。"}]', 'raz-q', 5, NOW());

-- 显示最终统计
SELECT '=== RAZ完整单词库统计 ===' as report;
SELECT COUNT(*) as total_raz_words FROM words WHERE category LIKE 'raz-%';
SELECT category, COUNT(*) as count FROM words WHERE category LIKE 'raz-%' GROUP BY category ORDER BY category;