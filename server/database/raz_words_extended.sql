-- RAZ单词库扩展 - 更多分级词汇
-- RAZ Extended Vocabulary Library

SET NAMES utf8mb4;

USE word_study;

-- ============================================
-- 扩展 RAZ aa 级 - 最基础词汇（补充）
-- ============================================
INSERT INTO words (id, word, phonetic, pronunciation, meanings, examples, image, category, difficulty, createdAt) VALUES
(UUID(), 'one', '/wʌn/', NULL, '[{"partOfSpeech":"num.","definition":"the number 1","translation":"一"}]', '[{"sentence":"I have one apple.","translation":"我有一个苹果。"}]', NULL, 'raz-aa', 1, NOW()),
(UUID(), 'two', '/tuː/', NULL, '[{"partOfSpeech":"num.","definition":"the number 2","translation":"二"}]', '[{"sentence":"I have two hands.","translation":"我有两只手。"}]', NULL, 'raz-aa', 1, NOW()),
(UUID(), 'three', '/θriː/', NULL, '[{"partOfSpeech":"num.","definition":"the number 3","translation":"三"}]', '[{"sentence":"There are three cats.","translation":"有三只猫。"}]', NULL, 'raz-aa', 1, NOW()),
(UUID(), 'four', '/fɔː/', NULL, '[{"partOfSpeech":"num.","definition":"the number 4","translation":"四"}]', '[{"sentence":"A dog has four legs.","translation":"狗有四条腿。"}]', NULL, 'raz-aa', 1, NOW()),
(UUID(), 'five', '/faɪv/', NULL, '[{"partOfSpeech":"num.","definition":"the number 5","translation":"五"}]', '[{"sentence":"I have five fingers.","translation":"我有五根手指。"}]', NULL, 'raz-aa', 1, NOW()),
(UUID(), 'six', '/sɪks/', NULL, '[{"partOfSpeech":"num.","definition":"the number 6","translation":"六"}]', '[{"sentence":"There are six eggs.","translation":"有六个鸡蛋。"}]', NULL, 'raz-aa', 1, NOW()),
(UUID(), 'seven', '/ˈsevn/', NULL, '[{"partOfSpeech":"num.","definition":"the number 7","translation":"七"}]', '[{"sentence":"Seven days in a week.","translation":"一周有七天。"}]', NULL, 'raz-aa', 1, NOW()),
(UUID(), 'eight', '/eɪt/', NULL, '[{"partOfSpeech":"num.","definition":"the number 8","translation":"八"}]', '[{"sentence":"An octopus has eight legs.","translation":"章鱼有八条腿。"}]', NULL, 'raz-aa', 1, NOW()),
(UUID(), 'nine', '/naɪn/', NULL, '[{"partOfSpeech":"num.","definition":"the number 9","translation":"九"}]', '[{"sentence":"I am nine years old.","translation":"我九岁了。"}]', NULL, 'raz-aa', 1, NOW()),
(UUID(), 'ten', '/ten/', NULL, '[{"partOfSpeech":"num.","definition":"the number 10","translation":"十"}]', '[{"sentence":"I have ten toes.","translation":"我有十个脚趾。"}]', NULL, 'raz-aa', 1, NOW()),
(UUID(), 'in', '/ɪn/', NULL, '[{"partOfSpeech":"prep.","definition":"inside","translation":"在...里面"}]', '[{"sentence":"The cat is in the box.","translation":"猫在盒子里。"}]', NULL, 'raz-aa', 1, NOW()),
(UUID(), 'on', '/ɒn/', NULL, '[{"partOfSpeech":"prep.","definition":"on top of","translation":"在...上面"}]', '[{"sentence":"The book is on the desk.","translation":"书在桌子上。"}]', NULL, 'raz-aa', 1, NOW()),
(UUID(), 'under', '/ˈʌndə/', NULL, '[{"partOfSpeech":"prep.","definition":"below","translation":"在...下面"}]', '[{"sentence":"The cat is under the table.","translation":"猫在桌子下面。"}]', NULL, 'raz-aa', 1, NOW()),
(UUID(), 'my', '/maɪ/', NULL, '[{"partOfSpeech":"pron.","definition":"belonging to me","translation":"我的"}]', '[{"sentence":"This is my book.","translation":"这是我的书。"}]', NULL, 'raz-aa', 1, NOW()),
(UUID(), 'your', '/jɔː/', NULL, '[{"partOfSpeech":"pron.","definition":"belonging to you","translation":"你的"}]', '[{"sentence":"Is this your pen?","translation":"这是你的笔吗？"}]', NULL, 'raz-aa', 1, NOW()),

