
/* Drop Tables */

DROP TABLE reservation CASCADE CONSTRAINTS;
DROP TABLE pet CASCADE CONSTRAINTS;
DROP TABLE review CASCADE CONSTRAINTS;
DROP TABLE selldata CASCADE CONSTRAINTS;
DROP TABLE customer CASCADE CONSTRAINTS;
DROP TABLE product CASCADE CONSTRAINTS;
DROP TABLE cmt CASCADE CONSTRAINTS;




/* Create Tables */

CREATE TABLE cmt
(
	cmt_num number NOT NULL,
	cmt_id varchar2(40) NOT NULL,
	cmt_regdate date NOT NULL,
	cmt_content clob NOT NULL,
	rev_num number NOT NULL,
	cus_num number NOT NULL,
	PRIMARY KEY (cmt_num)
);

CREATE TABLE customer
(
	-- 사용자 고유 번호
	cus_num number NOT NULL,
	-- 사용자 비밀번호
	cus_pw varchar2(20) NOT NULL,
	-- 사용자 이름
	cus_name varchar2(10) NOT NULL,
	-- 사용자 전화번호
	cus_phone varchar2(20) NOT NULL,
	-- 사용자 이메일
	cus_email varchar2(30) NOT NULL,
	-- 사용자 아이디
	cus_id varchar2(20) NOT NULL,
	-- 뼈다귀현황
	cus_money number,
	PRIMARY KEY (cus_num)
);


CREATE TABLE pet
(
	-- 애완견고유번호
	pet_num number NOT NULL,
	-- 애완견 이름
	pet_name varchar2(10) NOT NULL,
	-- 애완견 나이
	pet_age number NOT NULL,
	-- 애완견 무게
	pet_weight number NOT NULL,
	-- 사용자 고유 번호
	pet_reserve number NOT NULL,
	-- 애완견 예약 여부
	pet_image NUMBER NOT NULL,
	--애완견 이미지
	cus_num number NOT NULL,
	
	
	PRIMARY KEY (pet_num)
);


CREATE TABLE product
(
	-- 상품고유번호
	pro_num number NOT NULL,
	-- 상품종류
	pro_kind varchar2(20) NOT NULL,
	-- 가격
	pro_price number NOT NULL,
	-- 수량
	pro_cnt number NOT NULL,
	-- 상품이름
	pro_name varchar2(20) NOT NULL,
	PRIMARY KEY (pro_num)
);


CREATE TABLE reservation
(
	-- 예약번호
	res_num number NOT NULL,
	-- 예약 시작날짜
	res_startdate date NOT NULL,
	-- 예약 마지막날짜
	res_lastdate date NOT NULL,
	--서비스 항목
	res_sinfo varchar2(30) NOT NULL,
	-- 건의사항
	res_message clob,
	-- 사용자 고유 번호
	res_state number NOT NULL,
	--예약 상태
	cus_num number NOT NULL,
	-- 애완견고유번호
	pet_num number NOT NULL,
	PRIMARY KEY (res_num)
);


CREATE TABLE review
(
	-- 게시글 고유 번호
	rev_num number NOT NULL,
	-- 글제목
	rev_subject varchar2(40) NOT NULL,
	-- 글내용
	rev_content clob,
	-- 별점주기
	rev_star number,
	-- 등록일자
	rev_regdate date,
	-- 사용자 고유 번호
	cus_num number NOT NULL,
	PRIMARY KEY (rev_num)
);


CREATE TABLE selldata
(
	-- 사용자 고유 번호
	cus_num number NOT NULL,
	-- 상품고유번호
	pro_num number NOT NULL,
	-- 판매한날짜
	sell_date date,
	-- 판매한수량
	sell_cnt number NOT NULL,
	-- 총구매금액
	sell_sum number
);



/* Create Foreign Keys */
ALTER TABLE cmt
	ADD FOREIGN KEY (cus_num)
	REFERENCES customer (cus_num)
;

ALTER TABLE pet
	ADD FOREIGN KEY (cus_num)
	REFERENCES customer (cus_num)
	ON DELETE CASCADE --부모가 삭제되면 자식도 삭제된다.
;


ALTER TABLE reservation
	ADD FOREIGN KEY (cus_num)
	REFERENCES customer (cus_num)
;


ALTER TABLE review
	ADD FOREIGN KEY (cus_num)
	REFERENCES customer (cus_num)
;


ALTER TABLE selldata
	ADD FOREIGN KEY (cus_num)
	REFERENCES customer (cus_num)
;


ALTER TABLE reservation
	ADD FOREIGN KEY (pet_num)
	REFERENCES pet (pet_num)
;


ALTER TABLE selldata
	ADD FOREIGN KEY (pro_num)
	REFERENCES product (pro_num)
;

ALTER TABLE cmt
	ADD FOREIGN KEY (cus_num)
	REFERENCES customer (cus_num)
;

/*가상의 테스트용 customer 생성*/
SELECT * FROM CUSTOMER;

