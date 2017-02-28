--用户表：t_user
CREATE TABLE t_user(
id NUMBER(9),
name VARCHAR2(40) CONSTRAINT t_user_name_nn NOT NULL,
password VARCHAR2(30) CONSTRAINT t_uder_password_nn NOT NULL,
email VARCHAR2(50),
mobile VARCHAR2(12),
address VARCHAR2(50),
CONSTRAINT t_user_id_pk PRIMARY KEY(id),
CONSTRAINT t_user_name_uk UNIQUE(name)
);

--商品类别表：t_product_category(包括大类别，小类别，比如食品(大类别)，食品中的方便面(小类别))
CREATE TABLE t_product_category(
id NUMBER(9),
name VARCHAR2(30) CONSTRAINT t_product_category_nn NOT NULL,
parent_id NUMBER(9),
CONSTRAINT t_product_category_id_pk PRIMARY KEY(id),
CONSTRAINT t_product_category_name_uk UNIQUE(name),
CONSTRAINT t_pro_cate_parent_id_fk FOREIGN KEY(parent_id) REFERENCES t_product_category(id)
);

--1.请创建商品表,分别给用户、类别、商品添加一定的测试数据(把语句保存好,保存到脚本中)
create table t_product(
id NUMBER(9) CONSTRAINT t_product_id_pk PRIMARY KEY,
name VARCHAR2(40) CONSTRAINT t_product_name_nn NOT NULL,
description VARCHAR2(100),
price NUMBER(9,2) CONSTRAINT t_product_price_nn NOT NULL,
stock NUMBER(10) DEFAULT 0,
cate_id NUMBER(9),
cate_child_id NUMBER(9),
CONSTRAINT t_product_cate_id_fk FOREIGN KEY(cate_id) REFERENCES t_product_category(id),
CONSTRAINT t_pro_cate_child_id_fk FOREIGN KEY(cate_child_id) REFERENCES t_product_category(id)
);
--添加用户
INSERT INTO t_user VALUEs(1,'Anny','123456','Anny@163.com',13635428865,'上海市黄浦区天津路5号');
INSERT INTO t_user VALUEs(2,'Vector','123789','Vector@163.com',13635424356,'上海市黄浦区天津路6号');
INSERT INTO t_user VALUEs(3,'Tom','456789','Vector@163.com',13635429944,'上海市黄浦区天津路3号');
INSERT INTO t_user VALUEs(4,'Jame','145679','Jame@163.com',13635425664,'');
INSERT INTO t_user VALUEs(5,'Oscar','987655','Oscar@163.com',13635425524,'上海市黄浦区天津路1号');

--添加类别
INSERT INTO t_product_category VALUES(1,'图书',1);
INSERT INTO t_product_category VALUES(2,'科学技术类书籍',1);
INSERT INTO t_product_category VALUES(3,'人文类书籍',1);
INSERT INTO t_product_category VALUES(4,'食品',4);
INSERT INTO t_product_category VALUES(5,'生鲜',4);
INSERT INTO t_product_category VALUES(6,'膨化食品',4);
INSERT INTO t_product_category VALUES(7,'百货',7);
INSERT INTO t_product_category VALUES(8,'家居',7);
INSERT INTO t_product_category VALUES(9,'数码',7);
--添加商品
INSERT INTO t_product VALUES(1,'java核心卷','是Java领域最有影响力和价值的的著作之一',119.00,3,1,2);
INSERT INTO t_product VALUES(2,'把时间当做朋友','是一本时间管理的书籍',59.00,10,1,3);
INSERT INTO t_product VALUES(3,'鲢鱼','鲢鱼肉质鲜嫩，营养丰富',15.00,100,4,5);
INSERT INTO t_product VALUES(4,'巧克力蛋糕','充满甜甜的味道',10.00,10,4,6);
INSERT INTO t_product VALUES(5,'虎牌电饭煲','煮出家的味道',299.00,3,7,8);
INSERT INTO t_product VALUES(6,'vivox7','你的最好选择',2229.00,10,7,9);
INSERT INTO t_product VALUES(7,'奥利奥饼干','就是这个味道',4.00,20,4,6);
INSERT INTO t_product VALUES(8,'康师傅牛肉面','肉多多',3.50,25,4,6);
INSERT INTO t_product VALUES(9,'香菇炖鸡面','鸡汤的味道',4.50,17,4,6);
INSERT INTO t_product VALUES(10,'老坛酸菜面','就是要酸爽',5.50,30,4,6);
--2.查询每一个用户的所有信息.
SELECT * FROM T_USER;

--3.打印出每一个商品名,单价及库存,格式要求如下:商品名:***,单价:***,库存:***
SELECT name "商品名：",price "单价：",stock "库存："
FROM T_PRODUCT;

--4.查询每一个用户的所有信息,如果地址为空,则显示为暂未填写
SELECT id,name,password,email,mobile,NVL(address ,'暂未填写')
FROM T_USER;

--5.查询所有单价大于5的商品名,价格
SELECT name,price
FROM T_PRODUCT
WHERE price>5;

