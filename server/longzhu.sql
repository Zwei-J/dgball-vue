SET NAMES UTF8;
DROP DATABASE IF EXISTS lz;
CREATE DATABASE lz CHARSET=UTF8;
USE lz;

#用户、轮播、片系列、视频列表、评论、弹幕、系列对应图表

CREATE TABLE lz_user(
	uid INT PRIMARY KEY AUTO_INCREMENT,
	phone VARCHAR(16) NOT NULL UNIQUE,
	name VARCHAR(16) NOT NULL UNIQUE,
	pwd VARCHAR(48) NOT NULL,
	avatar VARCHAR(64) DEFAULT "image/avatar/defaultAvt.jpg",
	level enum("1","2","3") DEFAULT "1"
);
INSERT INTO lz_user VALUES(null,15818860047,"admin_JJ",md5("123abc"),DEFAULT,"3");

CREATE TABLE carousel(
	cid INT PRIMARY KEY AUTO_INCREMENT,
	src VARCHAR(64) NOT NULL
);

CREATE TABLE lz_series(
	seriesId INT PRIMARY KEY AUTO_INCREMENT,
	seriesName VARCHAR(32) NOT NULL,	#动画名
	pTime VARCHAR(4) NOT NULL,	#时间
	area VARCHAR(8) NOT NULL,	#地区
	type VARCHAR(32) NOT NULL,	#类型
	lang VARCHAR(8) NOT NULL,	#语言
	version VARCHAR(8) NOT NULL,	#TV版
	Akira VARCHAR(64) NOT NULL,		#声优
		#集数和总播放量要统计
	introduce VARCHAR(1024) NOT NULL,	#简介
	seriesLogo_lg VARCHAR(64) NOT NULL,	 #大图
	seriesLogo_sm VARCHAR(64) NOT NULL,  #小图
	bgVideo VARCHAR(64) NOT NULL,
	start SMALLINT NOT NULL,		#开始集数
	logo VARCHAR(64) NOT NULL,
	hot INT NOT NULL #热度
);
#lz_series
INSERT INTO lz_series VALUES(
	null,
	"龙珠",
	"1986",
	"日漫",
	"动作_热血_冒险_番剧",
	"日语",
	"TV版",
	"野泽雅子_青野武_堀川亮_皆口裕子",
	"独自住在深山的少年孙悟空，遇上搜集七龙珠的少女科学家布尔玛，布尔玛为得到悟空拥有的四星七龙珠而带同悟空踏上找寻七龙珠的旅程。长有尾巴的孙悟空天生神力，加上曾得到己过世的爷爷（孙悟饭）训练武术，所以悟空找寻七龙珠的期间多次打败作恶的坏人，并且认识了乌龙、乐平、龟仙人、牛魔王及其女儿琪琪（琪琪成了他的未婚妻）等朋友。在找寻最后一颗七龙珠时闯进皮拉夫的城堡，后来悟空因月圆而变身成巨猿，被剪掉尾巴，七龙珠亦因乌龙的许愿而四散。",
	"image/index/rec_00.jpg",
	"image/detail/rec_00.jpg",
	"video/001.mp4",
	1,
	"image/play/logo/01.jpg",
	18543154
);
INSERT INTO lz_series VALUES(
	null,
	"龙珠Z",
	"1992",
	"日漫",
	"动作_热血_冒险_番剧",
	"日语",
	"TV版",
	"野泽雅子_古川登志夫_堀川亮_中尾隆圣",
	"悟空的哥哥拉帝兹来到地球，透漏了悟空原是战斗民族的赛亚人战士，并抢走了孙悟饭威胁悟空一天之内杀死一百个地球人，悟空和比克大魔王联手对抗，然而因为双方实力的差距而陷入苦战。由于赛亚人的侵略，比克等龙珠战士战死，七龙珠也随着消失，为了让死去的战士复活，克林、悟饭和布尔玛出发前往那美克星球寻找七龙珠。贝吉塔为了得到永生，也去了那美克星。贝吉塔等人把受伤的悟空送入治疗室诊治，这时候那美克星的龙珠已经聚集，克林与悟饭让天天召唤出了神龙，许到最后一个愿望的时候大长老牺牲，神龙因此消失。与此同时，比克从神龙的愿望中复活！",
	"image/index/rec_01.jpg",
	"image/detail/rec_01.jpg",
	"video/002.mp4",
	154,
	"image/play/logo/02.jpg",
	35874321
);
INSERT INTO lz_series VALUES(
	null,
	"龙珠GT",
	"1996",
	"日漫",
	"动作_热血_冒险_番剧",
	"日语",
	"TV版",
	"野泽雅子_堀川亮_古川登志夫",
	"故事发生于\"七龙珠Z\" 10年后的世界，早于先代天神和魔王比克分体前，其即创造了黑星龙珠。每当它完成心愿后的黑星龙珠会散布于宇宙各处，要是一年内无法集齐七粒黑星龙珠在一起的话，最初许愿的星球便会被自体毁灭。自龙珠故事开篇即开始找寻七龙珠的皮拉夫及众手下设法找到了黑星龙珠，于许愿时误会地许了使悟空变回小孩子的愿望，愿望实现后黑星龙珠四散宇宙中。后来，悟空和现代特兰克斯、孙女BoBo(小芳)一同乘宇宙飞船到宇宙中找寻黑星龙珠以拯救地球，途中由于一个高智能机器人吉鲁将龙珠雷达以食物消化，其以机器及铁制品为食，具有将一切食物之用途化为己用的能力，故本领高强，拥有很大提升空间。吉鲁原本是罪犯星球的罪犯手下，后改邪归正，助众人寻找黑星龙珠，成为众人战友，其多次毁坏均被众人修复及再造，后其与众人一同于地球居住。",
	"image/index/rec_04.jpg",
	"image/detail/rec_02.jpg",
	"video/003.mp4",
	445,
	"image/play/logo/03.jpg",
	20518548
);
INSERT INTO lz_series VALUES(
	null,
	"龙珠超",
	"2015",
	"日漫",
	"动作_热血_冒险_搞笑_番剧",
	"日语",
	"TV版",
	"野泽雅子_青野武_堀川亮_皆口裕子",
	"《龙珠》新系列动画的舞台为悟空与魔人布欧的壮绝战斗结束后，地球重新恢复和平之后发生的故事。与自漫长沉睡中觉醒的破坏神比鲁斯的相遇，加上曾经被人敬畏为“宇宙帝王”的弗利萨的复活，在这些接连迫近悟空等人的威胁之上，地球周边还发生了星球消失的不可思议现象，更有神秘的新角色“象帕”登场。",
	"image/index/rec_02.jpg",
	"image/detail/rec_03.jpg",
	"video/004.mp4",
	509,
	"image/play/logo/04.jpg",
	36451205
);

CREATE TABLE videoList(
	vid INT PRIMARY KEY AUTO_INCREMENT,
	sid INT,
		FOREIGN KEY(sid) REFERENCES lz_series(seriesId),
	num SMALLINT NOT NULL,	#第几集
	title VARCHAR(64) NOT NULL,
	imgSrc VARCHAR(64) NOT NULL,
	videoSrc VARCHAR(64),	#视频路径
	vTime VARCHAR(8) NOT NULL,
	playCount INT DEFAULT 0,
	thumbUp INT DEFAULT 0	#点赞
);

CREATE TABLE videoComments(
	commId INT PRIMARY KEY AUTO_INCREMENT,
	videoId INT,
		FOREIGN KEY(videoId) REFERENCES videoList(vid),
	commUid INT,
		FOREIGN KEY(commUid) REFERENCES lz_user(uid),
	content VARCHAR(1024) NOT NULL,
	commTime BIGINT
);


CREATE TABLE seriesImg(
	sImgId INT PRIMARY KEY AUTO_INCREMENT,
	sid INT,
		FOREIGN KEY(sid) REFERENCES lz_series(seriesId),
	source VARCHAR(64) NOT NULL
);

#carousel
INSERT INTO carousel VALUES(null,"image/index/banner1.jpg");
INSERT INTO carousel VALUES(null,"image/index/banner2.jpg");
INSERT INTO carousel VALUES(null,"image/index/banner3.jpg");
INSERT INTO carousel VALUES(null,"image/index/banner4.jpg");
INSERT INTO carousel VALUES(null,"image/index/banner5.jpg");

