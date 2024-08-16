--회원관리
create table hmember(
 mem_num number not null,
 id varchar2(12) unique not null,
 auth number(1) default 2 not null, --회원 등급:0탈퇴회원,1정지회원,2일반회원,9관리자
 constraint hmember_pk primary key (mem_num)
);
create table hmember_detail(
 mem_num number not null,
 name varchar2(30) not null,
 passwd varchar2(12) not null,
 phone varchar2(15) not null,
 email varchar2(50) not null,
 zipcode varchar2(5) not null,
 address1 varchar2(90) not null,
 address2 varchar2(90) not null,
 photo varchar2(400),
 reg_date date default sysdate not null,
 modify_date date,
 constraint hmember_detail_pk primary key (mem_num),
 constraint hmember_detail_fk foreign key (mem_num) 
                                references hmember (mem_num)
);
create sequence hmember_seq;

--게시판
create table hboard(
 board_num number not null,
 title varchar2(150) not null,
 content clob not null,
 hit number(9) default 0 not null,
 reg_date date default sysdate not null,
 modify_date date,
 filename varchar2(400),
 ip varchar2(40) not null,
 mem_num number not null,
 constraint hboard_pk primary key (board_num),
 constraint hboard_fk foreign key (mem_num) 
                       references hmember (mem_num)
);
create sequence hboard_seq;

--좋아요
create table hboard_fav(
 board_num number not null,
 mem_num number not null,
 constraint hboard_fav_fk1 foreign key (board_num) 
                        references hboard (board_num),
 constraint hboard_fav_fk2 foreign key (mem_num)
                        references hmember (mem_num)    
);

--댓글
create table hboard_reply(
 re_num number not null,
 re_content varchar2(900) not null,
 re_date date default sysdate not null,
 re_modifydate date,
 re_ip varchar2(40) not null,
 board_num number not null,
 mem_num number not null,
 constraint hreply_pk primary key (re_num),
 constraint hreply_fk1 foreign key (board_num) 
                       references hboard (board_num),
 constraint hreply_fk2 foreign key (mem_num)
                       references hmember (mem_num)
);
create sequence hreply_seq;


--Q&A 게시판
CREATE TABLE qa(
qa_num NUMBER NOT NULL,               -- QA 식별자
mem_num NUMBER NOT NULL,               -- 회원 식별자
qa_title VARCHAR2(150) NOT NULL,
qa_content CLOB NOT NULL,
qa_photo VARCHAR2(400),
qa_status NUMBER DEFAULT 1 NOT NULL,
qa_reg DATE DEFAULT SYSDATE NOT NULL,
qa_modify DATE,
CONSTRAINT qa_pk PRIMARY KEY (qa_num),
CONSTRAINT qa_fk FOREIGN KEY (mem_num) REFERENCES member (mem_num)
);
CREATE SEQUENCE qa_seq;

--Q&A 게시판 답변
CREATE TABLE qa_comment(
qa_comm_num NUMBER NOT NULL,            -- QA 답변 식별자
qa_num NUMBER NOT NULL,                  -- QA 식별자
qa_comm_content CLOB NOT NULL,
qa_comm_reg DATE DEFAULT SYSDATE NOT NULL,
qa_comm_modify DATE,
CONSTRAINT qa_comment_pk PRIMARY KEY (qa_comm_num),
CONSTRAINT qa_comment_fk FOREIGN KEY (qa_num) REFERENCES qa (qa_num)
);
CREATE SEQUENCE qa_comment_seq;


--아우터
create table hitem(
 item_num number not null,
 name varchar2(30) not null,
 price number(9) not null,
 quantity number(7) not null,
 photo varchar2(400) not null,
 detail clob not null,
 reg_date date default sysdate not null,
 modify_date date,
 status number(1) not null, --표시 여부(판매 가능 여부)1:미표시,2:표시
 constraint hitem_pk primary key (item_num)
);
create sequence hitem_seq;

--장바구니
create table hcart(
 cart_num number,
 item_num number not null,
 order_quantity number(7) not null,
 reg_date date default sysdate not null,
 mem_num number not null, -- 상품 구매자 회원번호
 constraint hcart_pk primary key (cart_num),
 constraint hcart_fk1 foreign key (item_num) references hitem (item_num),
 constraint hcart_fk2 foreign key (mem_num) references hmember (mem_num)
);
create sequence hcart_seq;

--주문
create table horder(
 order_num number not null,
 order_total number(9) not null,
 payment number(1) not null, --결제방식
 status number(1) default 1 not null, --배송 상태
 receive_name varchar2(30) not null,
 receive_post varchar2(5) not null,
 receive_address1 varchar2(90) not null,
 receive_address2 varchar2(90) not null,
 receive_phone varchar2(15) not null,
 notice varchar2(4000),
 reg_date date default sysdate not null,
 modify_date date,
 mem_num number not null,
 constraint horder_pk primary key (order_num),
 constraint horder_fk foreign key (mem_num) references hmember (mem_num)
);
create sequence horder_seq;

create table horder_detail(
 detail_num number not null,
 item_num number not null,
 item_name varchar2(30) not null,
 item_price number(9) not null,
 item_total number(9) not null,
 order_quantity number(7) not null,
 order_num number not null,
 constraint horder_detail_pk primary key (detail_num),
 constraint horder_detail_fk foreign key (order_num) references horder (order_num)
);
create sequence horder_detail_seq;