-- ============================================
-- 扩展 RAZ A 级 - 基础词汇（补充）
-- ============================================
(UUID(), 'see', '/siː/', NULL, '[{"partOfSpeech":"v.","definition":"to use eyes","translation":"看见"}]', '[{"sentence":"I see a bird.","translation":"我看见一只鸟。"}]', NULL, 'raz-a', 1, NOW()),
(UUID(), 'come', '/kʌm/', NULL, '[{"partOfSpeech":"v.","definition":"to move toward","translation":"来"}]', '[{"sentence":"Come here please.","translation":"请来这里。"}]', NULL, 'raz-a', 1, NOW()),
(UUID(), 'go', '/ɡəʊ/', NULL, '[{"partOfSpeech":"v.","definition":"to move away","translation":"去"}]', '[{"sentence":"I go to school.","translation":"我去学校。"}]', NULL, 'raz-a', 1, NOW()),
(UUID(), 'open', '/ˈəʊpən/', NULL, '[{"partOfSpeech":"v.","definition":"to make open","translation":"打开"}]', '[{"sentence":"Open the door.","translation":"打开门。"}]', NULL, 'raz-a', 1, NOW()),
(UUID(), 'close', '/kləʊz/', NULL, '[{"partOfSpeech":"v.","definition":"to shut","translation":"关闭"}]', '[{"sentence":"Close the window.","translation":"关上窗户。"}]', NULL, 'raz-a', 1, NOW()),
(UUID(), 'sit', '/sɪt/', NULL, '[{"partOfSpeech":"v.","definition":"to be seated","translation":"坐"}]', '[{"sentence":"Sit down please.","translation":"请坐下。"}]', NULL, 'raz-a', 1, NOW()),
(UUID(), 'stand', '/stænd/', NULL, '[{"partOfSpeech":"v.","definition":"to be upright","translation":"站"}]', '[{"sentence":"Stand up please.","translation":"请起立。"}]', NULL, 'raz-a', 1, NOW()),
(UUID(), 'like', '/laɪk/', NULL, '[{"partOfSpeech":"v.","definition":"to enjoy","translation":"喜欢"}]', '[{"sentence":"I like apples.","translation":"我喜欢苹果。"}]', NULL, 'raz-a', 1, NOW()),
(UUID(), 'love', '/lʌv/', NULL, '[{"partOfSpeech":"v.","definition":"to feel strong affection","translation":"爱"}]', '[{"sentence":"I love my family.","translation":"我爱我的家人。"}]', NULL, 'raz-a', 1, NOW()),
(UUID(), 'have', '/hæv/', NULL, '[{"partOfSpeech":"v.","definition":"to possess","translation":"有"}]', '[{"sentence":"I have a dog.","translation":"我有一只狗。"}]', NULL, 'raz-a', 1, NOW()),
(UUID(), 'said', '/sed/', NULL, '[{"partOfSpeech":"v.","definition":"past of say","translation":"说（过去式）"}]', '[{"sentence":"She said hello.","translation":"她说了你好。"}]', NULL, 'raz-a', 1, NOW()),
(UUID(), 'say', '/seɪ/', NULL, '[{"partOfSpeech":"v.","definition":"to speak words","translation":"说"}]', '[{"sentence":"Say your name.","translation":"说出你的名字。"}]', NULL, 'raz-a', 1, NOW()),
(UUID(), 'is', '/ɪz/', NULL, '[{"partOfSpeech":"v.","definition":"form of be","translation":"是"}]', '[{"sentence":"This is a cat.","translation":"这是一只猫。"}]', NULL, 'raz-a', 1, NOW()),
(UUID(), 'are', '/ɑː/', NULL, '[{"partOfSpeech":"v.","definition":"form of be","translation":"是"}]', '[{"sentence":"We are students.","translation":"我们是学生。"}]', NULL, 'raz-a', 1, NOW()),
(UUID(), 'was', '/wɒz/', NULL, '[{"partOfSpeech":"v.","definition":"past of is","translation":"是（过去式）"}]', '[{"sentence":"He was happy.","translation":"他曾经很快乐。"}]', NULL, 'raz-a', 1, NOW()),

-- ============================================
-- 扩展 RAZ B 级 - 常用词汇（补充）
-- ============================================
(UUID(), 'little', '/ˈlɪtl/', NULL, '[{"partOfSpeech":"adj.","definition":"small in size","translation":"小的"}]', '[{"sentence":"I have a little dog.","translation":"我有一只小狗。"}]', NULL, 'raz-b', 1, NOW()),
(UUID(), 'pretty', '/ˈprɪti/', NULL, '[{"partOfSpeech":"adj.","definition":"beautiful","translation":"漂亮的"}]', '[{"sentence":"She is pretty.","translation":"她很漂亮。"}]', NULL, 'raz-b', 1, NOW()),
(UUID(), 'many', '/ˈmeni/', NULL, '[{"partOfSpeech":"adj.","definition":"a lot of","translation":"许多"}]', '[{"sentence":"I have many books.","translation":"我有很多书。"}]', NULL, 'raz-b', 1, NOW()),
(UUID(), 'some', '/sʌm/', NULL, '[{"partOfSpeech":"adj.","definition":"an amount","translation":"一些"}]', '[{"sentence":"I have some apples.","translation":"我有一些苹果。"}]', NULL, 'raz-b', 1, NOW()),
(UUID(), 'these', '/ðiːz/', NULL, '[{"partOfSpeech":"pron.","definition":"more than one nearby","translation":"这些"}]', '[{"sentence":"These are my friends.","translation":"这些是我的朋友。"}]', NULL, 'raz-b', 1, NOW()),
(UUID(), 'those', '/ðəʊz/', NULL, '[{"partOfSpeech":"pron.","definition":"more than one far away","translation":"那些"}]', '[{"sentence":"Those are birds.","translation":"那些是鸟。"}]', NULL, 'raz-b', 1, NOW()),
(UUID(), 'this', '/ðɪs/', NULL, '[{"partOfSpeech":"pron.","definition":"one nearby","translation":"这个"}]', '[{"sentence":"This is my book.","translation":"这是我的书。"}]', NULL, 'raz-b', 1, NOW()),
(UUID(), 'that', '/ðæt/', NULL, '[{"partOfSpeech":"pron.","definition":"one far away","translation":"那个"}]', '[{"sentence":"That is a tree.","translation":"那是一棵树。"}]', NULL, 'raz-b', 1, NOW()),
(UUID(), 'here', '/hɪə/', NULL, '[{"partOfSpeech":"adv.","definition":"at this place","translation":"这里"}]', '[{"sentence":"Come here.","translation":"来这里。"}]', NULL, 'raz-b', 1, NOW()),
(UUID(), 'there', '/ðeə/', NULL, '[{"partOfSpeech":"adv.","definition":"at that place","translation":"那里"}]', '[{"sentence":"The cat is there.","translation":"猫在那里。"}]', NULL, 'raz-b', 1, NOW()),
(UUID(), 'now', '/naʊ/', NULL, '[{"partOfSpeech":"adv.","definition":"at this time","translation":"现在"}]', '[{"sentence":"We can go now.","translation":"我们现在可以走了。"}]', NULL, 'raz-b', 1, NOW()),
(UUID(), 'then', '/ðen/', NULL, '[{"partOfSpeech":"adv.","definition":"at that time","translation":"那时，然后"}]', '[{"sentence":"Then we went home.","translation":"然后我们回家了。"}]', NULL, 'raz-b', 1, NOW()),
(UUID(), 'again', '/əˈɡen/', NULL, '[{"partOfSpeech":"adv.","definition":"once more","translation":"再一次"}]', '[{"sentence":"Read it again.","translation":"再读一遍。"}]', NULL, 'raz-b', 1, NOW()),
(UUID(), 'too', '/tuː/', NULL, '[{"partOfSpeech":"adv.","definition":"also, very","translation":"也，太"}]', '[{"sentence":"Me too!","translation":"我也是！"}]', NULL, 'raz-b', 1, NOW()),
(UUID(), 'very', '/ˈveri/', NULL, '[{"partOfSpeech":"adv.","definition":"a lot","translation":"非常"}]', '[{"sentence":"It is very hot.","translation":"非常热。"}]', NULL, 'raz-b', 1, NOW()),

