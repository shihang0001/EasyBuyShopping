--�û���t_user
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

--��Ʒ����t_product_category(���������С��𣬱���ʳƷ(�����)��ʳƷ�еķ�����(С���))
CREATE TABLE t_product_category(
id NUMBER(9),
name VARCHAR2(30) CONSTRAINT t_product_category_nn NOT NULL,
parent_id NUMBER(9),
CONSTRAINT t_product_category_id_pk PRIMARY KEY(id),
CONSTRAINT t_product_category_name_uk UNIQUE(name),
CONSTRAINT t_pro_cate_parent_id_fk FOREIGN KEY(parent_id) REFERENCES t_product_category(id)
);

--1.�봴����Ʒ��,�ֱ���û��������Ʒ���һ���Ĳ�������(����䱣���,���浽�ű���)
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
--����û�
INSERT INTO t_user VALUEs(1,'Anny','123456','Anny@163.com',13635428865,'�Ϻ��л��������·5��');
INSERT INTO t_user VALUEs(2,'Vector','123789','Vector@163.com',13635424356,'�Ϻ��л��������·6��');
INSERT INTO t_user VALUEs(3,'Tom','456789','Vector@163.com',13635429944,'�Ϻ��л��������·3��');
INSERT INTO t_user VALUEs(4,'Jame','145679','Jame@163.com',13635425664,'');
INSERT INTO t_user VALUEs(5,'Oscar','987655','Oscar@163.com',13635425524,'�Ϻ��л��������·1��');

--������
INSERT INTO t_product_category VALUES(1,'ͼ��',1);
INSERT INTO t_product_category VALUES(2,'��ѧ�������鼮',1);
INSERT INTO t_product_category VALUES(3,'�������鼮',1);
INSERT INTO t_product_category VALUES(4,'ʳƷ',4);
INSERT INTO t_product_category VALUES(5,'����',4);
INSERT INTO t_product_category VALUES(6,'��ʳƷ',4);
INSERT INTO t_product_category VALUES(7,'�ٻ�',7);
INSERT INTO t_product_category VALUES(8,'�Ҿ�',7);
INSERT INTO t_product_category VALUES(9,'����',7);
--�����Ʒ
INSERT INTO t_product VALUES(1,'java���ľ�','��Java��������Ӱ�����ͼ�ֵ�ĵ�����֮һ',119.00,3,1,2);
INSERT INTO t_product VALUES(2,'��ʱ�䵱������','��һ��ʱ�������鼮',59.00,10,1,3);
INSERT INTO t_product VALUES(3,'����','�����������ۣ�Ӫ���ḻ',15.00,100,4,5);
INSERT INTO t_product VALUES(4,'�ɿ�������','���������ζ��',10.00,10,4,6);
INSERT INTO t_product VALUES(5,'���Ƶ緹��','����ҵ�ζ��',299.00,3,7,8);
INSERT INTO t_product VALUES(6,'vivox7','������ѡ��',2229.00,10,7,9);
INSERT INTO t_product VALUES(7,'�����±���','�������ζ��',4.00,20,4,6);
INSERT INTO t_product VALUES(8,'��ʦ��ţ����','����',3.50,25,4,6);
INSERT INTO t_product VALUES(9,'�㹽������','������ζ��',4.50,17,4,6);
INSERT INTO t_product VALUES(10,'��̳�����','����Ҫ��ˬ',5.50,30,4,6);
--2.��ѯÿһ���û���������Ϣ.
SELECT * FROM T_USER;

--3.��ӡ��ÿһ����Ʒ��,���ۼ����,��ʽҪ������:��Ʒ��:***,����:***,���:***
SELECT name "��Ʒ����",price "���ۣ�",stock "��棺"
FROM T_PRODUCT;

--4.��ѯÿһ���û���������Ϣ,�����ַΪ��,����ʾΪ��δ��д
SELECT id,name,password,email,mobile,NVL(address ,'��δ��д')
FROM T_USER;