INSERT INTO CUSTOMER VALUES(1,'1234','테스트','010-1234-5678','abcd@naver.com','test',100);
INSERT INTO CUSTOMER VALUES(2,'1234','테스트','010-1234-5678','abcd@naver.com','test2',100);
INSERT INTO CUSTOMER VALUES(3,'1234','테스트','010-1234-5678','abcd@naver.com','test3',100);
INSERT INTO CUSTOMER VALUES(4,'1234','테스트','010-1234-5678','abcd@naver.com','test4',100);

DELETE FROM CUSTOMER WHERE cus_num=4;

/*가상의 테스트용 펫 생성, 삭제*/
SELECT * FROM PET;

INSERT INTO PET VALUES(1,'강아지1',5,10,0,0,1);
INSERT INTO PET VALUES(2,'강아지2',6,12,0,0,1);
INSERT INTO PET VALUES(3,'강아지3',5,10,0,0,2);
INSERT INTO PET VALUES(4,'강아지4',6,12,0,0,2);
INSERT INTO PET VALUES(5,'강아지5',6,12,0,0,1);

DELETE FROM PET WHERE pet_num=3;

/*예약 만들기*/
INSERT INTO Reservation VALUES(1,'강아지1',5,10,0,1);
INSERT INTO Reservation VALUES(1,'강아지1',5,10,0,1);

/**/
ALTER TABLE PET ADD pet_image NUMBER NOT NULL;

/*테이블에 있는지 확인용*/
SELECT * FROM CUSTOMER;
SELECT * FROM PET;
SELECT * FROM REVIEW;
SELECT * FROM PRODUCT;
SELECT * FROM RESERVATION;

DELETE FROM RESERVATION WHERE RES_NUM=102;

/*pet의 상태 바꾸기*/
UPDATE PET SET PET_RESERVE =0 WHERE PET_NUM=3;



UPDATE pet 
SET PET_RESERVE = 0
WHERE pet_num in
(
	SELECT p.pet_num
	FROM pet p JOIN RESERVATION r
	ON p.CUS_NUM = r.CUS_NUM 
	WHERE r.CUS_NUM = 1 AND SYSDATE>r.RES_LASTDATE 
)
;


UPDATE pet 
SET PET_RESERVE = 1
WHERE pet_num in
(
	SELECT p.pet_num
	FROM pet p JOIN RESERVATION r
	ON p.CUS_NUM = r.CUS_NUM 
	WHERE r.CUS_NUM = 1 AND SYSDATE BETWEEN r.RES_STARTDATE AND r.RES_LASTDATE
)
;



(SELECT pet_num FROM reservation WHERE res_num=0);

(SELECT pet_num FROM reservation WHERE res_state=0)

UPDATE reservation SET RES_STATE=0  WHERE cus_num=2 AND RES_LASTDATE<SYSDATE ;
UPDATE reservation SET RES_STATE=2  WHERE cus_num=2 AND SYSDATE BETWEEN RES_STARTDATE AND RES_LASTDATE;
UPDATE reservation SET RES_STATE=2  WHERE res_num=2;

select * from user_tables

/*상품 넣기, 삭제*/
INSERT INTO PRODUCT VALUES(1,'rice',10, 500, 'r1');
INSERT INTO PRODUCT VALUES(2,'rice',10, 500, 'r2');
INSERT INTO PRODUCT VALUES(3,'rice',10, 500, 'r3');
INSERT INTO PRODUCT VALUES(4,'rice',10, 500, 'r4');

INSERT INTO PRODUCT VALUES(5,'snack',5, 300, 'g1');
INSERT INTO PRODUCT VALUES(6,'snack',5, 200, 'g2');
INSERT INTO PRODUCT VALUES(7,'snack',10, 100, 'g3');
INSERT INTO PRODUCT VALUES(8,'snack',5, 500, 'g4');
INSERT INTO PRODUCT VALUES(9,'shampoo',13, 500, 's1');
INSERT INTO PRODUCT VALUES(10,'shampoo',13, 500, 's2');
INSERT INTO PRODUCT VALUES(11,'shampoo',13, 500, 's3');
INSERT INTO PRODUCT VALUES(12,'shampoo',13, 500, 's4');
INSERT INTO PRODUCT VALUES(13,'etc',20, 100, 'e1');

DELETE PRODUCT WHERE pro_num=8;
/*SQL문 테스트*/
SELECT * FROM PET WHERE cus_num=1;

SELECT * FROM pet;
SELECT pet_name FROM pet;

SELECT pet_num FROM pet WHERE cus_num=1 AND pet_name='강아지2';

UPDATE pet SET pet_reserve = 1 WHERE pet_num = 4;

UPDATE reservation SET res_state=2 WHERE res_num=3;

SELECT * FROM CUSTOMER WHERE cus_id = 'test' AND cus_pw = '1234';



/* 임시 테이블 생성 */ 
CREATE TABLE TB_TEST01 
( 
-- 실행시간 
EXEC_TIME DATE 
);

 /* 프로시저 생성 */ 