-- ============================================
-- 扩展 RAZ C 级 - 进阶基础词汇（补充）
-- ============================================
(UUID(), 'Monday', '/ˈmʌndeɪ/', NULL, '[{"partOfSpeech":"n.","definition":"first day of week","translation":"星期一"}]', '[{"sentence":"Today is Monday.","translation":"今天是星期一。"}]', NULL, 'raz-c', 2, NOW()),
(UUID(), 'Tuesday', '/ˈtjuːzdeɪ/', NULL, '[{"partOfSpeech":"n.","definition":"second day of week","translation":"星期二"}]', '[{"sentence":"I have class on Tuesday.","translation":"我星期二有课。"}]', NULL, 'raz-c', 2, NOW()),
(UUID(), 'Wednesday', '/ˈwenzdeɪ/', NULL, '[{"partOfSpeech":"n.","definition":"third day of week","translation":"星期三"}]', '[{"sentence":"Wednesday is midweek.","translation":"星期三是周中。"}]', NULL, 'raz-c', 2, NOW()),
(UUID(), 'Thursday', '/ˈθɜːzdeɪ/', NULL, '[{"partOfSpeech":"n.","definition":"fourth day of week","translation":"星期四"}]', '[{"sentence":"Thursday comes after Wednesday.","translation":"星期四在星期三之后。"}]', NULL, 'raz-c', 2, NOW()),
(UUID(), 'Friday', '/ˈfraɪdeɪ/', NULL, '[{"partOfSpeech":"n.","definition":"fifth day of week","translation":"星期五"}]', '[{"sentence":"I love Friday!","translation":"我喜欢星期五！"}]', NULL, 'raz-c', 2, NOW()),
(UUID(), 'Saturday', '/ˈsætədeɪ/', NULL, '[{"partOfSpeech":"n.","definition":"sixth day of week","translation":"星期六"}]', '[{"sentence":"Saturday is fun!","translation":"星期六很有趣！"}]', NULL, 'raz-c', 2, NOW()),
(UUID(), 'Sunday', '/ˈsʌndeɪ/', NULL, '[{"partOfSpeech":"n.","definition":"seventh day of week","translation":"星期日"}]', '[{"sentence":"Sunday is a rest day.","translation":"星期日是休息日。"}]', NULL, 'raz-c', 2, NOW()),
(UUID(), 'January', '/ˈdʒænjuəri/', NULL, '[{"partOfSpeech":"n.","definition":"first month","translation":"一月"}]', '[{"sentence":"January is cold.","translation":"一月很冷。"}]', NULL, 'raz-c', 2, NOW()),
(UUID(), 'February', '/ˈfebruəri/', NULL, '[{"partOfSpeech":"n.","definition":"second month","translation":"二月"}]', '[{"sentence":"February is short.","translation":"二月很短。"}]', NULL, 'raz-c', 2, NOW()),
(UUID(), 'March', '/mɑːtʃ/', NULL, '[{"partOfSpeech":"n.","definition":"third month","translation":"三月"}]', '[{"sentence":"March brings spring.","translation":"三月带来春天。"}]', NULL, 'raz-c', 2, NOW()),
(UUID(), 'April', '/ˈeɪprəl/', NULL, '[{"partOfSpeech":"n.","definition":"fourth month","translation":"四月"}]', '[{"sentence":"April showers bring flowers.","translation":"四月的雨带来花朵。"}]', NULL, 'raz-c', 2, NOW()),
(UUID(), 'May', '/meɪ/', NULL, '[{"partOfSpeech":"n.","definition":"fifth month","translation":"五月"}]', '[{"sentence":"May is beautiful.","translation":"五月很美。"}]', NULL, 'raz-c', 2, NOW()),
(UUID(), 'June', '/dʒuːn/', NULL, '[{"partOfSpeech":"n.","definition":"sixth month","translation":"六月"}]', '[{"sentence":"June is the start of summer.","translation":"六月是夏天的开始。"}]', NULL, 'raz-c', 2, NOW()),
(UUID(), 'July', '/dʒuˈlaɪ/', NULL, '[{"partOfSpeech":"n.","definition":"seventh month","translation":"七月"}]', '[{"sentence":"July is hot.","translation":"七月很热。"}]', NULL, 'raz-c', 2, NOW()),
(UUID(), 'August', '/ˈɔːɡəst/', NULL, '[{"partOfSpeech":"n.","definition":"eighth month","translation":"八月"}]', '[{"sentence":"August is a vacation month.","translation":"八月是假期月份。"}]', NULL, 'raz-c', 2, NOW()),