--5.��ѯ���е��۴���5����Ʒ��,�۸�
SELECT name,price
FROM T_PRODUCT
WHERE price>5;

--6.��ѯ�����2��10֮��(����2,10)��������Ʒ��,���
SELECT name,stock
FROM T_PRODUCT
WHERE STOCK BETWEEN 2 AND 10;

--7.��ѯ���е���Ʒ��,�۸�,�����ռ۸���������
SELECT name,price
FROM T_PRODUCT
ORDER BY price ASC;




--��������ҵ�Ļ�����(Day4):
--����������,������ϸ��,�ο��ᴩ1_������ο�.txt�ĵ�����
--������Ĵ���
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
--������ϸ��Ĵ���
CREATE TABLE t_order_detail(
id NUMBER(9),
o_id NUMBER(9),
p_id NUMBER(9),
quantity NUMBER(9),
CONSTRAINT t_order_detail_id_pk PRIMARY KEY(id),
CONSTRAINT t_order_detail_o_id_fk FOREIGN KEY(o_id) REFERENCES t_order(id),
CONSTRAINT t_order_detail_p_id_fk FOREIGN KEY(p_id) REFERENCES t_product(id)
);

--1.��ֱ��������������ϸ���һ��������
--��Ӷ���
INSERT INTO  t_order(id,u_id,u_name,u_address,create_time,cost,status) 
select 1,u.id,u.NAME,u.ADDRESS,sysdate,p.price,'���'
from t_user u,t_product p
WHERE u.id=1;

INSERT INTO  t_order(id,u_id,u_name,u_address,create_time,cost,status) 
select 2,u.id,u.NAME,u.ADDRESS,sysdate,p.price,'����'
from t_user u,t_product p
WHERE u.id=2;

--��Ӷ�����ϸ
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

--2.��ѯ���а�����ĸo���û�����Ϣ
SELECT *
FROM t_user u
WHERE u.name LIKE '%o%';

--3.��ѯ���а�����ĸo(�����ִ�Сд)���û�����Ϣ
SELECT *
FROM t_user u
WHERE LOWER(u.name) LIKE '%o%';

--4.��ѯ���е�����10~50������10��50��֮���������Ʒ��Ϣ
SELECT *
FROM t_product p
WHERE p.price BETWEEN 10 AND 50;

--5.��ѯ���еķ�������Ϣ,���ռ۸���������
SELECT *
FROM t_product p
WHERE p.name LIKE '%��%'
ORDER BY p.price;

--6.���ռ۸�ӵ͵���������е���Ʒ��Ϣ
SELECT *
FROM t_product p
ORDER BY p.price;

--7.�����С���idΪ1�����е���Ʒ��Ϣ
SELECT *
FROM t_product p
WHERE p.CATE_CHILD_ID=2;
--ע�����idΪ1���Ǵ����

--8.�������2017��1��1�����������ж����������ն������ڽ������
SELECT *
FROM t_order o
WHERE o.create_time BETWEEN '01-1��-17'AND SYSDATE
ORDER  BY o.create_time;

--9.�����2016��12�·ݵ����ж�����Ϣ
SELECT *
FROM t_order o
WHERE o.create_time BETWEEN '01-12��-16' AND '31-12��-16'
ORDER  BY o.create_time;

--10.��������һ�������������ж�����Ϣ
SELECT *
FROM t_order o
WHERE o.create_time BETWEEN (SYSDATE-30) AND SYSDATE
ORDER  BY o.create_time;

--11.��ʾÿһ����Ʒ������,����С��������
SELECT p.name "��Ʒ����",pc.name "С�������"
FROM t_product p,t_product_category pc
WHERE p.CATE_CHILD_ID=pc.id;

--12.��ѯÿ�������Ʒ������,���������������
SELECT pc.name "�������",COUNT(*)
FROM t_product p,t_product_category pc
WHERE p.CATE_ID=pc.id
GROUP BY pc.name;

