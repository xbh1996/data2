SET NAMES utf8;
DROP DATABASE IF EXISTS dota2;
CREATE DATABASE dota2 CHARSET=UTF8;
USE dota2;
-- -- # 网站的基本信息
-- CREATE TABLE dota2_site_info(
--     sitename VARCHAR(16),
--     logo VARCHAR(64),
--     copyright VARCHAR(64)
-- );

-- #导航条目
-- CREATE TABLE dota2_nav_item(
--     nid  TINYINT PRIMARY KEY AUTO_INCREMENT,
--     title VARCHAR(16),
--     url  VARCHAR(64)
-- );

-- #轮播图
CREATE TABLE dota2_rot_pic(
    rid INT PRIMARY KEY AUTO_INCREMENT,
    pic VARCHAR(128),
    url VARCHAR(128),
    title VARCHAR(32)
);

-- #最新上架饰品
CREATE TABLE dota2_new_product(
    nid INT PRIMARY KEY AUTO_INCREMENT,
    img VARCHAR(128),
    pname VARCHAR(32),
    price DECIMAL(7,2),
    pid INT
);

-- #热门饰品
CREATE TABLE dota2_hot_product(
    hid INT PRIMARY KEY AUTO_INCREMENT,
    img VARCHAR(128),
    pname VARCHAR(32),
    price DECIMAL(7,2),
    number INT,     --#交易数量
    pid INT
);

--# DOTA2英雄家族
CREATE TABLE dota2_heros(
    hid INT PRIMARY KEY AUTO_INCREMENT,
    hname VARCHAR(32),
    hpro  VARCHAR(32), /*英雄属性  智力 力量 敏捷*/
    pic VARCHAR(64)
);