-- ============================================
-- 扩展 RAZ D 级 - 扩展词汇（补充）
-- ============================================
(UUID(), 'rabbit', '/ˈræbɪt/', NULL, '[{"partOfSpeech":"n.","definition":"a small furry animal","translation":"兔子"}]', '[{"sentence":"The rabbit hops.","translation":"兔子会跳。"}]', NULL, 'raz-d', 2, NOW()),
(UUID(), 'duck', '/dʌk/', NULL, '[{"partOfSpeech":"n.","definition":"a water bird","translation":"鸭子"}]', '[{"sentence":"The duck swims.","translation":"鸭子会游泳。"}]', NULL, 'raz-d', 2, NOW()),
(UUID(), 'chicken', '/ˈtʃɪkɪn/', NULL, '[{"partOfSpeech":"n.","definition":"a farm bird","translation":"鸡"}]', '[{"sentence":"We have chickens on the farm.","translation":"农场里有鸡。"}]', NULL, 'raz-d', 2, NOW()),
(UUID(), 'horse', '/hɔːs/', NULL, '[{"partOfSpeech":"n.","definition":"a large animal for riding","translation":"马"}]', '[{"sentence":"The horse runs fast.","translation":"马跑得很快。"}]', NULL, 'raz-d', 2, NOW()),
(UUID(), 'cow', '/kaʊ/', NULL, '[{"partOfSpeech":"n.","definition":"a large farm animal","translation":"牛"}]', '[{"sentence":"Cows give us milk.","translation":"牛给我们牛奶。"}]', NULL, 'raz-d', 2, NOW()),
(UUID(), 'sheep', '/ʃiːp/', NULL, '[{"partOfSpeech":"n.","definition":"a woolly animal","translation":"绵羊"}]', '[{"sentence":"Sheep have wool.","translation":"绵羊有羊毛。"}]', NULL, 'raz-d', 2, NOW()),
(UUID(), 'goat', '/ɡəʊt/', NULL, '[{"partOfSpeech":"n.","definition":"a climbing animal","translation":"山羊"}]', '[{"sentence":"Goats can climb.","translation":"山羊会攀爬。"}]', NULL, 'raz-d', 2, NOW()),
(UUID(), 'elephant', '/ˈelɪfənt/', NULL, '[{"partOfSpeech":"n.","definition":"a very large animal","translation":"大象"}]', '[{"sentence":"Elephants have long noses.","translation":"大象有长鼻子。"}]', NULL, 'raz-d', 2, NOW()),
(UUID(), 'lion', '/ˈlaɪən/', NULL, '[{"partOfSpeech":"n.","definition":"king of the jungle","translation":"狮子"}]', '[{"sentence":"The lion is strong.","translation":"狮子很强壮。"}]', NULL, 'raz-d', 2, NOW()),
(UUID(), 'tiger', '/ˈtaɪɡə/', NULL, '[{"partOfSpeech":"n.","definition":"a striped big cat","translation":"老虎"}]', '[{"sentence":"Tigers have stripes.","translation":"老虎有条纹。"}]', NULL, 'raz-d', 2, NOW()),
(UUID(), 'bear', '/beə/', NULL, '[{"partOfSpeech":"n.","definition":"a large furry animal","translation":"熊"}]', '[{"sentence":"Bears sleep in winter.","translation":"熊在冬天睡觉。"}]', NULL, 'raz-d', 2, NOW()),
(UUID(), 'monkey', '/ˈmʌŋki/', NULL, '[{"partOfSpeech":"n.","definition":"an animal that climbs","translation":"猴子"}]', '[{"sentence":"Monkeys like bananas.","translation":"猴子喜欢香蕉。"}]', NULL, 'raz-d', 2, NOW()),
(UUID(), 'snake', '/sneɪk/', NULL, '[{"partOfSpeech":"n.","definition":"a long legless animal","translation":"蛇"}]', '[{"sentence":"Snakes have no legs.","translation":"蛇没有腿。"}]', NULL, 'raz-d', 2, NOW()),
(UUID(), 'frog', '/frɒɡ/', NULL, '[{"partOfSpeech":"n.","definition":"a jumping animal","translation":"青蛙"}]', '[{"sentence":"Frogs can jump.","translation":"青蛙会跳。"}]', NULL, 'raz-d', 2, NOW()),
(UUID(), 'turtle', '/ˈtɜːtl/', NULL, '[{"partOfSpeech":"n.","definition":"an animal with a shell","translation":"乌龟"}]', '[{"sentence":"Turtles are slow.","translation":"乌龟很慢。"}]', NULL, 'raz-d', 2, NOW()),