#seriesImg
#1
INSERT INTO seriesImg VALUES(null,1,"image/detail/banner_01.jpg");
INSERT INTO seriesImg VALUES(null,1,"image/detail/banner_02.jpg");
INSERT INTO seriesImg VALUES(null,1,"image/detail/banner_03.jpg");
#z
INSERT INTO seriesImg VALUES(null,2,"image/detail/banner_04.jpg");
INSERT INTO seriesImg VALUES(null,2,"image/detail/banner_05.jpg");
INSERT INTO seriesImg VALUES(null,2,"image/detail/banner_06.jpg");
#gt
INSERT INTO seriesImg VALUES(null,3,"image/detail/banner_07.jpg");
INSERT INTO seriesImg VALUES(null,3,"image/detail/banner_08.jpg");
INSERT INTO seriesImg VALUES(null,3,"image/detail/banner_09.jpg");
#super
INSERT INTO seriesImg VALUES(null,4,"image/detail/banner_10.jpg");
INSERT INTO seriesImg VALUES(null,4,"image/detail/banner_11.jpg");
INSERT INTO seriesImg VALUES(null,4,"image/detail/banner_12.jpg");

#videoList
#1
INSERT INTO videoList VALUES(null,1,1,"布尔玛与孙悟空","image/detail/allSeries/01_001.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,2,"布尔玛没有尾巴","image/detail/allSeries/01_002.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,3,"龟仙人的筋斗云","image/detail/allSeries/01_003.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,4,"抢人的妖怪","image/detail/allSeries/01_004.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,5,"邪恶沙漠的雅木茶","image/detail/allSeries/01_005.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,6,"黑夜中的访问者","image/detail/allSeries/01_006.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,7,"煎锅山的牛魔王","image/detail/allSeries/01_007.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,8,"龟仙人的龟派气功波","image/detail/allSeries/01_008.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,9,"兔子头儿的绝招","image/detail/allSeries/01_009.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,10,"龙珠被抢","image/detail/allSeries/01_010.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,11,"龙终于出现","image/detail/allSeries/01_011.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,12,"向神龙许愿","image/detail/allSeries/01_012.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,13,"悟空的大变身","image/detail/allSeries/01_013.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,14,"竞争者来访","image/detail/allSeries/01_014.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,15,"不可思议的女孩","image/detail/allSeries/01_015.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,16,"寻找石头的功夫","image/detail/allSeries/01_016.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,17,"发送牛奶","image/detail/allSeries/01_017.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,18,"龟仙流的严格修行","image/detail/allSeries/01_018.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,19,"天下第一武道会开始","image/detail/allSeries/01_019.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,20,"修行的威力","image/detail/allSeries/01_020.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,21,"克林危险","image/detail/allSeries/01_021.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,22,"雅木茶对成龙","image/detail/allSeries/01_022.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,23,"强敌出现了","image/detail/allSeries/01_023.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,24,"拼死的攻防站","image/detail/allSeries/01_024.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,25,"天空十字拳","image/detail/allSeries/01_025.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,26,"大决战","image/detail/allSeries/01_026.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,27,"悟空最大的危机","image/detail/allSeries/01_027.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,28,"力量的激斗","image/detail/allSeries/01_028.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,29,"冒险再度开始","image/detail/allSeries/01_029.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,30,"神秘军团","image/detail/allSeries/01_030.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,31,"假悟空出现","image/detail/allSeries/01_031.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,32,"飞天要塞","image/detail/allSeries/01_032.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,33,"龙的传说","image/detail/allSeries/01_033.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,34,"红缎带军团","image/detail/allSeries/01_034.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,35,"北方女孩","image/detail/allSeries/01_035.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,36,"恐怖的玛斯鲁塔","image/detail/allSeries/01_036.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,37,"忍者出现","image/detail/allSeries/01_037.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,38,"恐怖的分身术","image/detail/allSeries/01_038.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,39,"人造人8号","image/detail/allSeries/01_039.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,40,"战栗的大肥龙","image/detail/allSeries/01_040.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,41,"玛斯鲁塔的毁灭","image/detail/allSeries/01_041.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,42,"阿八加油","image/detail/allSeries/01_042.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,43,"西部之家","image/detail/allSeries/01_043.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,44,"危机四起","image/detail/allSeries/01_044.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,45,"空中陷阱","image/detail/allSeries/01_045.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,46,"布尔玛的大失败","image/detail/allSeries/01_046.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,47,"发现龟仙屋","image/detail/allSeries/01_047.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,48,"布鲁将军攻击","image/detail/allSeries/01_048.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,49,"朗奇的危机","image/detail/allSeries/01_049.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,50,"海盗的陷阱","image/detail/allSeries/01_050.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,51,"海底巡逻者","image/detail/allSeries/01_051.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,52,"发现宝物","image/detail/allSeries/01_052.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,53,"恐怖之眼","image/detail/allSeries/01_053.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,54,"大逃命","image/detail/allSeries/01_054.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,55,"追到企鹅村","image/detail/allSeries/01_055.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,56,"小雨坐筋斗云","image/detail/allSeries/01_056.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,57,"小雨对布鲁","image/detail/allSeries/01_057.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,58,"魔境圣地","image/detail/allSeries/01_058.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,59,"最强的杀手","image/detail/allSeries/01_059.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,60,"与洞洞波决斗","image/detail/allSeries/01_060.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,61,"塔上的卡林神","image/detail/allSeries/01_061.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,62,"超神水的效果","image/detail/allSeries/01_062.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,63,"悟空大反击","image/detail/allSeries/01_063.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,64,"桃白白的末日","image/detail/allSeries/01_064.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,65,"开始突击","image/detail/allSeries/01_065.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,66,"红缎带攻防战","image/detail/allSeries/01_066.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,67,"瑞特总帅死了","image/detail/allSeries/01_067.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,68,"最后的龙珠","image/detail/allSeries/01_068.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,69,"占卜婆婆","image/detail/allSeries/01_069.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,70,"五人战士大突击","image/detail/allSeries/01_070.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,71,"决死流血战","image/detail/allSeries/01_071.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,72,"恶魔的厕所","image/detail/allSeries/01_072.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,73,"必杀恶魔光线","image/detail/allSeries/01_073.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,74,"神秘的男人","image/detail/allSeries/01_074.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,75,"龙争虎斗","image/detail/allSeries/01_075.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,76,"庐山真面目","image/detail/allSeries/01_076.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,77,"皮拉夫大作战","image/detail/allSeries/01_077.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,78,"神龙再度出现","image/detail/allSeries/01_078.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,79,"金角跟银角","image/detail/allSeries/01_079.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,80,"悟空对抗天龙","image/detail/allSeries/01_080.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,81,"悟空去魔界","image/detail/allSeries/01_081.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,82,"猪鹿蝶","image/detail/allSeries/01_082.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,83,"天下第一武道会","image/detail/allSeries/01_083.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,84,"天下第一高手","image/detail/allSeries/01_084.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,85,"打赢预赛","image/detail/allSeries/01_085.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,86,"打进前八强","image/detail/allSeries/01_086.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,87,"雅木茶对抗天津饭","image/detail/allSeries/01_087.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,88,"可怕的天津饭","image/detail/allSeries/01_088.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,89,"满月之恨","image/detail/allSeries/01_089.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,90,"洞洞波重现","image/detail/allSeries/01_090.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,91,"克林反败为胜","image/detail/allSeries/01_091.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,92,"孙悟空上场了","image/detail/allSeries/01_092.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,93,"成龙对抗天津饭","image/detail/allSeries/01_093.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,94,"太阳拳","image/detail/allSeries/01_094.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,95,"悟空对抗克林","image/detail/allSeries/01_095.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,96,"克林大作战","image/detail/allSeries/01_096.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,97,"龙争虎斗","image/detail/allSeries/01_097.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,98,"秘籍 排球拳","image/detail/allSeries/01_098.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,99,"天津饭的烦恼","image/detail/allSeries/01_099.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,100,"最后的手段","image/detail/allSeries/01_100.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,101,"武道会结束","image/detail/allSeries/01_101.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,102,"克林之死","image/detail/allSeries/01_102.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,103,"比克大魔王","image/detail/allSeries/01_103.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,104,"悟空复活吧","image/detail/allSeries/01_104.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,105,"怪男孩 亚奇洛贝登场","image/detail/allSeries/01_105.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,106,"魔兽塔姆博林来了","image/detail/allSeries/01_106.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,107,"孙悟空大发雷霆","image/detail/allSeries/01_107.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,108,"比克大魔王亲自出马","image/detail/allSeries/01_108.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,109,"悟空对比克大魔王","image/detail/allSeries/01_109.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,110,"加油！孙悟空","image/detail/allSeries/01_110.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,111,"龟仙人最后的魔封波","image/detail/allSeries/01_111.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,112,"能恢复年轻吗？比克大魔王","image/detail/allSeries/01_112.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,113,"凯斯鲁金的攻防","image/detail/allSeries/01_113.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,114,"悟空的愿望 卡林大人好为难","image/detail/allSeries/01_114.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,115,"一定要找到迷般的超神水","image/detail/allSeries/01_115.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,116,"龟仙人还活着","image/detail/allSeries/01_116.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,117,"孙悟空终于要出动","image/detail/allSeries/01_117.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,118,"天津饭的决心","image/detail/allSeries/01_118.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,119,"能成功吗 传说的魔封波","image/detail/allSeries/01_119.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,120,"悟空 愤怒战力全开","image/detail/allSeries/01_120.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,121,"悟空最大的危机","image/detail/allSeries/01_121.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,122,"最后的赌注","image/detail/allSeries/01_122.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,123,"如意棒的秘密","image/detail/allSeries/01_123.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,124,"云上的神殿","image/detail/allSeries/01_124.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,125,"神将登场","image/detail/allSeries/01_125.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,126,"复活的神龙","image/detail/allSeries/01_126.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,127,"比闪电还要快","image/detail/allSeries/01_127.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,128,"像天空一般静寂","image/detail/allSeries/01_128.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,129,"坠入光阴中的悟空","image/detail/allSeries/01_129.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,130,"悟空的敌人竟是悟空","image/detail/allSeries/01_130.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,131,"朝着个人的目标前进","image/detail/allSeries/01_131.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,132,"比岩浆还火热","image/detail/allSeries/01_132.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,133,"暴风雨前的重逢","image/detail/allSeries/01_133.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,134,"暗潮汹涌的天下第一武道会","image/detail/allSeries/01_134.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,135,"被选中的八个人","image/detail/allSeries/01_135.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,136,"杀手桃白白的逆袭","image/detail/allSeries/01_136.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,137,"孙悟空结婚","image/detail/allSeries/01_137.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,138,"来历不明的仙","image/detail/allSeries/01_138.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,139,"再次激战孙悟空对天津饭","image/detail/allSeries/01_139.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,140,"真正的实力","image/detail/allSeries/01_140.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,141,"四个天津饭","image/detail/allSeries/01_141.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,142,"到底谁厉害 神对比克大魔王","image/detail/allSeries/01_142.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,143,"关系这世界的命运","image/detail/allSeries/01_143.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,144,"出现了完美龟派气功","image/detail/allSeries/01_144.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,145,"比克大魔王超巨身术","image/detail/allSeries/01_145.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,146,"孙悟空的陷阱","image/detail/allSeries/01_146.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,147,"万事休矣","image/detail/allSeries/01_147.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,148,"赢了 地球上最强的男人","image/detail/allSeries/01_148.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,149,"火光中的结婚礼服","image/detail/allSeries/01_149.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,150,"梦幻的吞火鸟","image/detail/allSeries/01_150.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,151,"多亏了琪琪的新娘学习课程","image/detail/allSeries/01_151.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,152,"悟空，快点！五行山之迷","image/detail/allSeries/01_152.jpg",NULL,"24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,1,153,"燃烧的平底山 瞬间的生死行","image/detail/allSeries/01_153.jpg",NULL,"24:06",DEFAULT,DEFAULT);