--#所有饰品
CREATE TABLE dota2_product(
    pid INT PRIMARY KEY AUTO_INCREMENT,
    hid INT,    --#所属英雄编号
    pic VARCHAR(32),
    pname VARCHAR(32),  --#商品名称
    qua VARCHAR(32),   --#饰品品质
    slot  VARCHAR(12),  --#槽位
    type  VARCHAR(20),  --#饰品类型
    price  DECIMAL(7,2), --#价格
    is_onsale BOOLEAN    --#是否在售
);
-- #用户信息
CREATE TABLE dota2_user(
  uid INT PRIMARY KEY AUTO_INCREMENT,
  uname VARCHAR(32),
  upwd VARCHAR(32),
  email VARCHAR(64),
  phone VARCHAR(16),
  user_name VARCHAR(32),      --#用户名，如王小明
  gender INT                  --#性别  0-女  1-男
);
/**收货地址信息**/
CREATE TABLE dota2_receiver_address(
  aid INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT,                --#用户编号
  receiver VARCHAR(16),       --#接收人姓名
  province VARCHAR(16),       --#省
  city VARCHAR(16),           --#市
  county VARCHAR(16),         --#县
  address VARCHAR(128),       --#详细地址
  cellphone VARCHAR(16),      --#手机
  fixedphone VARCHAR(16),    -- #固定电话
  postcode CHAR(6),           --#邮编
  tag VARCHAR(16),            --#标签名

  is_default BOOLEAN          --#是否为当前用户的默认收货地址
);
/**购物车条目**/
CREATE TABLE dota2_cart(
  id INT PRIMARY KEY AUTO_INCREMENT,
  pid INT,      --#商品编号
  price DECIMAL(7,2),   --#价格
  pname VARCHAR(64),--#商品名
  count INT,        --#购买数量
  uid INT,          --#用户编号
  pic VARCHAR(255) --#是否已勾选，确定购买
);
/**用户订单**/
CREATE TABLE dota2_order(
  aid INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT,
  address_id INT,
  status INT,            -- #订单状态  1-等待付款  2-等待发货  3-运输中  4-已签收  5-已取消
  order_time BIGINT,     -- #下单时间
  pay_time BIGINT,        --#付款时间
  deliver_time BIGINT,    --#发货时间
  received_time BIGINT    --#签收时间
);
/**用户订单**/
CREATE TABLE dota2_order_detail(
  did INT PRIMARY KEY AUTO_INCREMENT,
  order_id INT,           --#订单编号
  product_id INT,         --#产品编号
  count INT               --#购买数量
);
/*插入数据*/
/*网站信息*/
-- INSERT INTO dota2_site_info VALUES("DOTA2 饰品交易平台","img/logo.png","温馨提示：抵制不良游戏 拒绝盗版游戏 注意自我保护 谨防受骗上当 适度游戏益 沉迷游戏伤身 合理安排时间 享受健康生活");
-- /*导航条目*/
-- INSERT INTO dota2_nav_item VALUES
-- (1,"首页","public/index.html"),
-- (2,"饰品广场","public/acce.html"),
-- (3,"曙光酒馆","public/sgjg.html"),
-- (4,"冰封王座","public/bfwz.html"),
-- (5，"电竞资讯","public/gameinfo.html"),
-- (6,"关于我们","public/aboutus.html");
/*轮播图*/
INSERT INTO dota2_rot_pic VALUES
("1","img/carousel/banner0.png","https://www.dota2.com.cn/international/2019/qualifiers/index","至宝归属，花落谁家"),
("2","img/carousel/banner1.jpg","https://www.dota2.com.cn/international/2019/overview","关注我们，为CN DOTA加油"),
("3","img/carousel/banner2.jpg","https://www.dota2.com.cn/article/details/20190814/207361.html","Welcome to Dead Game"),
("4","img/carousel/banner3.jpg","https://www.dota2.com.cn/article/details/20190820/207761.html","Welcome to Dead Game"),
("5","img/carousel/banner4.jpg","https://pvp.wanmei.com/appdownload-dota2/index.html","Welcome to Dead Game"),
("6","img/carousel/banner5.jpg","https://www.dota2.com.cn/plus/","免费游戏，值得拥有");
/*最新上架*/
INSERT INTO dota2_new_product VALUES
(null,"img/newproduct/001.png","纯正 真神炙剑",'59.00',"1"),
(null,"img/newproduct/002.png","铭刻 纯金月陨",'129.00',"68"),
(null,"img/newproduct/003.png","凌虐之罩",'128.00',"58"),
(null,"img/newproduct/004.png","彼岸材枝",'89.00',"33"),
(null,"img/newproduct/005.png","纯金风暴之诞神令",'128.00',"34"),
(null,"img/newproduct/006.png","守夜丰功",'345.00',"62"),
(null,"img/newproduct/007.png","铭刻 噬魔之王",'135.00',"38"),
(null,"img/newproduct/009.png","铭刻 万世权杖",'1998.00',"39"),
(null,"img/newproduct/10.png","大圣的新游记",'59.00',"40"),
(null,"img/newproduct/11.png","至刚炎铠",'70.00',"41"),
(null,"img/newproduct/12.png","暗黑奇艺披风",'1150.00',"44"),
(null,"img/newproduct/008.png","尊享 魔导师密匙捆绑包",'161.00',"45");
/*热销商品*/
INSERT INTO dota2_hot_product VALUES
(null,"img/hotproduct/h1.png","纯金食腐婪虫",79.48,11,"148"),
(null,"img/hotproduct/h2.png","铭刻 雪女冰川",8.46,5,"47"),
(null,"img/hotproduct/h10.png","铭刻 苦木独苗",4.80,18,"48"),
(null,"img/hotproduct/h11.png","剑心之遗捆绑包",151,52,"49"),
(null,"img/hotproduct/h3.png","破晓之翼",5.00,30,"50"),
(null,"img/hotproduct/h4.png","魔方之谜",2.50,18,"51"),
(null,"img/hotproduct/h5.png","观战：",2.01,88,"52"),
(null,"img/hotproduct/h6.png","2017年不朽宝藏",0.45,255,"53"),
(null,"img/hotproduct/h7.png","金姝之匕",0.02,517,"54"),
(null,"img/hotproduct/h9.png","纯正 小飞龙 ",1.19,28,"55"),
(null,"img/hotproduct/h12.png","尊享 擎天大圣",147.5,1,"56"),
(null,"img/hotproduct/h8.png","新月战刃",1.02,17,"57");
--# DOTA2英雄家族
INSERT INTO dota2_heros VALUES
(1,"斯温","strength",'img/heros/strength/sven_hphover.png'),
(2,"小小","strength",'img/heros/strength/tiny_hphover.png'),
(3,"昆卡","strength",'img/heros/strength/kunkka_hphover.png'),
(4,"兽王","strength",'img/heros/strength/beastmaster_hphover.png'),
(5,"龙骑士","strength",'img/heros/strength/dragon_knight_hphover.png'),
(6,"发条地精","strength",'img/heros/strength/rattletrap_hphover.png'),
(7,"全能骑士","strength",'img/heros/strength/omniknight_hphover.png'),
(8,"哈斯卡","strength",'img/heros/strength/huskar_hphover.png'),
(9,"炼金术士","strength",'img/heros/strength/alchemist_hphover.png'),
(10,"酒仙","strength",'img/heros/strength/brewmaster_hphover.png'),
(11,"树精卫士","strength",'img/heros/strength/treant_hphover.png'),
(12,"艾欧","strength",'img/heros/strength/wisp_hphover.png'),
(13,"半人马战行者","strength",'img/heros/strength/centaur_hphover.png'),
(14,"伐木机","strength",'img/heros/strength/shredder_hphover.png'),
(15,"刚背兽","strength",'img/heros/strength/bristleback_hphover.png'),
(16,"巨牙海民","strength",'img/heros/strength/tusk_hphover.png'),
(17,"上古巨神","strength",'img/heros/strength/elder_titan_hphover.png'),
(18,"军团指挥官","strength",'img/heros/strength/legion_commander_hphover.png'),
(19,"大地之灵","strength",'img/heros/strength/earth_spirit_hphover.png'),
(20,"凤凰","strength",'img/heros/strength/phoenix_hphover.png'),
(21,"玛尔斯","strength",'img/heros/strength/mars_hphover.png'),
(22,"斧王","strength",'img/heros/strength/axe_hphover.png'),
(23,"屠夫","strength",'img/heros/strength/pudge_hphover.png'),
(24,"沙王","strength",'img/heros/strength/sand_king_hphover.png'),
(25,"斯拉达","strength",'img/heros/strength/slardar_hphover.png'),
(26,"潮汐猎人","strength",'img/heros/strength/tidehunter_hphover.png'),
(27,"冥魂大帝","strength",'img/heros/strength/wraith_king_hphover.png'),
(28,"噬魂鬼","strength",'img/heros/strength/life_stealer_hphover.png'),
(29,"暗夜魔王","strength",'img/heros/strength/night_stalker_hphover.png'),
(30,"末日使者","strength",'img/heros/strength/doom_bringer_hphover.png'),
(31,"裂魂人","strength",'img/heros/strength/spirit_breaker_hphover.png'),
(32,"狼人","strength",'img/heros/strength/lycan_hphover.png'),
(33,"混沌骑士","strength",'img/heros/strength/chaos_knight_hphover.png'),
(34,"不朽尸王","strength",'img/heros/strength/undying_hphover.png'),
(35,"马格纳斯","strength",'img/heros/strength/magnataur_hphover.png'),
(36,"亚巴顿","strength",'img/heros/strength/abaddon_hphover.png'),
(37,"孽主","strength",'img/heros/strength/abyssal_underlord_hphover.png'),
(38,"撼地者","strength",'img/heros/strength/earthshaker_hphover.png'),
(null,"敌法师","agility",'img/heros/agility/antimage_hphover.png'),
(null,"卓尔游侠","agility",'img/heros/agility/drow_ranger_hphover.png'),
(null,"主宰","agility",'img/heros/agility/juggernaut_hphover.png'),
(null,"米拉娜","agility",'img/heros/agility/mirana_hphover.png'),
(null,"变体精灵","agility",'img/heros/agility/morphling_hphover.png'),
(null,"幻影长矛手","agility",'img/heros/agility/phantom_lancer_hphover.png'),
(null,"复仇之魂","agility",'img/heros/agility/vengefulspirit_hphover.png'),
(null,"力丸","agility",'img/heros/agility/riki_hphover.png'),
(null,"狙击手","agility",'img/heros/agility/sniper_hphover.png'),
(null,"圣堂刺客","agility",'img/heros/agility/templar_assassin_hphover.png'),
(null,"露娜","agility",'img/heros/agility/luna_hphover.png'),
(null,"赏金猎人","agility",'img/heros/agility/bounty_hunter_hphover.png'),
(null,"熊战士","agility",'img/heros/agility/ursa_hphover.png'),
(null,"矮人直升机","agility",'img/heros/agility/gyrocopter_hphover.png'),
(null,"德鲁伊","agility",'img/heros/agility/lone_druid_hphover.png'),
(null,"娜迦海妖","agility",'img/heros/agility/naga_siren_hphover.png'),
(null,"巨魔战将","agility",'img/heros/agility/troll_warlord_hphover.png'),
(null,"灰烬之灵","agility",'img/heros/agility/ember_spirit_hphover.png'),
(null,"齐天大圣","agility",'img/heros/agility/monkey_king_hphover.png'),
(null,"石鳞剑士","agility",'img/heros/agility/pangolier_hphover.png'),
(null,"血魔","agility",'img/heros/agility/bloodseeker_hphover.png'),
(null,"影魔","agility",'img/heros/agility/nevermore_hphover.png'),
(null,"剧毒术士","agility",'img/heros/agility/venomancer_hphover.png'),
(null,"虚空假面","agility",'img/heros/agility/faceless_void_hphover.png'),
(null,"幻影刺客","agility",'img/heros/agility/phantom_assassin_hphover.png'),
(null,"冥界亚龙","agility",'img/heros/agility/viper_hphover.png'),
(null,"克林克兹","agility",'img/heros/agility/clinkz_hphover.png'),
(null,"育母蜘蛛","agility",'img/heros/agility/broodmother_hphover.png'),
(null,"编织者","agility",'img/heros/agility/weaver_hphover.png'),
(null,"幽鬼","agility",'img/heros/agility/spectre_hphover.png'),
(null,"米波","agility",'img/heros/agility/meepo_hphover.png'),
(null,"司夜刺客","agility",'img/heros/agility/nyx_assassin_hphover.png'),
(null,"斯拉克","agility",'img/heros/agility/slark_hphover.png'),
(null,"美杜莎","agility",'img/heros/agility/medusa_hphover.png'),
(null,"恐怖利刃","agility",'img/heros/agility/terrorblade_hphover.png'),
(null,"天穹守望者","agility",'img/heros/agility/arc_warden_hphover.png'),
(null,"水晶室女","intelligence",'img/heros/intelligence/crystal_maiden_hphover.png'),
(null,"风暴之灵","intelligence",'img/heros/intelligence/storm_spirit_hphover.png'),
(null,"风行者","intelligence",'img/heros/intelligence/windrunner_hphover.png'),
(null,"宙斯","intelligence",'img/heros/intelligence/zuus_hphover.png'),
(null,"莉娜","intelligence",'img/heros/intelligence/lina_hphover.png'),
(null,"暗影萨满","intelligence",'img/heros/intelligence/shadow_shaman_hphover.png'),
(null,"修补匠","intelligence",'img/heros/intelligence/tinker_hphover.png'),
(null,"先知","intelligence",'img/heros/intelligence/furion_hphover.png'),
(null,"魅惑魔女","intelligence",'img/heros/intelligence/enchantress_hphover.png'),
(null,"杰奇诺","intelligence",'img/heros/intelligence/jakiro_hphover.png'),
(null,"帕克","intelligence",'img/heros/intelligence/puck_hphover.png'),
(null,"陈","intelligence",'img/heros/intelligence/chen_hphover.png'),
(null,"沉默术士","intelligence",'img/heros/intelligence/silencer_hphover.png'),
(null,"食人魔魔法师","intelligence",'img/heros/intelligence/ogre_magi_hphover.png'),
(null,"拉比克","intelligence",'img/heros/intelligence/rubick_hphover.png'),
(null,"干扰者","intelligence",'img/heros/intelligence/disruptor_hphover.png'),
(null,"光之守卫","intelligence",'img/heros/intelligence/keeper_of_the_light_hphover.png'),
(null,"天怒法师","intelligence",'img/heros/intelligence/skywrath_mage_hphover.png'),
(null,"神谕者","intelligence",'img/heros/intelligence/oracle_hphover.png'),
(null,"工程师","intelligence",'img/heros/intelligence/techies_hphover.png'),
(null,"邪影芳灵","intelligence",'img/heros/intelligence/dark_willow_hphover.png'),
(null,"祸乱之源","intelligence",'img/heros/intelligence/bane_hphover.png'),
(null,"巫妖","intelligence",'img/heros/intelligence/lich_hphover.png'),
(null,"莱恩","intelligence",'img/heros/intelligence/lion_hphover.png'),
(null,"巫医","intelligence",'img/heros/intelligence/witch_doctor_hphover.png'),
(null,"谜团","intelligence",'img/heros/intelligence/enigma_hphover.png'),
(null,"瘟疫法师","intelligence",'img/heros/intelligence/necrolyte_hphover.png'),
(null,"术士","intelligence",'img/heros/intelligence/warlock_hphover.png'),
(null,"痛苦女王","intelligence",'img/heros/intelligence/queenofpain_hphover.png'),
(null,"死亡先知","intelligence",'img/heros/intelligence/death_prophet_hphover.png'),
(null,"帕格纳","intelligence",'img/heros/intelligence/pugna_hphover.png'),
(null,"戴泽","intelligence",'img/heros/intelligence/dazzle_hphover.png'),
(null,"拉席克","intelligence",'img/heros/intelligence/leshrac_hphover.png'),
(null,"黑暗贤者","intelligence",'img/heros/intelligence/dark_seer_hphover.png'),
(null,"蝙蝠骑士","intelligence",'img/heros/intelligence/batrider_hphover.png'),
(null,"远古冰魄","intelligence",'img/heros/intelligence/ancient_apparition_hphover.png'),
(null,"祈求者","intelligence",'img/heros/intelligence/invoker_hphover.png'),
(null,"陨境神蚀者","intelligence",'img/heros/intelligence/obsidian_destroyer_hphover.png'),
(null,"暗影恶魔","intelligence",'img/heros/intelligence/shadow_demon_hphover.png'),
(null,"维萨吉","intelligence",'img/heros/intelligence/visage_hphover.png'),
(null,"寒冬飞龙","intelligence",'img/heros/intelligence/winter_wyvern_hphover.png'),
(null,"天涯墨客","intelligence",'img/heros/intelligence/grimstroke_hphover.png');
--#所有饰品 0-普通 1-稀有 2-罕见  4-神话 5-不朽 6-传说 7-至宝  8-远古
--#可佩戴 --1   捆绑包--0
INSERT INTO dota2_product VALUES
(null,56,"img/newproduct/001.png","纯正 真神炙剑",5,'武器',1,59.00,1),
(null,23,'img/product/tufu1/lzwg.png','龙爪弯钩','5','武器','1','3220.69',1),
(null,36,'img/product/yabadun1/jwlz.png','绝望笼罩','1','无','1','4.99',1),
(null,32,'img/product/wolf1/yyxsxt.png','铭刻 月夜凶兽形态','4','技能4','1','1',1),
(null,22,'img/product/axe/gzsdp.png','刽子手斗篷','2','护甲','1','0.13',1),
(null,22,'img/product/axe/hszk.png','黑兽战魁','2','无','0','4.25',1),
(null,1,'img/product/sevn/blsyswlr.png','宝蓝圣焰守卫利刃','1','武器','1','0.32',1),
(null,1,'img/product/sevn/blzsjj.png','铭刻 不挠之石巨剑','1','武器','1','0.34',1),
(null,9,'img/product/lianjin/dms.png','铭刻 拉泽尔的迈达斯指套','5','手臂','1','19.89',1),
(null,4,'img/product/shouwang1/qzzy.png','纯正 混沌荒原酋长之鸦','1','技能2','1','4.9',1),
(null,4,'img/product/shouwang1/xbmy.png','西部密友','4','无','0','0.75',1),
(null,9,'img/product/lianjin/hdzr.png','铭刻 重型蝴蝶之刃','1','武器','1','1',1),
(null,5,'img/product/dragon/slzh.png','纯正 神龙之魂','1','武器','1','3.9',1),
(null,5,'img/product/dragon/xhfl.png','猩红飞龙的附魔盔甲套装','1','无','0','4',1),
(null,3,'img/product/kunkka/bjzyz.png','铭刻 变节者眼罩','0','颈部','1','4.88',1),
(null,39,'img/product/difa/cfdz.png','嘲讽：魔法终结于此 ','1','嘲讽','1','4.50',1),
(null,39,'img/product/difa/jxzytz.png','觉醒之遗套装','1','无','0','3.58',1),
(null,9,'img/product/lianjin/ljzs.png','炉甲壮士烟囱','1','肩部','1','5',1),
(null,9,'img/product/lianjin/ljzshb.png','铭刻 炉甲壮士护臂','1','手臂','1','4.7',1),
(null,1,'img/product/sevn/bsjj.png','半神巨剑','1','武器','1','0.51',1),
(null,22,'img/product/axe/emzx.png','恶魔之血头盔','2','头部','1','0.27',1),
(null,22,'img/product/axe/fszf.png','腐蚀之锋','4','武器','1','1.32',1),
(null,5,'img/product/dragon/lztl.png','铭刻 龙之屠戮护肩','1','肩部','1','2.5',1),
(null,5,'img/product/dragon/lztltz.png','龙之屠戮骸骨套装','1','无','0','1.7',1),
(null,5,'img/product/dragon/slzh.png','亲笔签名 神龙之魂','1','武器','1','4',1),
(null,22,'img/product/axe/xzzzz.png','血之追逐者','4','武器','1','4.11',1),
(null,22,'img/product/axe/zszr.png','纯正 斩首之刃','1','武器','1','1.11',1),
(null,39,'img/product/difa/rcxk.png','热忱侠客','4','无','0','13',1),
(null,1,'img/product/sevn/cjzj.png','铭刻 裁决之剑','1','武器','1','1.34',1),
(null,1,'img/product/sevn/drshzs.png','冻人 霜寒之噬','0','武器','1','0.84',1),
(null,1,'img/product/sevn/dwss.png','黩武盔甲大剑','4','武器','1','0.67',1),
(null,1,'img/product/sevn/gyswtj.png','冻人 刚硬守卫腿甲','0','腰带','1','2.17',1),
(null,40,"img/newproduct/004.png","彼岸材枝",5,'武器',1,89.00,1),
(null,76,"img/newproduct/005.png","纯金风暴之诞神令",5,'手臂',1,128.00,1),
(null,1,"img/newproduct/006.png","守夜丰功",5,'武器',1,345.00,1),
(null,22,'img/product/axe/hwss.png','红雾死神套装','1','无','0','3.88',1),
(null,22,'img/product/axe/tylq.png','铭刻 头羊利器','1','无','0','15',1),
(null,60,"img/newproduct/007.png","铭刻 噬魔之王",7,'头部',1,135.00,1),
(null,78,"img/newproduct/009.png","铭刻 万世权杖",5,'武器',1,1998.00,1),
(null,57,"img/newproduct/10.png","大圣的新游记",0,'地图',0,59.00,1),
(null,56,"img/newproduct/11.png","至刚炎铠",5,'肩部',1,70.00,1),
(null,39,'img/product/difa/mkcf.png','铭刻 生还者长发','4','头部','1','400',1),
(null,39,'img/product/difa/mkcf.png','生还者长发','4','头部','1','389',1),
(null,111,"img/newproduct/12.png","暗黑奇艺披风",5,'背部',1,1150.00,1),
(null,89,"img/newproduct/008.png","尊享 魔导师密匙捆绑包",7,'套装',0,161.00,1),
(null,23,"img/hotproduct/h1.png","纯金食腐婪虫",5,'肩部',1,79,1),
(null,75,"img/hotproduct/h2.png","铭刻 雪女冰川",2,'其他',1,8.46,1),
(null,82,"img/hotproduct/h10.png","铭刻 苦木独苗",5,'武器',1,4.80,1),
(null,41,"img/hotproduct/h11.png","剑心之遗捆绑包",7,'头部',0,151,1),
(null,91,"img/hotproduct/h3.png","破晓之翼",5,'坐骑',1,5.00,1),
(null,null,"img/hotproduct/h4.png","魔方之谜",0,'其他',0,2.50,1),
(null,null,"img/hotproduct/h5.png","观战：",0,'其他',0,2.01,1),
(null,null,"img/hotproduct/h6.png","2017年不朽宝藏",5,'其他',0,0.45,1),
(null,46,"img/hotproduct/h7.png","金姝之匕",0,'副手',1,0.02,1),
(null,null,"img/hotproduct/h9.png","纯正 小飞龙 ",6,'信使',0,1.19,1),
(null,57,"img/hotproduct/h12.png","尊享 擎天大圣",7,'头部',0,147.5,1),
(null,49,"img/hotproduct/h8.png","新月战刃",2,'武器',1,1.02,1),
(null,98,"img/newproduct/003.png","凌虐之罩",5,'背部',1,128.00,1),
(null,1,'img/product/sevn/hyzhgcst.png','火焰守卫指挥官的长手套','1','手臂','1','2.34',1),
(null,1,'img/product/sevn/hyzhgjj.png','火焰守卫指挥官的肩甲','1','肩部','1','3.7',1),
(null,1,'img/product/sevn/kbzxhy.png','狂暴之兴护腰','0','腰带','1','3.87',1),
(null,1,'img/product/sevn/syfg.png','守夜丰功','5','武器','1','379',1),
(null,1,'img/product/sevn/tlzk.png','铁龙之铠','1','无','0','4.19',1),
(null,1,'img/product/sevn/tmd.png','铭刻 屠魔刀','1','无','0','2.68',1),
(null,1,'img/product/sevn/wjqs.png','铭刻 稳健前哨','1','武器','1','0.19',1),
(null,1,'img/product/sevn/zhgpf.png','火焰守卫披风','2','背部','1','1.20',1),
(null,1,'img/product/sevn/zyzk.png','亲笔签名 战鹰之盔','4','头部','1','15',1),
(null,49,"img/newproduct/002.png","铭刻 纯金月陨",5,'副手',1,129.00,1),
(null,39,'img/product/difa/shzhj.png','生还者护肩','4','肩部','1','25.9',1),
(null,39,'img/product/difa/shzhw.png','生还者护腕','4','手臂','1','60',1),
(null,39,'img/product/difa/shzyd.png','生还者腰带','4','腰带','1','35',1),
(null,39,'img/product/difa/slxt.png','神龙信徒的誓言','1','无','0','15',1),
(null,39,'img/product/difa/slxtcj.png','亲笔签名 神龙信徒的赤径','1','护甲','1','15',1),
(null,39,'img/product/difa/slxtfs.png','亲笔签名 神龙信徒副手战刃','1','副手','1','15',1),
(null,39,'img/product/difa/slxtmz.png','亲笔签名 神龙信徒面罩','1','头部','1','15',1),
(null,30,'img/product/doom/dzzg.png','顶撞之冠','4','头部','1','15',1),
(null,30,'img/product/doom/fy.png','焚焰','1','武器','1','0.8',1),
(null,30,'img/product/doom/hzkwjr.png','魂之渴望巨刃','2','武器','1','1',1),
(null,30,'img/product/doom/mjzj.png','吉祥 冥棘之剑','2','武器','1','4',1),
(null,30,'img/product/doom/mrsp.png','铭刻 末日审判','1','武器','1','0.9',1),
(null,30,'img/product/doom/mscw.png','魔嗣长尾','4','尾巴','1','2.25',1),
(null,30,'img/product/doom/mshw.png','魔嗣护腕','4','手臂','1','2.8',1),
(null,30,'img/product/doom/mszhtz.png','灭世之火套装','1','无','0','1.9',1),
(null,30,'img/product/doom/mzss.png','铭刻 魔咒杀手','4','武器','1','1.7',1),
(null,30,'img/product/doom/syczz.png','十一重诅咒之负套装','1','无','0','1',1),
(null,30,'img/product/doom/ysmh.png','永世魔火','1','无','0','4.5',1),
(null,30,'img/product/doom/znsy.png','铭刻 迫近罪孽双翼','1','背部','1','6.6',1),
(null,30,'img/product/doom/zntk.png','凶煞 迫近罪孽头盔','2','头部','1','4',1),
(null,5,'img/product/dragon/fstk.png','纯正 飞升头盔','1','头部','1','2.9',1),
(null,5,'img/product/dragon/glzg.png','古龙之冠长剑','4','武器','1','1.29',1),
(null,5,'img/product/dragon/hyzy.png','寒翼之遗战盔','1','头部','1','3.4',1),
(null,5,'img/product/dragon/hyzyhd.png','寒翼之遗护盾','1','头部','1','3.15',1),
(null,5,'img/product/dragon/hyzyzr.png','寒翼之遗战刃','1','武器','1','2.6',1),
(null,5,'img/product/dragon/ljzs.png','灰烬之舌','1','武器','1','3',1),
(null,5,'img/product/dragon/lxhs.png','纯正 龙血护手','2','手臂','1','4.5',1),
(null,5,'img/product/dragon/lxjlz.png','龙血劫掠者','1','武器','1','3.7',1),