-- ============================================
-- 扩展 RAZ E 级 - 进阶词汇（补充）
-- ============================================
(UUID(), 'breakfast', '/ˈbrekfəst/', NULL, '[{"partOfSpeech":"n.","definition":"morning meal","translation":"早餐"}]', '[{"sentence":"I eat breakfast at 7 am.","translation":"我早上7点吃早餐。"}]', NULL, 'raz-e', 2, NOW()),
(UUID(), 'lunch', '/lʌntʃ/', NULL, '[{"partOfSpeech":"n.","definition":"midday meal","translation":"午餐"}]', '[{"sentence":"I have lunch at school.","translation":"我在学校吃午餐。"}]', NULL, 'raz-e', 2, NOW()),
(UUID(), 'dinner', '/ˈdɪnə/', NULL, '[{"partOfSpeech":"n.","definition":"evening meal","translation":"晚餐"}]', '[{"sentence":"We eat dinner together.","translation":"我们一起吃晚餐。"}]', NULL, 'raz-e', 2, NOW()),
(UUID(), 'snack', '/snæk/', NULL, '[{"partOfSpeech":"n.","definition":"small meal","translation":"零食"}]', '[{"sentence":"I want a snack.","translation":"我想要零食。"}]', NULL, 'raz-e', 2, NOW()),
(UUID(), 'bread', '/bred/', NULL, '[{"partOfSpeech":"n.","definition":"baked food","translation":"面包"}]', '[{"sentence":"I eat bread for breakfast.","translation":"我早餐吃面包。"}]', NULL, 'raz-e', 2, NOW()),
(UUID(), 'cheese', '/tʃiːz/', NULL, '[{"partOfSpeech":"n.","definition":"food made from milk","translation":"奶酪"}]', '[{"sentence":"I like cheese.","translation":"我喜欢奶酪。"}]', NULL, 'raz-e', 2, NOW()),
(UUID(), 'butter', '/ˈbʌtə/', NULL, '[{"partOfSpeech":"n.","definition":"fat from milk","translation":"黄油"}]', '[{"sentence":"Put butter on bread.","translation":"在面包上涂黄油。"}]', NULL, 'raz-e', 2, NOW()),
(UUID(), 'soup', '/suːp/', NULL, '[{"partOfSpeech":"n.","definition":"liquid food","translation":"汤"}]', '[{"sentence":"The soup is hot.","translation":"汤很热。"}]', NULL, 'raz-e', 2, NOW()),
(UUID(), 'salad', '/ˈsæləd/', NULL, '[{"partOfSpeech":"n.","definition":"mixed vegetables","translation":"沙拉"}]', '[{"sentence":"I like vegetable salad.","translation":"我喜欢蔬菜沙拉。"}]', NULL, 'raz-e', 2, NOW()),
(UUID(), 'pizza', '/ˈpiːtsə/', NULL, '[{"partOfSpeech":"n.","definition":"Italian flat bread dish","translation":"披萨"}]', '[{"sentence":"Pizza is delicious.","translation":"披萨很好吃。"}]', NULL, 'raz-e', 2, NOW()),
(UUID(), 'hamburger', '/ˈhæmbɜːɡə/', NULL, '[{"partOfSpeech":"n.","definition":"meat in a bun","translation":"汉堡包"}]', '[{"sentence":"I want a hamburger.","translation":"我想要一个汉堡包。"}]', NULL, 'raz-e', 2, NOW()),
(UUID(), 'sandwich', '/ˈsænwɪtʃ/', NULL, '[{"partOfSpeech":"n.","definition":"food between bread","translation":"三明治"}]', '[{"sentence":"I make a sandwich.","translation":"我做了一个三明治。"}]', NULL, 'raz-e', 2, NOW()),
(UUID(), 'cookie', '/ˈkʊki/', NULL, '[{"partOfSpeech":"n.","definition":"small sweet cake","translation":"饼干"}]', '[{"sentence":"I eat a cookie.","translation":"我吃了一块饼干。"}]', NULL, 'raz-e', 2, NOW()),
(UUID(), 'cake', '/keɪk/', NULL, '[{"partOfSpeech":"n.","definition":"sweet baked food","translation":"蛋糕"}]', '[{"sentence":"I want birthday cake.","translation":"我想要生日蛋糕。"}]', NULL, 'raz-e', 2, NOW()),
(UUID(), 'ice cream', '/ˌaɪs ˈkriːm/', NULL, '[{"partOfSpeech":"n.","definition":"frozen sweet","translation":"冰淇淋"}]', '[{"sentence":"I love ice cream!","translation":"我喜欢冰淇淋！"}]', NULL, 'raz-e', 2, NOW()),

-- ============================================
-- 扩展 RAZ F 级 - 中级词汇（补充）
-- ============================================
(UUID(), 'playground', '/ˈpleɪɡraʊnd/', NULL, '[{"partOfSpeech":"n.","definition":"place for playing","translation":"操场"}]', '[{"sentence":"We play on the playground.","translation":"我们在操场上玩。"}]', NULL, 'raz-f', 3, NOW()),
(UUID(), 'classroom', '/ˈklɑːsruːm/', NULL, '[{"partOfSpeech":"n.","definition":"room for learning","translation":"教室"}]', '[{"sentence":"We learn in the classroom.","translation":"我们在教室里学习。"}]', NULL, 'raz-f', 3, NOW()),
(UUID(), 'library', '/ˈlaɪbrəri/', NULL, '[{"partOfSpeech":"n.","definition":"place with books","translation":"图书馆"}]', '[{"sentence":"I go to the library.","translation":"我去图书馆。"}]', NULL, 'raz-f', 3, NOW()),
(UUID(), 'hospital', '/ˈhɒspɪtl/', NULL, '[{"partOfSpeech":"n.","definition":"place for sick people","translation":"医院"}]', '[{"sentence":"My mom works at the hospital.","translation":"我妈妈在医院工作。"}]', NULL, 'raz-f', 3, NOW()),
(UUID(), 'supermarket', '/ˈsuːpəˌmɑːkɪt/', NULL, '[{"partOfSpeech":"n.","definition":"large store for food","translation":"超市"}]', '[{"sentence":"We shop at the supermarket.","translation":"我们在超市购物。"}]', NULL, 'raz-f', 3, NOW()),
(UUID(), 'restaurant', '/ˈrestrɒnt/', NULL, '[{"partOfSpeech":"n.","definition":"place to eat","翻译":"餐厅"}]', '[{"sentence":"We eat at a restaurant.","translation":"我们在餐厅吃饭。"}]', NULL, 'raz-f', 3, NOW()),
(UUID(), 'museum', '/mjuˈziːəm/', NULL, '[{"partOfSpeech":"n.","definition":"place with exhibits","translation":"博物馆"}]', '[{"sentence":"We visit the museum.","translation":"我们参观博物馆。"}]', NULL, 'raz-f', 3, NOW()),
(UUID(), 'park', '/pɑːk/', NULL, '[{"partOfSpeech":"n.","definition":"public garden","translation":"公园"}]', '[{"sentence":"We play in the park.","translation":"我们在公园玩。"}]', NULL, 'raz-f', 3, NOW()),
(UUID(), 'beach', '/biːtʃ/', NULL, '[{"partOfSpeech":"n.","definition":"sandy shore","translation":"海滩"}]', '[{"sentence":"We swim at the beach.","translation":"我们在海滩游泳。"}]', NULL, 'raz-f', 3, NOW()),
(UUID(), 'forest', '/ˈfɒrɪst/', NULL, '[{"partOfSpeech":"n.","definition":"area with many trees","翻译":"森林"}]', '[{"sentence":"There are many trees in the forest.","translation":"森林里有很多树。"}]', NULL, 'raz-f', 3, NOW()),