CREATE OR REPLACE PROCEDURE P_ORACLE_JOB_TEST01 
IS 
	BEGIN 
	-- 현지시간을 기록한다.
		
	INSERT INTO TB_TEST01(EXEC_TIME) 
	VALUES ( SYSDATE ); 
END;



DECLARE 
	X NUMBER; 
BEGIN 
	SYS.DBMS_JOB.SUBMIT 
	( 
		JOB => X  
		,WHAT => 'P_ORACLE_JOB_TEST01;' 
		,NEXT_DATE => SYSDATE + 1/24/60 -- 1분후
		,INTERVAL => 'SYSDATE + 1/24/60/10' -- 6초 간격
		, NO_PARSE => TRUE 
	); 
	END;

SELECT * FROM USER_JOBS;
/**/

CREATE SEQUENCE RESERVATION_SEQ;
DROP SEQUENCE RESERVATION_SEQ;

CREATE SEQUENCE CMT_SEQ;
CREATE SEQUENCE REVIEW_SEQ;
CREATE SEQUENCE PRODUCT_SEQ;
CREATE SEQUENCE SELLDATA_SEQ;

CREATE SEQUENCE CUSTOMER_SEQ;
DROP SEQUENCE CUSTOMER_SEQ;

CREATE SEQUENCE PET_SEQ;
DROP SEQUENCE PET_SEQ;
/*시퀀스 손보기*/
/*1. 시퀀스의 현재 값을 확인*/
SELECT LAST_NUMBER FROM USER_SEQUENCES WHERE SEQUENCE_NAME = 'CUSTOMER_SEQ';
/*2. 시퀀스의 INCREMENT 를 현재 값만큼 빼도록 설정 (아래는 현재값이 999999 일 경우)*/
ALTER SEQUENCE PET_SEQ INCREMENT BY -25;
/*3. 시퀀스에서 다음 값을 가져 온다. */
SELECT PET_SEQ.NEXTVAL FROM DUAL;
/*4. 현재 값을 확인 해보면 -999999 만큼 증가 했다*/
SELECT PET_SEQ.CURRVAL FROM DUAL;
/*5. 시퀀스의 INCREMENT값을 1로 가져 온다. */
ALTER SEQUENCE PET_SEQ INCREMENT BY 1;


/* Comments */

COMMENT ON COLUMN customer.cus_num IS '사용자 고유 번호';
COMMENT ON COLUMN customer.cus_pw IS '사용자 비밀번호';
COMMENT ON COLUMN customer.cus_name IS '사용자 이름';
COMMENT ON COLUMN customer.cus_phone IS '사용자 전화번호';
COMMENT ON COLUMN customer.cus_email IS '사용자 이메일';
COMMENT ON COLUMN customer.cus_id IS '사용자 아이디';
COMMENT ON COLUMN customer.cus_money IS '뼈다귀현황';
COMMENT ON COLUMN pet.pet_num IS '애완견고유번호';
COMMENT ON COLUMN pet.pet_name IS '애완견 이름';
COMMENT ON COLUMN pet.pet_age IS '애완견 나이';
COMMENT ON COLUMN pet.pet_weight IS '애완견 무게';
COMMENT ON COLUMN pet.cus_num IS '사용자 고유 번호';
COMMENT ON COLUMN product.pro_num IS '상품고유번호';
COMMENT ON COLUMN product.pro_kind IS '상품종류';
COMMENT ON COLUMN product.pro_price IS '가격';
COMMENT ON COLUMN product.pro_cnt IS '수량';
COMMENT ON COLUMN product.pro_name IS '상품이름';
COMMENT ON COLUMN reservation.res_num IS '예약번호';
COMMENT ON COLUMN reservation.res_startdate IS '예약 시작날짜';
COMMENT ON COLUMN reservation.res_lastdate IS '예약 마지막날짜';
COMMENT ON COLUMN reservation.res_message IS '건의사항';
COMMENT ON COLUMN reservation.cus_num IS '사용자 고유 번호';
COMMENT ON COLUMN reservation.pet_num IS '애완견고유번호';
COMMENT ON COLUMN review.rev_num IS '게시글 고유 번호';
COMMENT ON COLUMN review.rev_subject IS '글제목';
COMMENT ON COLUMN review.rev_content IS '글내용';
COMMENT ON COLUMN review.rev_star IS '별점주기';
COMMENT ON COLUMN review.rev_regdate IS '등록일자';
COMMENT ON COLUMN review.cus_num IS '사용자 고유 번호';
COMMENT ON COLUMN selldata.cus_num IS '사용자 고유 번호';
COMMENT ON COLUMN selldata.pro_num IS '상품고유번호';
COMMENT ON COLUMN selldata.sell_date IS '판매한날짜';
COMMENT ON COLUMN selldata.sell_cnt IS '판매한수량';
COMMENT ON COLUMN selldata.sell_sum IS '총구매금액';