#z
INSERT INTO videoList VALUES(null,2,1,"我的名字是悟饭！迷你悟空。","image/detail/allSeries/00_001.jpg","video/media/00_001.mp4","24:06",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,2,"史上最强的战士 悟空的哥哥！","image/detail/allSeries/00_002.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,3,"太棒了！我们是地上最强的组合！","image/detail/allSeries/00_003.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,4,"比克的最后王牌！悟饭是个爱哭鬼","image/detail/allSeries/00_004.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,5,"悟空死了！最后机会只有一次","image/detail/allSeries/00_005.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,6,"阎罗王也吓一跳 黄泉的战斗","image/detail/allSeries/00_006.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,7,"恐龙与搏斗！悟饭的苦修","image/detail/allSeries/00_007.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,8,"月圆之夜大变身！悟饭潜力的秘密","image/detail/allSeries/00_008.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,9,"对不起机器人 消失在沙漠的眼泪。","image/detail/allSeries/00_009.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,10,"别哭悟饭！第一次的战斗","image/detail/allSeries/00_010.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,11,"宇宙第一的强战士赛亚人的觉醒！","image/detail/allSeries/00_011.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,12,"在蛇道上打瞌睡的悟空掉下去了","image/detail/allSeries/00_012.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,13,"不准出手！阎罗王的秘密果实","image/detail/allSeries/00_013.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,14,"甜美的诱惑！蛇姬的招待","image/detail/allSeries/00_014.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,15,"逃出比克的控制！暴风雨中的悟饭","image/detail/allSeries/00_015.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,16,"跑啊悟饭！妈妈在包子山的等待","image/detail/allSeries/00_016.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,17,"没有明天之路！胜利之路尚远","image/detail/allSeries/00_017.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,18,"蛇道的终点！你是界王吗？","image/detail/allSeries/00_018.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,19,"与重力的战斗！抓住巴布鲁斯","image/detail/allSeries/00_019.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,20,"赛亚人传说！悟空的起源","image/detail/allSeries/00_020.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,21,"出来吧神龙！赛亚人终于到达地球","image/detail/allSeries/00_021.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,22,"不可能！土里生出栽培人","image/detail/allSeries/00_022.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,23,"乐平死了！可怕的栽培人","image/detail/allSeries/00_023.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,24,"再见了天哥！饺子的舍身战法","image/detail/allSeries/00_024.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,25,"天津饭绝叫！这是最后的气功炮","image/detail/allSeries/00_025.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,26,"等待3小时！弹丸飞行的筋斗云","image/detail/allSeries/00_026.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,27,"交给我吧！悟饭·愤怒的大爆发","image/detail/allSeries/00_027.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,28,"赛亚人的威猛！神仙与短笛都死了","image/detail/allSeries/00_028.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,29,"爸爸好厉害！究极的必杀技·界王拳","image/detail/allSeries/00_029.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,30,"超越极限的热战！悟空对贝吉塔","image/detail/allSeries/00_030.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,31,"加油啊悟空！最后的绝招","image/detail/allSeries/00_031.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,32,"战斗力10倍！贝吉塔大变身","image/detail/allSeries/00_032.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,33,"你不能死啊爸爸！悟饭的潜力","image/detail/allSeries/00_033.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,34,"攻击吧克林！希望全在元气弹","image/detail/allSeries/00_034.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,35,"奇迹的发生！超级赛亚人孙悟饭","image/detail/allSeries/00_035.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,36,"飞出宇宙！希望之星在短笛的故乡","image/detail/allSeries/00_036.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,37,"谜之工具！寻找神的宇宙船","image/detail/allSeries/00_037.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,38,"朝那美克星前进！等待悟饭他们的恐怖","image/detail/allSeries/00_038.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,39,"敌人还是朋友？谜之巨大宇宙船的小孩","image/detail/allSeries/00_039.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,40,"这是真的吗？那就是希望的那美克星","image/detail/allSeries/00_040.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,41,"亲切的宇宙人 一下就找到五星球","image/detail/allSeries/00_041.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,42,"惑星弗利萨NO.79 复活的贝吉塔！","image/detail/allSeries/00_042.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,43,"找齐7龙珠！短笛可以复活了","image/detail/allSeries/00_043.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,44,"新的强敌！宇宙的帝王弗利萨","image/detail/allSeries/00_044.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,45,"贝吉塔的野心！宇宙第一的战士就是我！","image/detail/allSeries/00_045.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,46,"悟空动力全开！6天到达银河的尽头","image/detail/allSeries/00_046.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,47,"出人意表的攻击！长老的目标是侦测器","image/detail/allSeries/00_047.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,48,"悟饭危险！呼唤死亡的追踪者多多利亚","image/detail/allSeries/00_048.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,49,"炸死多多利亚！贝吉塔可怕的冲击波","image/detail/allSeries/00_049.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,50,"逃出燃烧的行星！豁出性命的龟派气功","image/detail/allSeries/00_050.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,51,"勇气百倍！在界王之下集结的战士们","image/detail/allSeries/00_051.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,52,"悟空听着！千万别对弗利萨出手","image/detail/allSeries/00_052.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,53,"美战士萨博的恶魔的变身","image/detail/allSeries/00_053.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,54,"守护希望之星！克林惊异的实力提升","image/detail/allSeries/00_054.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,55,"从死亡深渊爬上来 奇迹之男·贝吉塔","image/detail/allSeries/00_055.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,56,"强大的战斗力！碎散的弗利萨的阴谋","image/detail/allSeries/00_056.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,57,"元气恢复了！100倍超重力之中的悟空","image/detail/allSeries/00_057.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,58,"弗利萨的秘密武器！恶魔的基纽特战队","image/detail/allSeries/00_058.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,59,"布尔玛危险！四星球落入弗利萨之手","image/detail/allSeries/00_059.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,60,"激突！不屈的斗志之界王拳与龟派气功波","image/detail/allSeries/00_060.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,61,"逼近的决战！基纽特战队到达！","image/detail/allSeries/00_061.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,62,"悟空接近！突破弗利萨的包围网","image/detail/allSeries/00_062.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,63,"是魔术还是特技？Mr.古尔多发怒了！","image/detail/allSeries/00_063.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,64,"猛攻利库姆！又恶又强的家伙","image/detail/allSeries/00_064.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,65,"别死啊悟饭！悟空就要到达战场了","image/detail/allSeries/00_065.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,66,"超强实力！传说的超级赛亚人孙悟空","image/detail/allSeries/00_066.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,67,"青红光球！捷斯与巴特攻击悟空","image/detail/allSeries/00_067.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,68,"直接对决！基纽队长的出战","image/detail/allSeries/00_068.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,69,"可怕的迫力！出现了、悟空的全力","image/detail/allSeries/00_069.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,70,"战斗的结果！逼近大长老弗利萨的魔手","image/detail/allSeries/00_070.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,71,"掉包！悟空就是基纽基纽就是悟空","image/detail/allSeries/00_071.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,72,"出来吧超神龙！请实现我的愿望","image/detail/allSeries/00_072.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,73,"他不是我！悟饭别怕快打爸爸啊！","image/detail/allSeries/00_073.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,74,"大误算！基纽变成青蛙了","image/detail/allSeries/00_074.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,75,"聚集在七龙珠前的人…说出暗号吧！","image/detail/allSeries/00_075.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,76,"神复活了！超级神龙让短笛复活","image/detail/allSeries/00_076.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,77,"最强战士的诞生？内鲁与短笛合体","image/detail/allSeries/00_077.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,78,"恶梦的超级变身！战斗力100万的弗利萨","image/detail/allSeries/00_078.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,79,"展现强大的力量悟饭攻击了","image/detail/allSeries/00_079.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,80,"突然形势逆转！迟来的战士·短笛","image/detail/allSeries/00_080.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,81,"短笛的自信！打倒弗利萨的人就是我","image/detail/allSeries/00_081.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,82,"出击吧悟空！愤怒的弗利萨第2次变身","image/detail/allSeries/00_082.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,83,"恐怖！弗利萨第3度变身决胜负","image/detail/allSeries/00_083.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,84,"丹迪的死…施展！所有的力量","image/detail/allSeries/00_084.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,85,"一直等待的一刻！孙悟空复活了","image/detail/allSeries/00_085.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,86,"无念…！高傲的赛亚人·贝吉塔死了","image/detail/allSeries/00_086.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,87,"超级决战开幕！我会打倒你这恶魔","image/detail/allSeries/00_087.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,88,"激突的2大超强战力！本气同士的肉弹战！","image/detail/allSeries/00_088.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,89,"弗利萨的恐怖宣言！不使用双手","image/detail/allSeries/00_089.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,90,"我可不是虚张声势！实力坚强·孙悟空","image/detail/allSeries/00_090.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,91,"决着！炎之化身 20倍界王拳的冲击波","image/detail/allSeries/00_091.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,92,"超特大的元气弹！最后的绝招","image/detail/allSeries/00_092.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,93,"制造机会！短笛舍身掩护攻击","image/detail/allSeries/00_093.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,94,"元气弹的超级破坏力！存活的会是谁","image/detail/allSeries/00_094.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,95,"悟空变身！传说的超级赛亚人·孙悟空","image/detail/allSeries/00_095.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,96,"愤怒爆发！悟空、你要为大家报仇啊","image/detail/allSeries/00_096.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,97,"纳美克星会消灭吗？贯穿大地的魔闪光","image/detail/allSeries/00_097.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,98,"赢的人是我！全豁出去所做的最后攻击","image/detail/allSeries/00_098.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,99,"神龙求你帮帮忙！纳美克星就要消灭了","image/detail/allSeries/00_099.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,100,"我是孙悟空的儿子！悟饭再次上场","image/detail/allSeries/00_100.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,101,"我要留在这里！通往胜利的最后愿望","image/detail/allSeries/00_101.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,102,"奋战到底吧！留在即将消失星球上的人","image/detail/allSeries/00_102.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,103,"悲哀的弗利萨！不可扼抑的颤抖","image/detail/allSeries/00_103.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,104,"悟空的胜利宣言！弗利萨自取灭亡","image/detail/allSeries/00_104.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,105,"愤怒的一击","image/detail/allSeries/00_105.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,106,"纳美克星爆炸","image/detail/allSeries/00_106.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,107,"战士全部复活","image/detail/allSeries/00_107.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,108,"天界大变动","image/detail/allSeries/00_108.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,109,"恐怖的雾","image/detail/allSeries/00_109.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,110,"天界成战场","image/detail/allSeries/00_110.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,111,"魔闪光之怒","image/detail/allSeries/00_111.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,112,"神殿超神水","image/detail/allSeries/00_112.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,113,"无法等到早上","image/detail/allSeries/00_113.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,114,"超出常理的神","image/detail/allSeries/00_114.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,115,"超神水生效","image/detail/allSeries/00_115.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,116,"攻击魔凶星","image/detail/allSeries/00_116.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,117,"克林的求婚","image/detail/allSeries/00_117.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,118,"弗利萨父子的反击","image/detail/allSeries/00_118.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,119,"神秘少年","image/detail/allSeries/00_119.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,120,"新超级赛亚人","image/detail/allSeries/00_120.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,121,"好久不见","image/detail/allSeries/00_121.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,122,"我爸爸是贝吉塔","image/detail/allSeries/00_122.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,123,"看我的瞬间移动","image/detail/allSeries/00_123.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,124,"赛亚人之王","image/detail/allSeries/00_124.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,125,"悟空的新试练","image/detail/allSeries/00_125.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,126,"谁是人造人","image/detail/allSeries/00_126.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,127,"愤怒的超级变身","image/detail/allSeries/00_127.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,128,"病魔与敌人夹攻","image/detail/allSeries/00_128.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,129,"超级赛亚人之血","image/detail/allSeries/00_129.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,130,"盖洛博士的秘密","image/detail/allSeries/00_130.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,131,"现实更可怕吗 特兰克斯的疑惑","image/detail/allSeries/00_131.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,132,"找出格罗研究所","image/detail/allSeries/00_132.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,133,"7号跟18号觉醒","image/detail/allSeries/00_133.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,134,"一切都太迟了吗！？用来杀死悟空的最终","image/detail/allSeries/00_134.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,135,"可爱面孔下的超力量 18号没有死角","image/detail/allSeries/00_135.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,136,"无论是谁都无法阻止 Z战士全灭！？","image/detail/allSeries/00_136.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,137,"比克的决心 珍藏的最后手段","image/detail/allSeries/00_137.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,138,"步行的超破坏武器 人造人类逼近悟空","image/detail/allSeries/00_138.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,139,"不详的预感 布玛所告知的推理剧","image/detail/allSeries/00_139.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,140,"发现邪恶的蛋 害怕的特兰克斯","image/detail/allSeries/00_140.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,141,"前所未有的大对决 超级纳美克星人诞生了","image/detail/allSeries/00_141.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,142,"龟派气功波 拥有悟空的气的怪物","image/detail/allSeries/00_142.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,143,"憎恨与破坏的生命体 就是人造人类沙鲁","image/detail/allSeries/00_143.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,144,"比克痛恨的大失败 沙鲁逃走了","image/detail/allSeries/00_144.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,145,"沙鲁诞生的秘密 研究所的地下有些什么","image/detail/allSeries/00_145.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,146,"悟空对战斗的觉醒 他超越了超级赛亚人","image/detail/allSeries/00_146.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,147,"快速修行的赛亚人 精神和时间的房子","image/detail/allSeries/00_147.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,148,"天崩地列的激烈光弹 比克对人造人类17号","image/detail/allSeries/00_148.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,149,"沙鲁迈向成熟体之序曲","image/detail/allSeries/00_149.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,150,"身反击无效 比克用尽全身的力量","image/detail/allSeries/00_150.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,151,"唯一留下的希望 就是无言的战士十六号","image/detail/allSeries/00_151.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,152,"吞下十七号 有超强力量的沙鲁","image/detail/allSeries/00_152.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,153,"明天我就会打败你 悟空的挑战书","image/detail/allSeries/00_153.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,154,"一切由我来收拾 新生贝吉塔父子出击","image/detail/allSeries/00_154.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,155,"贝吉塔光耀眼的超级力量","image/detail/allSeries/00_155.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,156,"沙鲁你给我跪下 我是超级贝吉塔","image/detail/allSeries/00_156.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,157,"危险的骄傲 向沙鲁全形挑战","image/detail/allSeries/00_157.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,158,"沙鲁终于发现18号的下落了","image/detail/allSeries/00_158.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,159,"全宇宙的冲击 沙鲁变化成全形了","image/detail/allSeries/00_159.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,160,"战斗力无限 名为沙鲁的破坏之神诞生","image/detail/allSeries/00_160.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,161,"超级贝吉塔危险 全然的恐怖迫近了","image/detail/allSeries/00_161.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,162,"突破超级赛亚人极限 暴风般的特兰克斯","image/detail/allSeries/00_162.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,163,"拯救父亲 特兰克斯的愤怒烧红了天际","image/detail/allSeries/00_163.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,164,"绝望的未来 挣扎出地狱的特兰克斯","image/detail/allSeries/00_164.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,165,"超级特兰克斯的弱点 沙鲁惊人的宣言","image/detail/allSeries/00_165.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,166,"迫在眉睫的大决战 第一武道大会之谜","image/detail/allSeries/00_166.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,167,"收视率百分之百 独家播放沙鲁大赛","image/detail/allSeries/00_167.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,168,"悟空与悟饭这对英雄父子能力的提升","image/detail/allSeries/00_168.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,169,"悟空以逸待劳 静静等待沙鲁大会","image/detail/allSeries/00_169.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,170,"战士的休息 少女、谎言与悟饭的决心","image/detail/allSeries/00_170.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,171,"潜藏的力量 悟饭小的时候","image/detail/allSeries/00_171.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,172,"悟空瞬间移动寻找新的天神","image/detail/allSeries/00_172.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,173,"天天的第一份工作 七龙珠复活了","image/detail/allSeries/00_173.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,174,"悟空的难题 尽快取回七龙珠","image/detail/allSeries/00_174.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,175,"向沙鲁挑战的战士 决战开幕了","image/detail/allSeries/00_175.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,176,"等一下 撒旦军团大暴动","image/detail/allSeries/00_176.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,177,"悟空上场 沙鲁大赛情势紧张","image/detail/allSeries/00_177.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,178,"地球首当其冲 沙鲁的超级龟派气功波","image/detail/allSeries/00_178.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,179,"不是输就是死 悟空反败为胜的秘密","image/detail/allSeries/00_179.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,180,"殊死的大决战 悟空的投降宣言","image/detail/allSeries/00_180.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,181,"最强的继承人 他的名字是悟饭","image/detail/allSeries/00_181.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,182,"小小的威胁 小沙鲁来袭","image/detail/allSeries/00_182.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,183,"小小的威胁 小沙鲁来袭","image/detail/allSeries/00_183.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,184,"十六号的悲惨下场 悟饭的愤怒爆发了","image/detail/allSeries/00_184.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,185,"汹涌的实力_小沙鲁彻底瓦解","image/detail/allSeries/00_185.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,186,"击倒沙鲁 两发超铁拳搞定","image/detail/allSeries/00_186.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,187,"沙鲁产生异变 全形完全崩溃","image/detail/allSeries/00_187.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,188,"大家再见 悟空最后的瞬间移动","image/detail/allSeries/00_188.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,189,"白昼的恶梦 极端的恐怖","image/detail/allSeries/00_189.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,190,"悟空对悟饭的教导 横越阴阳界","image/detail/allSeries/00_190.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,191,"战斗结束了 谢谢你 孙悟空","image/detail/allSeries/00_191.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,192,"在极乐世界修练 欢笑的别离","image/detail/allSeries/00_192.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,193,"全新的生活 爸爸 我会继续努力","image/detail/allSeries/00_193.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,194,"另一种结局 未来就靠我保护了","image/detail/allSeries/00_194.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,195,"太棒了 地府也有武功高手","image/detail/allSeries/00_195.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,196,"我是地府第一 历代勇士大集合","image/detail/allSeries/00_196.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,197,"大界王星狂热 惊人的悟空旋风","image/detail/allSeries/00_197.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,198,"火炎般的决战_悟空排骨饭谁输赢","image/detail/allSeries/00_198.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,199,"最后的胜利 超速龟派气功波","image/detail/allSeries/00_199.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,200,"七年以后 我是个高中生了","image/detail/allSeries/00_200.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,201,"爱与正义超级赛亚超人登场","image/detail/allSeries/00_201.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,202,"悟饭的首次约会","image/detail/allSeries/00_202.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,203,"悟饭紧急出动 搭救比迪丽","image/detail/allSeries/00_203.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,204,"窃盗事件发生 歹徒是超级赛亚超人","image/detail/allSeries/00_204.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,205,"悟空复活 参加天下第一武道大会","image/detail/allSeries/00_205.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,206,"悟饭都吓了一跳 悟天的爆发力","image/detail/allSeries/00_206.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,207,"飞起来了 比迪丽的舞空术入门","image/detail/allSeries/00_207.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,208,"悟空回来了 老朋友齐聚一堂","image/detail/allSeries/00_208.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,209,"赛亚人危险了 大家小心照相机","image/detail/allSeries/00_209.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,210,"特兰克斯实力坚强","image/detail/allSeries/00_210.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,211,"新世代的对决 悟天对抗特兰克斯","image/detail/allSeries/00_211.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,212,"快乐百分百 少年冠军出炉","image/detail/allSeries/00_212.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,213,"撒旦麻烦了 史上最大的危机","image/detail/allSeries/00_213.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,214,"战斗开始 第一场对决","image/detail/allSeries/00_214.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,215,"比克怎么了 怎么会不战而败呢","image/detail/allSeries/00_215.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,216,"恐怖的不死之身 斯波比奇之谜","image/detail/allSeries/00_216.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,217,"比迪丽狼狈战败 悟饭怒火中烧","image/detail/allSeries/00_217.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,218,"超级赛亚超人的身份终於曝光了","image/detail/allSeries/00_218.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,219,"暗藏的阴谋 悟饭的力量被夺走了","image/detail/allSeries/00_219.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,220,"黑幕登场 邪恶魔法师巴菲迪","image/detail/allSeries/00_220.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,221,"早已设下的陷阱 来自魔界的战书","image/detail/allSeries/00_221.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,222,"少瞧不起人 贝吉塔顺利突破第一战","image/detail/allSeries/00_222.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,223,"悟空展现所有实力 也戈爆炸了","image/detail/allSeries/00_223.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,224,"谁是世界第一高手","image/detail/allSeries/00_224.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,225,"后生可畏 18号陷入苦战","image/detail/allSeries/00_225.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,226,"王者出现 悟饭开始战斗","image/detail/allSeries/00_226.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,227,"魔王与悟饭的激战邪念之心","image/detail/allSeries/00_227.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,228,"破坏王子贝吉塔复活 回返武道大会","image/detail/allSeries/00_228.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,229,"宿命！ 悟空vs贝吉塔！","image/detail/allSeries/00_229.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,230,"等著瞧吧 巴菲迪你的野心不会达成的","image/detail/allSeries/00_230.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,231,"封印解除 邪恶的魔人布欧复活了","image/detail/allSeries/00_231.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,232,"传说中的魔人布欧终於出现了","image/detail/allSeries/00_232.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,233,"魔人布欧真的有那么厉害吗","image/detail/allSeries/00_233.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,234,"恐怖的魔人 悟饭面临死亡的恐惧","image/detail/allSeries/00_234.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,235,"贝吉塔的殊死战","image/detail/allSeries/00_235.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,236,"战士的决心 我会解决魔人布欧","image/detail/allSeries/00_236.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,237,"为了所爱的人 贝吉塔魂飞魄散","image/detail/allSeries/00_237.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,238,"第二次恶梦 魔人布欧还活著","image/detail/allSeries/00_238.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,239,"碧儿等人齐心努力寻找七龙珠","image/detail/allSeries/00_239.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,240,"巨大的希望 小鬼头的新必杀绝技","image/detail/allSeries/00_240.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,241,"向全世界通缉悟天与特兰克斯","image/detail/allSeries/00_241.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,242,"悟饭复活了 界王神的秘密武器","image/detail/allSeries/00_242.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,243,"传说中的界王神剑拔出来了","image/detail/allSeries/00_243.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,244,"西都被攻击了 魔人布欧住手","image/detail/allSeries/00_244.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,245,"悟空惊人的变身 超级赛亚人第三阶","image/detail/allSeries/00_245.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,246,"巴菲迪再见了 魔人布欧的反叛","image/detail/allSeries/00_246.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,247,"奇丑无比的特训变身姿势","image/detail/allSeries/00_247.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,248,"大家再见 悟空回地府去了","image/detail/allSeries/00_248.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,249,"悟饭在哪里_在界王神界上的特训","image/detail/allSeries/00_249.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,250,"不会吧 界王神剑折断了","image/detail/allSeries/00_250.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,251,"合体超人诞生 他的名字是悟天克斯","image/detail/allSeries/00_251.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,252,"最终兵团出动 撒旦要拯救地球","image/detail/allSeries/00_252.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,253,"不杀人了 魔人布欧的乖乖宣言","image/detail/allSeries/00_253.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,254,"撒旦快逃 愤怒的魔人布欧出现了","image/detail/allSeries/00_254.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,255,"谁输谁赢 善恶布欧大对决","image/detail/allSeries/00_255.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,256,"等不及的结局 地球遭到全数消灭","image/detail/allSeries/00_256.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,257,"修练成功 可以开始跟魔人布欧战斗了","image/detail/allSeries/00_257.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,258,"拿出真本事吧 超级悟天克斯火力全开","image/detail/allSeries/00_258.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,259,"太好了 鬼魂成功的打败魔人布欧了","image/detail/allSeries/00_259.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,260,"逃出异次元 超级悟天克斯的第三阶","image/detail/allSeries/00_260.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,261,"得意忘形 布欧版排球","image/detail/allSeries/00_261.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,262,"实在太棒了 新生悟饭重返地球","image/detail/allSeries/00_262.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,263,"压到性的力量 悟饭的力量到底有多少","image/detail/allSeries/00_263.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,264,"太好了，魔人布欧爆炸了","image/detail/allSeries/00_264.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,265,"布欧犯规_悟天克斯被吸收了","image/detail/allSeries/00_265.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,266,"为了宇宙全体_悟空再度复活","image/detail/allSeries/00_266.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,267,"再一次的奇迹_悟空与悟饭合体","image/detail/allSeries/00_267.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,268,"贝吉塔的骄傲_与悟空的愤怒合体了","image/detail/allSeries/00_268.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,269,"强大的力量_贝吉特超越极限","image/detail/allSeries/00_269.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,270,"次元破裂，布欧被切断了","image/detail/allSeries/00_270.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,271,"布欧的绝招，变成弹珠糖","image/detail/allSeries/00_271.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,272,"英雄消失了_贝吉特被吸收了","image/detail/allSeries/00_272.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,273,"魔样的迷宫在布欧肚子里有些什么","image/detail/allSeries/00_273.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,274,"是恶梦是幻境悟空与悟饭父子对决","image/detail/allSeries/00_274.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,275,"魔人的秘密_布欧体内有两个布欧","image/detail/allSeries/00_275.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,276,"出口在何处_逃离布欧崩塌的体内","image/detail/allSeries/00_276.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,277,"地球消灭_邪恶至极的布欧","image/detail/allSeries/00_277.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,278,"布欧来袭_界王神界一决胜负","image/detail/allSeries/00_278.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,279,"为了未来_以宇宙为赌注的决战","image/detail/allSeries/00_279.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,280,"贝吉塔甘拜下风_悟空是宇宙第一","image/detail/allSeries/00_280.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,281,"撑下去，贝吉塔_豁出性命争取一分钟","image/detail/allSeries/00_281.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,282,"不要欺负撒旦_布欧始祖复活了","image/detail/allSeries/00_282.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,283,"贝吉塔的秘密策略_对神龙许的两个愿望","image/detail/allSeries/00_283.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,284,"最后的希望，最大的元气弹","image/detail/allSeries/00_284.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,285,"太感人了_大家的元气弹终于形成了","image/detail/allSeries/00_285.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,286,"最厉害的果然还是孙悟空_布 龙珠与海贼","image/detail/allSeries/00_286.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,287,"恢复和平_正义的使者魔人布欧","image/detail/allSeries/00_287.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,288,"悟空太慢了，大家欢聚一堂","image/detail/allSeries/00_288.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,289,"悟空当爷爷了，我叫做小芳","image/detail/allSeries/00_289.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,290,"我叫欧布，十岁了","image/detail/allSeries/00_290.jpg",NULL,"24:05",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,2,291,"能力不断增强！悟空的梦想无限远大 ！","image/detail/allSeries/00_291.jpg","video/media/00_291.mp4","24:05",DEFAULT,DEFAULT);
#gt
INSERT INTO videoList VALUES(null,3,1,"神秘的龙珠出现 悟空变成了小孩","image/detail/allSeries/02_001.jpg",NULL,"24:02",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,3,2,"我才是主角 BoBo坐上宇宙飞行船","image/detail/allSeries/02_002.jpg",NULL,"24:02",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,3,3,"喜欢钱的伊美加星 商人行","image/detail/allSeries/02_003.jpg",NULL,"24:02",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,3,4,"悟空变了通缉犯","image/detail/allSeries/02_004.jpg",NULL,"24:02",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,3,5,"发现了强敌 保镖莱捷","image/detail/allSeries/02_005.jpg",NULL,"24:02",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,3,6,"有牙痛 悟空做了牙医","image/detail/allSeries/02_006.jpg",NULL,"24:02",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,3,7,"亲爱的甜心 新娘竟然是杜拉格斯","image/detail/allSeries/02_007.jpg",NULL,"24:02",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,3,8,"悟空也吓一跳 胡须超能力全开","image/detail/allSeries/02_008.jpg",NULL,"24:02",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,3,9,"糟糕了 悟空闯入了陷阱星球","image/detail/allSeries/02_009.jpg",NULL,"24:02",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,3,10,"一起来跳舞吧 彭巴巴","image/detail/allSeries/02_010.jpg",NULL,"24:02",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,3,11,"鲁顿的诅咒 变成了娃娃的BoBo","image/detail/allSeries/02_011.jpg",NULL,"24:02",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,3,12,"神的指示是危机 鲁顿开始起动了","image/detail/allSeries/02_012.jpg",NULL,"24:02",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,3,13,"真正的主谋 妙博士","image/detail/allSeries/02_013.jpg",NULL,"24:02",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,3,14,"算准了节拍 鲁顿攻略法","image/detail/allSeries/02_014.jpg",NULL,"24:02",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,3,15,"我要变坏 BoBo离家出走","image/detail/allSeries/02_015.jpg",NULL,"24:02",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,3,16,"机器星球M2 背叛者是机露","image/detail/allSeries/02_016.jpg",NULL,"24:02",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,3,17,"只有靠BoBo了 拯救悟空作战","image/detail/allSeries/02_017.jpg",NULL,"24:02",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,3,18,"资料靠不住 悟空的发挥真正实力","image/detail/allSeries/02_018.jpg",NULL,"24:02",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,3,19,"出马 最强的突变体列顿","image/detail/allSeries/02_019.jpg",NULL,"24:02",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,3,20,"太惊讶了 向悟空袭来的金属液体","image/detail/allSeries/02_020.jpg",NULL,"24:02",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,3,21,"大件事 悟空变成了金属板","image/detail/allSeries/02_021.jpg",NULL,"24:02",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,3,22,"被揭开的野心 邪恶生命体BaBy","image/detail/allSeries/02_022.jpg",NULL,"24:02",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,3,23,"隐藏的危机 遇难船和迷般的少年","image/detail/allSeries/02_023.jpg",NULL,"24:02",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,3,24,"BaBy大反攻 目标是撒亚人","image/detail/allSeries/02_024.jpg",NULL,"24:02",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,3,25,"糟糕了 BaBy在地球上出现了","image/detail/allSeries/02_025.jpg",NULL,"24:02",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,3,26,"悟饭与悟天 最激烈的兄弟之决斗","image/detail/allSeries/02_026.jpg",NULL,"24:02",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,3,27,"愿望达成 比达被上身了","image/detail/allSeries/02_027.jpg",NULL,"24:02",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,3,28,"悟空回来了 地球全部都是敌人","image/detail/allSeries/02_028.jpg",NULL,"24:02",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,3,29,"大事不妙 超级撒亚人三战失败了","image/detail/allSeries/02_029.jpg",NULL,"24:02",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,3,30,"消灭悟空 悟空不要死","image/detail/allSeries/02_030.jpg",NULL,"24:02",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,3,31,"不得了 双六空间崩溃了","image/detail/allSeries/02_031.jpg",NULL,"24:02",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,3,32,"让悟空回去 愤怒的战士欧布","image/detail/allSeries/02_032.jpg",NULL,"24:02",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,3,33,"BaBy受死 新生欧布的必杀射线","image/detail/allSeries/02_033.jpg",NULL,"24:02",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,3,34,"变身失败 悟空变成的大猩猩大暴动","image/detail/allSeries/02_034.jpg",NULL,"24:02",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,3,35,"悟空变化为最强的超级撒亚人四了","image/detail/allSeries/02_035.jpg",NULL,"24:02",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,3,36,"不会死的怪物 凶恶的大猩猩BaBy","image/detail/allSeries/02_036.jpg",NULL,"24:02",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,3,37,"BaBy与悟空双双被击倒了","image/detail/allSeries/02_037.jpg",NULL,"24:02",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,3,38,"用大家的力量 让超级撒亚人四复活","image/detail/allSeries/02_038.jpg",NULL,"24:02",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,3,39,"这是最后的决战 终于消灭BaBy了","image/detail/allSeries/02_039.jpg",NULL,"24:02",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,3,40,"地球爆炸 比克舍身成仁","image/detail/allSeries/02_040.jpg",NULL,"24:02",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,3,41,"天下第一武道大会 撒旦的后继者是谁","image/detail/allSeries/02_041.jpg",NULL,"24:02",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,3,42,"危险啊！悟空 地狱之门被打开了","image/detail/allSeries/02_042.jpg",NULL,"24:02",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,3,43,"地狱的魔战士 斯路同菲利复活了","image/detail/allSeries/02_043.jpg",NULL,"24:02",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,3,44,"终极人造人 两个十七号合体","image/detail/allSeries/02_044.jpg",NULL,"24:02",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,3,45,"悟空 快 离开地狱作战","image/detail/allSeries/02_045.jpg",NULL,"24:02",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,3,46,"超级撒亚人四与超级十七号的激战","image/detail/allSeries/02_046.jpg",NULL,"24:02",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,3,47,"反败为胜 悟空同十八号两段式攻击策略","image/detail/allSeries/02_047.jpg",NULL,"24:02",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,3,48,"怎么会这样 神龙竟然变成敌人了","image/detail/allSeries/02_048.jpg",NULL,"24:02",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,3,49,"最强的敌人 会用恐怖暗招的邪恶龙","image/detail/allSeries/02_049.jpg",NULL,"24:02",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,3,50,"撒亚人力量战败 电击兽五星龙","image/detail/allSeries/02_050.jpg",NULL,"24:02",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,3,51,"六星龙 找出龙卷风攻击的弱点","image/detail/allSeries/02_051.jpg",NULL,"24:02",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,3,52,"BoBo危险 七星龙的绝招","image/detail/allSeries/02_052.jpg",NULL,"24:02",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,3,53,"BoBo消灭了 挥泪的十倍龟波气功","image/detail/allSeries/02_053.jpg",NULL,"24:02",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,3,54,"摄氏六千度的力量 太阳的战士","image/detail/allSeries/02_054.jpg",NULL,"24:02",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,3,55,"荘子展开行动 比达改造计划","image/detail/allSeries/02_055.jpg",NULL,"24:02",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,3,56,"太阳之后是严寒 火与冰兄弟龙","image/detail/allSeries/02_056.jpg",NULL,"24:02",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,3,57,"压倒性的强势 支配邪恶龙的龙","image/detail/allSeries/02_057.jpg",NULL,"24:02",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,3,58,"开始反击 超越超级撒亚人四","image/detail/allSeries/02_058.jpg",NULL,"24:02",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,3,59,"是敌是友 大猩猩比达大暴乱","image/detail/allSeries/02_059.jpg",NULL,"24:02",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,3,60,"融合 终极战士格比达","image/detail/allSeries/02_060.jpg",NULL,"24:02",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,3,61,"我绝对会赢 悟空吃了四星球","image/detail/allSeries/02_061.jpg",NULL,"24:02",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,3,62,"拯救悟空 最后的同伴登场","image/detail/allSeries/02_062.jpg",NULL,"24:02",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,3,63,"奇迹的胜利 悟空拯救地球了","image/detail/allSeries/02_063.jpg",NULL,"24:02",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,3,64,"再见了悟空！ 后会有期","image/detail/allSeries/02_064.jpg",NULL,"24:02",DEFAULT,DEFAULT);
#super
INSERT INTO videoList VALUES(null,4,1,"和平的报酬 1亿元花落谁家?","image/detail/allSeries/03_001.jpg",NULL,"23:22",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,2,"约定的假期 贝吉塔的家庭旅行!?","image/detail/allSeries/03_002.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,3,"梦之续篇将会如何！？ 寻找超级赛亚人之神","image/detail/allSeries/03_003.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,4,"争夺龙珠！比拉夫一伙的阴谋","image/detail/allSeries/03_004.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,5,"界王星的决战！悟空VS破坏神比鲁斯","image/detail/allSeries/03_005.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,6,"不要激怒破坏神！忐忑不安的生日派对","image/detail/allSeries/03_006.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,7,"竟敢冒犯我的布尔玛！贝吉塔一怒之下突然变异","image/detail/allSeries/03_007.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,8,"悟空参见！ 比鲁斯大人给了最后机会！？","image/detail/allSeries/03_008.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,9,"久等了比鲁斯大人 超级赛亚人之神终于诞生","image/detail/allSeries/03_009.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,10,"出招吧悟空！超级赛亚人之神的力量","image/detail/allSeries/03_010.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,11,"继续来吧 比鲁斯大人 神与神的较量","image/detail/allSeries/03_011.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,12,"宇宙变成碎片!?激烈搏斗 破坏神比鲁斯VS超级赛亚人之神","image/detail/allSeries/03_012.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,13,"悟空 超越超级赛亚人之神吧！","image/detail/allSeries/03_013.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,14,"一决胜负！神与神","image/detail/allSeries/03_014.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,15,"勇者撒旦 请创造奇迹吧！来自宇宙的挑战书","image/detail/allSeries/03_015.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,16,"贝吉塔拜师了!?拉拢维斯吧!","image/detail/allSeries/03_016.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,17,"小芳出生！悟空踏上修炼的旅途!?","image/detail/allSeries/03_017.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,18,"我也来啦！开始在比鲁斯星修炼","image/detail/allSeries/03_018.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,19,"绝望再次来袭！恶之帝王弗利萨复活","image/detail/allSeries/03_019.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,20,"来自加克的警告！弗利萨和千人部队紧逼而来","image/detail/allSeries/03_020.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,21,"复仇的开始！弗利萨军恶意袭击悟饭","image/detail/allSeries/03_021.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,22,"换身！出乎意料的复活！名字就叫基纽","image/detail/allSeries/03_022.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,23,"命悬一线的地球和悟饭！快回来吧 孙悟空!!","image/detail/allSeries/03_023.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,24,"弗利萨VS孙悟空的激烈碰撞！","image/detail/allSeries/03_024.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,25,"全力战斗！复仇的黄金弗利萨","image/detail/allSeries/03_025.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,26,"形势危急 突然出现转机！孙悟空开始反击！","image/detail/allSeries/03_026.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,27,"地球爆炸!?龟派气功决胜负","image/detail/allSeries/03_027.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,28,"第六宇宙的破坏神 大名叫象帕","image/detail/allSeries/03_028.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,29,"确定举行格斗比赛！主将是超越悟空的高手","image/detail/allSeries/03_029.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,30,"比赛前的大回顾 剩下两名选手是谁!?","image/detail/allSeries/03_030.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,31,"去找祖诺大人！问出超级龙珠的下落！","image/detail/allSeries/03_031.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,32,"比赛开始了！大家赶赴无名星！","image/detail/allSeries/03_032.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,33,"吃惊吧 第六宇宙！这就是超级赛亚人孙悟空","image/detail/allSeries/03_033.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,34,"比克VS弗罗斯特 全靠魔贯光杀炮啦！","image/detail/allSeries/03_034.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,35,"化愤怒为力量！贝吉塔全力上阵","image/detail/allSeries/03_035.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,36,"出乎意料的艰苦奋战！贝吉塔爆怒！","image/detail/allSeries/03_036.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,37,"贝吉塔VS第六宇宙的赛亚人","image/detail/allSeries/03_037.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,38,"第六宇宙的最强战士！ 杀手希特出场!!","image/detail/allSeries/03_038.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,39,"经过成长的闪时发动反击!?悟空会有新招式吗!?","image/detail/allSeries/03_039.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,40,"终于决出胜负！胜者是比鲁斯还是象帕？","image/detail/allSeries/03_040.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,41,"出来吧 神之龙！实现愿望我要发","image/detail/allSeries/03_041.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,42,"庆功会风波！终于较量了!? 莫纳卡VS孙悟空","image/detail/allSeries/03_042.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,43,"悟空无法控制气息!?手忙脚乱照看小芳","image/detail/allSeries/03_043.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,44,"火上锅星的封印 被释放的“超人水”之秘密！","image/detail/allSeries/03_044.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,45,"贝吉塔消失了？惊人的复制贝吉塔！","image/detail/allSeries/03_045.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,46,"悟空VS复制贝吉塔！ 究竟谁赢!?","image/detail/allSeries/03_046.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,47,"来自未来的SOS！出现黑色新敌人","image/detail/allSeries/03_047.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,48,"希望重新升起!!苏醒于现在吧 特兰克斯","image/detail/allSeries/03_048.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,49,"来自未来的留言 黑悟空来袭！","image/detail/allSeries/03_049.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,50,"悟空VS黑暗人！通往未来的路被封上","image/detail/allSeries/03_050.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,51,"超越时光的心愿 特兰克斯和小舞","image/detail/allSeries/03_051.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,52,"师徒重逢 孙悟饭和“未来”特兰克斯","image/detail/allSeries/03_052.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,53,"揭开黑暗人真面目！飞往第十宇宙的界王神界！","image/detail/allSeries/03_053.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,54,"赛亚人的后代 特兰克斯的决心","image/detail/allSeries/03_054.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,55,"想见孙悟空 来自全王的召唤！","image/detail/allSeries/03_055.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,56,"再战黑悟空！超级赛亚人桃红登场","image/detail/allSeries/03_056.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,57,"拥有不死身的神 扎马斯降临","image/detail/allSeries/03_057.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,58,"扎马斯和黑暗人之谜 疑云重重","image/detail/allSeries/03_058.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,59,"保护界王神格瓦斯 摧毁扎马斯！","image/detail/allSeries/03_059.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,60,"再次去未来 揭开黑悟空的真面目!!","image/detail/allSeries/03_060.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,61,"扎马斯的野心 恐怖的“人类零计划”由何而来","image/detail/allSeries/03_061.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,62,"特兰克斯愤怒之下 超级能量大爆发!!","image/detail/allSeries/03_062.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,63,"别玷污了赛亚人的细胞！贝吉塔的壮烈战斗上演了!!","image/detail/allSeries/03_063.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,64,"膜拜赞美吧！合体扎马斯爆诞!!","image/detail/allSeries/03_064.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,65,"是最后的审判吗!?绝对神的终极力量","image/detail/allSeries/03_065.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,66,"决战！ 顽强的战士们迸发出奇迹之力","image/detail/allSeries/03_066.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,67,"胸怀新的希望 告别特兰克斯","image/detail/allSeries/03_067.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,68,"出来吧神龙！谁的愿望能实现","image/detail/allSeries/03_068.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,69,"悟空VS阿拉蕾！稀奇古怪的战斗将毁灭地球!?","image/detail/allSeries/03_069.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,70,"来自象帕的战书！这次用棒球决胜负!!","image/detail/allSeries/03_070.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,71,"悟空身死！绝对执行的暗杀指令","image/detail/allSeries/03_071.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,72,"能否发出反击!? 看不见的杀人招式!!","image/detail/allSeries/03_072.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,73,"悟饭的灾难!赛亚超人拍成电影了!?","image/detail/allSeries/03_073.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,74,"为了心爱的人!不屈的赛亚超人!!","image/detail/allSeries/03_074.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,75,"悟空和库林 前往昔日修炼之地","image/detail/allSeries/03_075.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,76,"击败强敌 库林再燃斗志","image/detail/allSeries/03_076.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,77,"拜托全王!举办宇宙第一武道会!!","image/detail/allSeries/03_077.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,78,"全宇宙的神都惊呆了!?力量大会输了就得灭亡","image/detail/allSeries/03_078.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,79,"第九宇宙踢腿功巴兹尔VS第七宇宙魔人布欧!!","image/detail/allSeries/03_079.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,80,"唤醒沉睡的斗志!孙悟饭的战斗!!","image/detail/allSeries/03_080.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,81,"粉碎功贝尔盖莫VS孙悟空! 哪一方的实力无限增强!?","image/detail/allSeries/03_081.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,82,"绝不容忍孙悟空! 正义的战士托破闯入比赛","image/detail/allSeries/03_082.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,83,"结成第七宇宙代表队! 最强的十个人是谁!?","image/detail/allSeries/03_083.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,84,"猎头孙悟空 邀请库林和18号参赛","image/detail/allSeries/03_084.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,85,"宇宙开始行动 各自有所图谋","image/detail/allSeries/03_085.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,86,"第一次碰撞的拳头! 人造人17号VS孙悟空!!","image/detail/allSeries/03_086.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,87,"抓住偷猎团! 悟空和17号并肩战斗!!","image/detail/allSeries/03_087.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,88,"悟饭和比克 师徒碰撞的极限修炼!","image/detail/allSeries/03_088.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,89,"来了一位神秘美女! 天津流武馆之怪!?","image/detail/allSeries/03_089.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,90,"直面必须超越的障碍! 悟空VS悟饭","image/detail/allSeries/03_090.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,91,"哪个宇宙能够胜出!?最强战士都来会合!!","image/detail/allSeries/03_091.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,92,"发生紧急事态! 十名成员出现欠缺!!","image/detail/allSeries/03_092.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,93,"第十名战士就是你! 悟空去见弗利萨!!","image/detail/allSeries/03_093.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,94,"恶之帝王复活! 神秘刺客们前来迎接!?","image/detail/allSeries/03_094.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,95,"最凶! 最恶! 弗利萨大闹特闹!!","image/detail/allSeries/03_095.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,96,"时辰已到! 为了宇宙命运奔赴无之界!!","image/detail/allSeries/03_096.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,97,"要活下去! 力量大会终于开幕!!","image/detail/allSeries/03_097.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,98,"如此无常! 绝望的宇宙!!","image/detail/allSeries/03_098.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,99,"尽情展现吧! 库林的潜力!","image/detail/allSeries/03_099.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,100,"失去控制! 觉醒施暴的疯狂战士!!","image/detail/allSeries/03_100.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,101,"正义战士步步紧逼! 迎战骄傲战队!!","image/detail/allSeries/03_101.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,102,"爱的力量大爆发!?第2宇宙的魔女战士!!","image/detail/allSeries/03_102.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,103,"悟饭必须冷酷! 与第十宇宙的决战!","image/detail/allSeries/03_103.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,104,"超绝光速战斗爆发! 悟空与希特的共同战线!!","image/detail/allSeries/03_104.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,105,"奋战! 武天老师燃烧生命!","image/detail/allSeries/03_105.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,106,"定位敌人! 与隐身狙击手殊死搏斗!!","image/detail/allSeries/03_106.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,107,"复仇的F! 精心设计的狡猾陷阱!?","image/detail/allSeries/03_107.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,108,"弗利萨和弗罗斯特! 恶意交织!?","image/detail/allSeries/03_108.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,109,"悟空面对最强劲敌! 发出杀手锏元气弹!","image/detail/allSeries/03_109.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,110,"孙悟空醒来! 觉醒者的新真髓!!","image/detail/allSeries/03_110.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,111,"异次元的极致战斗! 希特VS吉连!!","image/detail/allSeries/03_111.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,112,"赛亚人的誓言! 贝吉塔的决心!!","image/detail/allSeries/03_112.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,113,"赛亚人vs赛亚人！超高速战斗究竟鹿死谁手？","image/detail/allSeries/03_113.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,114,"阴森骇人! 全新超战士爆诞!!","image/detail/allSeries/03_114.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,115,"悟空VS开芙拉! 超级赛亚人蓝色败退!?","image/detail/allSeries/03_115.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,116,"战局即将扭转! 自在极意功大爆发!!","image/detail/allSeries/03_116.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,117,"爱的大决战! 人造人VS第二宇宙!!","image/detail/allSeries/03_117.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,118,"悲剧在加速 宇宙将消失…","image/detail/allSeries/03_118.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,119,"无法躲避!?威猛的隐形攻击!!","image/detail/allSeries/03_119.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,120,"完美的生存战略! 第三宇宙刺客的威胁!!","image/detail/allSeries/03_120.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,121,"全面战争! 终极四人合体VS第七宇宙总攻击!!","image/detail/allSeries/03_121.jpg",NULL,"23:23",DEFAULT,DEFAULT);
INSERT INTO videoList VALUES(null,4,122,"以骄傲为赌注! 贝吉塔挑战最强高手!!","image/detail/allSeries/03_122.jpg",NULL,"23:23",DEFAULT,DEFAULT);

#弹幕
CREATE TABLE barrage(
	bid INT PRIMARY KEY AUTO_INCREMENT,
	videoId INT,
		FOREIGN KEY(videoId) REFERENCES videoList(vid),
	msg VARCHAR(64) NOT NULL,	#弹幕内容
	color VARCHAR(8) NOT NULL,	#弹幕颜色
	speed TINYINT NOT NULL,	#弹幕速度
	top SMALLINT NOT NULL,	#距离顶部距离
	showTime SMALLINT NOT NULL,	#弹出时间(s)
	leftOffset SMALLINT DEFAULT 880
);
INSERT INTO barrage VALUES(null,154,"Hello World","#ffffff",6,60,5,DEFAULT);
INSERT INTO barrage VALUES(null,154,"Hello World","#ffffff",4,40,8,DEFAULT);