-- ============================================
-- 扩展 RAZ G-H 级 - 中级词汇（补充）
-- ============================================
(UUID(), 'together', '/təˈɡeðə/', NULL, '[{"partOfSpeech":"adv.","definition":"with each other","翻译":"一起"}]', '[{"sentence":"We play together.","翻译":"我们一起玩。"}]', NULL, 'raz-g', 3, NOW()),
(UUID(), 'everyone', '/ˈevriwʌn/', NULL, '[{"partOfSpeech":"pron.","definition":"all people","翻译":"每个人"}]', '[{"sentence":"Everyone is here.","翻译":"每个人都在这里。"}]', NULL, 'raz-g', 3, NOW()),
(UUID(), 'everything', '/ˈevriθɪŋ/', NULL, '[{"partOfSpeech":"pron.","definition":"all things","翻译":"一切"}]', '[{"sentence":"Everything is ready.","翻译":"一切都准备好了。"}]', NULL, 'raz-g', 3, NOW()),
(UUID(), 'something', '/ˈsʌmθɪŋ/', NULL, '[{"partOfSpeech":"pron.","definition":"some thing","翻译":"某事"}]', '[{"sentence":"I want something to eat.","翻译":"我想吃点东西。"}]', NULL, 'raz-g', 3, NOW()),
(UUID(), 'nothing', '/ˈnʌθɪŋ/', NULL, '[{"partOfSpeech":"pron.","definition":"not anything","翻译":"没有什么"}]', '[{"sentence":"There is nothing to do.","翻译":"没什么可做的。"}]', NULL, 'raz-g', 3, NOW()),
(UUID(), 'anything', '/ˈeniθɪŋ/', NULL, '[{"partOfSpeech":"pron.","definition":"any thing","翻译":"任何事"}]', '[{"sentence":"I can do anything!","翻译":"我什么都能做！"}]', NULL, 'raz-g', 3, NOW()),
(UUID(), 'anyone', '/ˈeniwʌn/', NULL, '[{"partOfSpeech":"pron.","definition":"any person","翻译":"任何人"}]', '[{"sentence":"Can anyone help me?","翻译":"有人能帮我吗？"}]', NULL, 'raz-g', 3, NOW()),
(UUID(), 'someone', '/ˈsʌmwʌn/', NULL, '[{"partOfSpeech":"pron.","definition":"some person","翻译":"某人"}]', '[{"sentence":"Someone is at the door.","翻译":"有人在门口。"}]', NULL, 'raz-g', 3, NOW()),
(UUID(), 'myself', '/maɪˈself/', NULL, '[{"partOfSpeech":"pron.","definition":"me alone","翻译":"我自己"}]', '[{"sentence":"I can do it myself.","翻译":"我自己能做。"}]', NULL, 'raz-g', 3, NOW()),
(UUID(), 'yourself', '/jɔːˈself/', NULL, '[{"partOfSpeech":"pron.","definition":"you alone","翻译":"你自己"}]', '[{"sentence":"Do it yourself!","翻译":"你自己做！"}]', NULL, 'raz-g', 3, NOW()),

-- ============================================
-- 扩展 RAZ I-L 级 - 中高级词汇（补充）
-- ============================================
(UUID(), 'slowly', '/ˈsləʊli/', NULL, '[{"partOfSpeech":"adv.","definition":"not fast","翻译":"慢慢地"}]', '[{"sentence":"The turtle walks slowly.","翻译":"乌龟慢慢地走。"}]', NULL, 'raz-i', 3, NOW()),
(UUID(), 'quickly', '/ˈkwɪkli/', NULL, '[{"partOfSpeech":"adv.","definition":"fast","翻译":"快速地"}]', '[{"sentence":"Run quickly!","翻译":"快跑！"}]', NULL, 'raz-i', 3, NOW()),
(UUID(), 'carefully', '/ˈkeəfəli/', NULL, '[{"partOfSpeech":"adv.","definition":"with care","翻译":"小心地"}]', '[{"sentence":"Read carefully.","翻译":"仔细阅读。"}]', NULL, 'raz-i', 3, NOW()),
(UUID(), 'quietly', '/ˈkwaɪətli/', NULL, '[{"partOfSpeech":"adv.","definition":"without noise","翻译":"安静地"}]', '[{"sentence":"Please walk quietly.","翻译":"请安静地走。"}]', NULL, 'raz-i', 3, NOW()),
(UUID(), 'loudly', '/ˈlaʊdli/', NULL, '[{"partOfSpeech":"adv.","definition":"with noise","翻译":"大声地"}]', '[{"sentence":"The dog barks loudly.","翻译":"狗大声地叫。"}]', NULL, 'raz-i', 3, NOW()),
(UUID(), 'happily', '/ˈhæpɪli/', NULL, '[{"partOfSpeech":"adv.","definition":"with joy","翻译":"快乐地"}]', '[{"sentence":"She sings happily.","翻译":"她快乐地唱歌。"}]', NULL, 'raz-i', 3, NOW()),
(UUID(), 'sadly', '/ˈsædli/', NULL, '[{"partOfSpeech":"adv.","definition":"with sadness","翻译":"悲伤地"}]', '[{"sentence":"He walked away sadly.","翻译":"他悲伤地走开了。"}]', NULL, 'raz-i', 3, NOW()),
(UUID(), 'easily', '/ˈiːzəli/', NULL, '[{"partOfSpeech":"adv.","definition":"without difficulty","翻译":"容易地"}]', '[{"sentence":"I can do it easily.","翻译":"我可以很容易地做到。"}]', NULL, 'raz-i', 3, NOW()),

