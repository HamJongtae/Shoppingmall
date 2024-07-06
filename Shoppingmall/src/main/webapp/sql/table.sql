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