(null,3,'img/product/kunkka/cyja.png','铭刻 船员的骄傲','0','头部','1','2.38',1),
(null,3,'img/product/kunkka/fzcd.png','铭刻 反转刺刀','5','武器','1','33',1),
(null,3,'img/product/kunkka/hjtk.png','凶煞 铁帆海军的头盔','1','头部','1','3.09',1),
(null,3,'img/product/kunkka/hysd.png','海翼神刀','4','武器','1','1.86',1),
(null,3,'img/product/kunkka/hyss.png','铭刻 准将的海妖杀手','1','武器','1','2.2',1),
(null,3,'img/product/kunkka/sjldzm.png','铭刻 上将的掠夺之帽','0','头部','1','3.98',1),
(null,3,'img/product/kunkka/slzdy.png','流冰私掠者大衣','1','肩部','1','1.34',1),
(null,3,'img/product/kunkka/smqx.png','圣锚气旋波粉碎者','6','武器','1','3.98',1),
(null,3,'img/product/kunkka/smxz.png','铭刻 圣锚勋章','4','颈部','1','2.57',1),
(null,3,'img/product/kunkka/smyl.png','圣锚衣领','2','背部','1','3.55',1),
(null,3,'img/product/kunkka/smzf.png','圣锚之发','2','头部','1','2.55',1),
(null,3,'img/product/kunkka/zwws.png','逐巫武士长剑','2','武器','1','2.45',1),
(null,9,'img/product/lianjin/axx.png','爱心熊','4','肩部','1','0.1',1),
(null,9,'img/product/lianjin/bbtz.png','强酸之袭铠甲套装','1','武器','0','1.2',1),
(null,9,'img/product/lianjin/bwdsp.png','铭刻 实验家的不稳定烧瓶','0','武器','1','15',1),
(null,9,'img/product/lianjin/dmdf.png','纯正 高高头大大马短斧','1','武器','1','4.1',1),