-- ============================================
-- 扩展 RAZ M-P 级 - 高级词汇（补充）
-- ============================================
(UUID(), 'actually', '/ˈæktʃuəli/', NULL, '[{"partOfSpeech":"adv.","definition":"in fact","翻译":"实际上"}]', '[{"sentence":"Actually, I dont know.","翻译":"实际上，我不知道。"}]', NULL, 'raz-m', 4, NOW()),
(UUID(), 'probably', '/ˈprɒbəbli/', NULL, '[{"partOfSpeech":"adv.","definition":"most likely","翻译":"可能"}]', '[{"sentence":"It will probably rain.","翻译":"可能会下雨。"}]', NULL, 'raz-m', 4, NOW()),
(UUID(), 'certainly', '/ˈsɜːtnli/', NULL, '[{"partOfSpeech":"adv.","definition":"definitely","翻译":"当然"}]', '[{"sentence":"Certainly, I will help.","翻译":"当然，我会帮忙。"}]', NULL, 'raz-m', 4, NOW()),
(UUID(), 'especially', '/ɪˈspeʃəli/', NULL, '[{"partOfSpeech":"adv.","definition":"particularly","翻译":"尤其"}]', '[{"sentence":"I like fruits, especially apples.","翻译":"我喜欢水果，尤其是苹果。"}]', NULL, 'raz-m', 4, NOW()),
(UUID(), 'finally', '/ˈfaɪnəli/', NULL, '[{"partOfSpeech":"adv.","definition":"at last","翻译":"最后"}]', '[{"sentence":"Finally, we arrived.","翻译":"最后，我们到了。"}]', NULL, 'raz-m', 4, NOW()),
(UUID(), 'suddenly', '/ˈsʌdənli/', NULL, '[{"partOfSpeech":"adv.","definition":"unexpectedly","翻译":"突然"}]', '[{"sentence":"Suddenly, it started to rain.","翻译":"突然，开始下雨了。"}]', NULL, 'raz-m', 4, NOW()),

-- ============================================
-- 扩展 RAZ Q-T 级 - 高级进阶词汇（补充）
-- ============================================
(UUID(), 'knowledge', '/ˈnɒlɪdʒ/', NULL, '[{"partOfSpeech":"n.","definition":"what you know","翻译":"知识"}]', '[{"sentence":"Knowledge is power.","翻译":"知识就是力量。"}]', NULL, 'raz-q', 5, NOW()),
(UUID(), 'information', '/ˌɪnfəˈmeɪʃn/', NULL, '[{"partOfSpeech":"n.","definition":"facts","翻译":"信息"}]', '[{"sentence":"I need more information.","翻译":"我需要更多信息。"}]', NULL, 'raz-q', 5, NOW()),
(UUID(), 'education', '/ˌedʒuˈkeɪʃn/', NULL, '[{"partOfSpeech":"n.","definition":"learning","翻译":"教育"}]', '[{"sentence":"Education is important.","翻译":"教育很重要。"}]', NULL, 'raz-q', 5, NOW()),
(UUID(), 'problem', '/ˈprɒbləm/', NULL, '[{"partOfSpeech":"n.","definition":"difficulty","翻译":"问题"}]', '[{"sentence":"We have a problem to solve.","翻译":"我们要解决一个问题。"}]', NULL, 'raz-q', 5, NOW()),
(UUID(), 'solution', '/səˈluːʃn/', NULL, '[{"partOfSpeech":"n.","definition":"answer","翻译":"解决方案"}]', '[{"sentence":"We need to find a solution.","翻译":"我们需要找到解决方案。"}]', NULL, 'raz-q', 5, NOW()),
(UUID(), 'question', '/ˈkwestʃən/', NULL, '[{"partOfSpeech":"n.","definition":"something asked","翻译":"问题"}]', '[{"sentence":"Please answer the question.","翻译":"请回答这个问题。"}]', NULL, 'raz-q', 5, NOW()),