--6.查询库存在2到10之间(包括2,10)的所有商品名,库存
SELECT name,stock
FROM T_PRODUCT
WHERE STOCK BETWEEN 2 AND 10;

--7.查询所有的商品名,价格,并按照价格升序排序
SELECT name,price
FROM T_PRODUCT
ORDER BY price ASC;




--在昨天作业的基础上(Day4):
--创建订单表,订单明细表,参考贯穿1_创建表参考.txt文档创建
--订单表的创建
CREATE TABLE t_order(
id NUMBER(9),
u_id NUMBER(9),
u_name VARCHAR2(40),
u_address VARCHAR2(50),
create_time DATE DEFAULT SYSDATE,
cost NUMBER(9) DEFAULT 0,
status VARCHAR2(10) CONSTRAINT t_order_status_nn NOT NULL,
CONSTRAINT t_order_id_pk PRIMARY KEY(id),
CONSTRAINT t_order_u_id_fk FOREIGN KEY(u_id) REFERENCES t_user(id)
--CONSTRAINT t_order_u_name_fk  REFERENCES t_order(u_id),
--CONSTRAINT t_order_u_address_fk  REFERENCES t_order(u_id)
);
--订单明细表的创建
CREATE TABLE t_order_detail(
id NUMBER(9),
o_id NUMBER(9),
p_id NUMBER(9),
quantity NUMBER(9),
CONSTRAINT t_order_detail_id_pk PRIMARY KEY(id),
CONSTRAINT t_order_detail_o_id_fk FOREIGN KEY(o_id) REFERENCES t_order(id),
CONSTRAINT t_order_detail_p_id_fk FOREIGN KEY(p_id) REFERENCES t_product(id)
);

--1.请分别给订单、订单明细添加一定的数据
--添加订单
INSERT INTO  t_order(id,u_id,u_name,u_address,create_time,cost,status) 
select 1,u.id,u.NAME,u.ADDRESS,sysdate,p.price,'正在配货'
from t_user u,t_product p
WHERE u.id=1;
INSERT INTO  t_order(id,u_id,u_name,u_address,create_time,cost,status) 
select 2,u.id,u.NAME,u.ADDRESS,sysdate,p.price,'正在发送'
from t_user u,t_product p
WHERE u.id=2;

--添加订单明细
INSERT INTO  t_order_detail(id,o_id,p_id,quantity) 
select 1,o.id,p.id,3
from t_order o,t_product p,t_order_detail od
WHERE o.id=1 AND p.id=1;

INSERT INTO  t_order_detail(id,o_id,p_id,quantity) 
select 2,o.id,p.id,1
from t_order o,t_product p,t_order_detail od
WHERE o.id=2 AND p.id=1;

INSERT INTO  t_order_detail(id,o_id,p_id,quantity) 
select 3,o.id,p.id,2
from t_order o,t_product p,t_order_detail od
WHERE o.id=3 AND p.id=1;

INSERT INTO  t_order_detail(id,o_id,p_id,quantity) 
select 4,o.id,p.id,1
from t_order o,t_product p,t_order_detail od
WHERE o.id=2 AND p.id=2;

--2.查询所有包含字母o的用户的信息
SELECT *
FROM t_user u
WHERE u.name LIKE '%o%';

--3.查询所有包含字母o(不区分大小写)的用户的信息
SELECT *
FROM t_user u
WHERE LOWER(u.name) LIKE '%o%';

--4.查询所有单价在10~50（包含10和50）之间的所有商品信息
SELECT *
FROM t_product p
WHERE p.price BETWEEN 10 AND 50;

--5.查询所有的方便面信息,按照价格升序排序
SELECT *
FROM t_product p
WHERE p.name LIKE '%面%'
ORDER BY p.price;

--6.按照价格从低到高输出所有的商品信息
SELECT *
FROM t_product p
ORDER BY p.price;

--7.请输出小类别id为1的所有的商品信息
SELECT *
FROM t_product p
WHERE p.CATE_CHILD_ID=2;
--注：类别id为1的是大类别

--8.请输出在2017年1月1日以来的所有订单，并按照订单日期降序输出
SELECT *
FROM t_order o
WHERE o.create_time BETWEEN '01-1月-17'AND SYSDATE
ORDER  BY o.create_time;

--9.请输出2016年12月份的所有订单信息
SELECT *
FROM t_order o
WHERE o.create_time BETWEEN '01-12月-16' AND '31-12月-16'
ORDER  BY o.create_time;

--10.请输出最近一个月以来的所有订单信息
SELECT *
FROM t_order o
WHERE o.create_time BETWEEN (SYSDATE-30) AND SYSDATE
ORDER  BY o.create_time;

--11.显示每一个商品的名称,及其小类别的名称
SELECT p.name "商品名称",pc.name "小类别名称"
FROM t_product p,t_product_category pc
WHERE p.CATE_CHILD_ID=pc.id;

--12.查询每个类别商品的数量,按照数量降序输出
SELECT pc.name "类别名称",COUNT(*)
FROM t_product p,t_product_category pc
WHERE p.CATE_ID=pc.id
GROUP BY pc.name;