(null,9,'img/product/lianjin/qfzh.png','吉祥 囚犯之踝 ','4','护甲','1','1.5',1),
(null,9,'img/product/lianjin/qszx.png','龙炎合金围裙','0','背部','1','0.2',1),
(null,9,'img/product/lianjin/sljs.png','纯正 碎裂枷锁','4','手臂','1','1.75',1),
(null,37,'img/product/niezhu/syzk.png','深渊灾劫战盔','4','头部','1','1.1',1),
(null,37,'img/product/niezhu/xhby.png','猩红碧玉之慑','5','武器','1','2590',1),
(null,37,'img/product/niezhu/zr.png','深渊灾劫战刃','4','武器','1','0.15',1),
(null,4,'img/product/shouwang1/cslztz.png','赤色利爪猎人套装','1','无','0','0.7',1),
(null,4,'img/product/shouwang1/dbs.png','刀背兽','1','召唤单位','1','5.05',1),
(null,4,'img/product/shouwang1/dlss.png','丹林神兽','4','召唤单位','1','2.6',1),
(null,4,'img/product/shouwang1/gypxz.png','混沌荒原之斧','2','武器','1','0.4',1),
(null,4,'img/product/shouwang1/hdhyyd.png','混沌荒原腰带','2','腰带','1','0.25',1),
(null,4,'img/product/shouwang1/hdhyzf.png','刚毅咆哮者战斧','1','武器','1','0.2',1),
(null,4,'img/product/shouwang1/hyjlz.png','混沌荒原劫掠者','2','万','0','3.5',1),
(null,4,'img/product/shouwang1/hyzk.png','混沌荒原战盔','2','头部','1','0.2',1),
(null,4,'img/product/shouwang1/hyzq.png','混沌荒原战犬','2','召唤单位','1','0.08',1),
(null,4,'img/product/shouwang1/klktz.png','卡洛克风俗套装','2','无','0','0.75',1),
(null,4,'img/product/shouwang1/qly.png','铭刻 千里眼','4','技能2','1','0.15',1),
(null,2,'img/product/tiny1/byzytb.png','铭刻 冰元之注头部','1','头部','1','0.96',1),
(null,2,'img/product/tiny1/hcys.png','火成英石','1','无','0','13',1),
(null,2,'img/product/tiny1/hcysyb.png','火成英石右臂 ','2','副手','1','1.35',1),
(null,2,'img/product/tiny1/hcyszg.png','铭刻 火成英石之棍','1','武器','1','2.85',1),
(null,2,'img/product/tiny1/hcyszs.png','火成英石之身','0','护甲','1','1.87',1),
(null,2,'img/product/tiny1/xhzs.png','鲜红橡树','1','武器','1','1.85',1),
(null,2,'img/product/tiny1/xhzsdg.png','鲜红之石顶冠','2','头部','1','0.59',1),
(null,2,'img/product/tiny1/xhzsqt.png','铭刻 鲜红之石躯体','0','护甲','1','0.75',1),
(null,2,'img/product/tiny1/xhzsqtou.png','鲜红之石拳头','0','副手','1','0.6',1),
(null,2,'img/product/tiny1/xhzssb.png','鲜红之石手臂','0','手臂','1','0.59',1),
(null,23,'img/product/tufu1/gzmj.png','钢豚面容','1','头部','1','0.98',1),
(null,23,'img/product/tufu1/hssflc.png','食腐婪虫','5','肩部','1','7.8',1),
(null,23,'img/product/tufu1/hxkl.png','海象狂猎','4','无','0','12',1),
(null,23,'img/product/tufu1/hxklhs.png','海象狂猎护首','4','头部','1','4.99',1),
(null,23,'img/product/tufu1/lsqb.png','力士七兵','1','无','0','5.29',1),
(null,23,'img/product/tufu1/ltstz.png','老屠手套装 ','1','无','0','1.22',1),
(null,23,'img/product/tufu1/plszf.png','捕猎手之缚','1','无','0','3.9',1),
(null,23,'img/product/tufu1/rgkmmj.png','肉钩狂魔面具','4','头部','1','4',1),
(null,23,'img/product/tufu1/sflc.png','纯金食腐婪虫','5','肩部','1','79.48',1),
(null,23,'img/product/tufu1/tfzhzf.png','屠夫之痕战斧','2','武器','1','0.8',1),
(null,23,'img/product/tufu1/wjgj.png','无尽骨锯','1','副手','1','95',1),
(null,23,'img/product/tufu1/wsys.png','瘟神勇士护腕','2','手臂','1','20',1),
(null,23,'img/product/tufu1/wsystz.png','瘟神勇士','2','无','0','2.69',1),
(null,23,'img/product/tufu1/zhhw.png','纯正 瘟神勇士的灾祸护腕','1','手臂','1','4.02',1),
(null,32,'img/product/wolf1/abljk.png','安布里肩铠','1','肩部','1','3',1),
(null,32,'img/product/wolf1/bcchlq.png','铭刻 冰川残骸狼群','1','召唤单位','1','1',1),
(null,32,'img/product/wolf1/sjlrhs.png','弑君猎人化身','0','肩部','1','0.4',1),
(null,32,'img/product/wolf1/wjem.png','王君噩梦','4','技能4','1','0.3',1),
(null,32,'img/product/wolf1/xhyyyz.png','血红圆月眼罩','4','头部','1','0.05',1),
(null,32,'img/product/wolf1/xjlrzz.png','弑君猎人诅咒','1','头部','1','0.35',1),
(null,32,'img/product/wolf1/xszj.png','新生之季异兽','1','技能4','1','0.2',1),
(null,32,'img/product/wolf1/xylz.png','血月利爪','4','武器','1','140',1),
(null,32,'img/product/wolf1/yhylhj.png','银灰幽灵护甲','1','护甲','1','1',1),
(null,32,'img/product/wolf1/yhyljk.png','银灰幽灵肩铠','1','肩部','1','2.99',1),
(null,32,'img/product/wolf1/yllz.png','银灰幽灵利爪 ','1','武器','1','1.7',1),
(null,32,'img/product/wolf1/yyyz.png','铭刻 血红圆月眼罩','4','头部','1','0.9',1),
(null,36,'img/product/yabadun1/350x234.png','暗黑徜徉者之铠套装','1','无','0','1.93',1),
(null,36,'img/product/yabadun1/bmsw.png','薄暮守卫头盔 ','2','头部','1','3.79',1),
(null,36,'img/product/yabadun1/fd.png','亡溺之骑斧盾','1','武器','1','0.05',1),
(null,36,'img/product/yabadun1/gfxm.png','铭刻 鬼风邪魔战盔','1','头部','1','0.78',1),
(null,36,'img/product/yabadun1/haxj.png','吉祥 黑暗星辰','2','武器','1','0.86',1),
(null,36,'img/product/yabadun1/hj.png','铭刻 婪心骑士护肩','0','肩部','1','0.06',1),
(null,36,'img/product/yabadun1/hyml.png','铭刻 幻影魔镰','4','武器','1','0.58',1),
(null,36,'img/product/yabadun1/mwhg.png','迷雾寒光','2','武器','1','0.04',1),
(null,36,'img/product/yabadun1/mytj.png','魔裔头巾','0','头部','1','0.22',1),
(null,36,'img/product/yabadun1/sxzg.png','圣选之棍','5','武器','1','29.9',1),
(null,36,'img/product/yabadun1/ylpf.png','吉祥 怨灵披风','0','背部','1','4.29',1),
(null,36,'img/product/yabadun1/zkmj.png','冻人 中空魔剑','1','武器','1','2.99',1),
(null,36,'img/product/yabadun1/zq.png','铭刻 婪心骑士坐骑','1','坐骑','1','0.07',1),
(null,36,'img/product/yabadun1/zq1.png','铭刻 特典 婪心骑士坐骑','1','坐骑','1','0.06',1),
(null,36,'img/product/yabadun1/zq2.png','迷雾之怨','1','坐骑','1','0.04',1),
(null,36,'img/product/yabadun1/zq3.png','特典 婪心骑士坐骑','1','坐骑','1','0.04',1);
-- #用户信息
INSERT INTO dota2_user VALUES
(1,'YYF','123456','yyfbussiness@163.com','13525648565','姜岑',1),
(null,'ZIPPO宝哥','123456','zippobussiness@163.com','18121526541','周雄',1),
(null,'coldsama','123456','coldbussiness@163.com','13562547485','冷冷',0),
(null,'AXX','123456','axxbussiness@163.com','15236985421','毕夏',0),
(null,'zhou','123456','zhoubussiness@163.com','18254235246','陈尧',1);
