-- ============================================
-- RAZ U-Z 级 - 最高级词汇
-- ============================================
(UUID(), 'adventure', '/ədˈventʃə/', NULL, '[{"partOfSpeech":"n.","definition":"exciting experience","翻译":"冒险"}]', '[{"sentence":"Life is an adventure.","翻译":"生活就是一场冒险。"}]', NULL, 'raz-u', 5, NOW()),
(UUID(), 'mystery', '/ˈmɪstəri/', NULL, '[{"partOfSpeech":"n.","definition":"something unknown","翻译":"神秘"}]', '[{"sentence":"It is a mystery.","翻译":"这是一个谜。"}]', NULL, 'raz-u', 5, NOW()),
(UUID(), 'imagination', '/ɪˌmædʒɪˈneɪʃn/', NULL, '[{"partOfSpeech":"n.","definition":"ability to imagine","翻译":"想象力"}]', '[{"sentence":"Use your imagination.","翻译":"发挥你的想象力。"}]', NULL, 'raz-u', 5, NOW()),
(UUID(), 'creativity', '/ˌkriːeɪˈtɪvəti/', NULL, '[{"partOfSpeech":"n.","definition":"ability to create","翻译":"创造力"}]', '[{"sentence":"Creativity is important.","翻译":"创造力很重要。"}]', NULL, 'raz-u', 5, NOW()),
(UUID(), 'opportunity', '/ˌɒpəˈtjuːnəti/', NULL, '[{"partOfSpeech":"n.","definition":"chance","翻译":"机会"}]', '[{"sentence":"This is a good opportunity.","翻译":"这是一个好机会。"}]', NULL, 'raz-u', 5, NOW()),
(UUID(), 'responsibility', '/rɪˌspɒnsəˈbɪləti/', NULL, '[{"partOfSpeech":"n.","definition":"duty","翻译":"责任"}]', '[{"sentence":"I take responsibility.","翻译":"我承担责任。"}]', NULL, 'raz-v', 5, NOW()),
(UUID(), 'communication', '/kəˌmjuːnɪˈkeɪʃn/', NULL, '[{"partOfSpeech":"n.","definition":"sharing information","翻译":"沟通"}]', '[{"sentence":"Good communication is key.","翻译":"良好的沟通是关键。"}]', NULL, 'raz-v', 5, NOW()),
(UUID(), 'determination', '/dɪˌtɜːmɪˈneɪʃn/', NULL, '[{"partOfSpeech":"n.","definition":"strong will","翻译":"决心"}]', '[{"sentence":"With determination, you can succeed.","翻译":"有决心就能成功。"}]', NULL, 'raz-v', 5, NOW()),
(UUID(), 'independent', '/ˌɪndɪˈpendənt/', NULL, '[{"partOfSpeech":"adj.","definition":"not dependent","翻译":"独立的"}]', '[{"sentence":"Be independent!","翻译":"要独立！"}]', NULL, 'raz-w', 5, NOW()),
(UUID(), 'confident', '/ˈkɒnfɪdənt/', NULL, '[{"partOfSpeech":"adj.","definition":"sure of oneself","翻译":"自信的"}]', '[{"sentence":"Be confident!","翻译":"要自信！"}]', NULL, 'raz-w', 5, NOW()),
(UUID(), 'patient', '/ˈpeɪʃənt/', NULL, '[{"partOfSpeech":"adj.","definition":"able to wait","翻译":"耐心的"}]', '[{"sentence":"Be patient, please.","翻译":"请耐心等待。"}]', NULL, 'raz-w', 5, NOW()),
(UUID(), 'courageous', '/kəˈreɪdʒəs/', NULL, '[{"partOfSpeech":"adj.","definition":"brave","翻译":"勇敢的"}]', '[{"sentence":"Be courageous!","翻译":"要勇敢！"}]', NULL, 'raz-x', 5, NOW()),
(UUID(), 'curious', '/ˈkjʊəriəs/', NULL, '[{"partOfSpeech":"adj.","definition":"wanting to know","翻译":"好奇的"}]', '[{"sentence":"Be curious about the world.","翻译":"对世界保持好奇。"}]', NULL, 'raz-x', 5, NOW()),
(UUID(), 'generous', '/ˈdʒenərəs/', NULL, '[{"partOfSpeech":"adj.","definition":"willing to give","翻译":"慷慨的"}]', '[{"sentence":"He is very generous.","翻译":"他很慷慨。"}]', NULL, 'raz-x', 5, NOW()),
(UUID(), 'ambitious', '/æmˈbɪʃəs/', NULL, '[{"partOfSpeech":"adj.","definition":"having big goals","翻译":"有雄心的"}]', '[{"sentence":"She is ambitious.","翻译":"她很有雄心。"}]', NULL, 'raz-y', 5, NOW()),
(UUID(), 'enthusiastic', '/ɪnˌθjuːziˈæstɪk/', NULL, '[{"partOfSpeech":"adj.","definition":"very interested","翻译":"热情的"}]', '[{"sentence":"He is enthusiastic about learning.","翻译":"他对学习很热情。"}]', NULL, 'raz-y', 5, NOW()),
(UUID(), 'extraordinary', '/ɪkˈstrɔːdnri/', NULL, '[{"partOfSpeech":"adj.","definition":"very special","翻译":"非凡的"}]', '[{"sentence":"What an extraordinary idea!","翻译":"多么非凡的想法！"}]', NULL, 'raz-z', 5, NOW()),
(UUID(), 'remarkable', '/rɪˈmɑːkəbl/', NULL, '[{"partOfSpeech":"adj.","definition":"worth noticing","翻译":"卓越的"}]', '[{"sentence":"She has remarkable talent.","翻译":"她有卓越的天赋。"}]', NULL, 'raz-z', 5, NOW()),
(UUID(), 'phenomenal', '/fɪˈnɒmɪnl/', NULL, '[{"partOfSpeech":"adj.","definition":"extraordinary","翻译":"惊人的"}]', '[{"sentence":"His performance was phenomenal.","翻译":"他的表现太惊人了。"}]', NULL, 'raz-z', 5, NOW()),
(UUID(), 'magnificent', '/mæɡˈnɪfɪsənt/', NULL, '[{"partOfSpeech":"adj.","definition":"very beautiful","翻译":"壮丽的"}]', '[{"sentence":"The view is magnificent.","翻译":"景色壮丽。"}]', NULL, 'raz-z', 5, NOW());

-- 显示最终统计
SELECT '=== RAZ单词库统计 ===' as report;
SELECT COUNT(*) as total_words FROM words WHERE category LIKE 'raz-%';
SELECT category, COUNT(*) as count FROM words WHERE category LIKE 'raz-%' GROUP BY category ORDER BY category;