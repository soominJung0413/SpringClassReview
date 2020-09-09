
--해시태그
create sequence seq_hash_tag;
drop table c_hash_tag;
drop table c_hash_service;

--회원과 연락처타입
drop table c_contact_point_type;
drop table c_contact_point;
drop table c_party;

-- id, name, birth_date, party_type, gender, sales_total
create table c_party(
  id            number(10),
  name          varchar2(50),
  birth_date    date,
  party_type    varchar2(50),
  gender        varchar2(50),
  sales_Total   number(30),
  primary key (id)
);

insert into c_party(id, name, birth_date, party_type, gender) values (-100,'홍길동','1500.01.01','PERSON','MALE');
insert into c_party(id, name, birth_date, party_type, gender) values (-101,'이순신','1500.01.01','PERSON', 'MALE');
insert into c_party(id, name, birth_date, party_type, sales_Total) values (-1000,'대한','1500.01.01','ORGANIZATION', 25242024223019);

--연락처 유형이다.
create  table c_contact_point_type(
  name           varchar2(50),
  validation_rex varchar2(50)
);

INSERT INTO c_contact_point_type (name) VALUES('email');
INSERT INTO c_contact_point_type (name) VALUES('address');
INSERT INTO c_contact_point_type (name) VALUES('phone');

--연락처 타입과 내용을 이어주는 테이블이다.
CREATE TABLE c_contact_point(
                id 				number(10),   --1:N 구조 나는 어디에 달려있어요
                type_name		varchar2(50),
                type_value	    varchar2(200),
                primary key(id, type_name)
);

insert into c_contact_point(id, type_name, type_value) values(-100,'address','한양');
insert into c_contact_point(id, type_name, type_value) values(-100,'email','old@한양.서버');

select * from C_PARTY p LEFT outer JOIN c_contact_point cp on p.id = cp.id;

-- 고유의 값을 가진 검색용 해시태그들이다. 사용자와 해시태그 개인화서비스 테이블과 연결해준다.
create table c_hash_tag(
                id              number(10),
                tagName         varchar2(10),
                primary key (id)
);

insert INTO c_hash_tag (id, tagName) values ( seq_hash_tag.nextval, '액자');
insert INTO c_hash_tag (id, tagName) values ( seq_hash_tag.nextval, '사진');

-- 사용자 개인의 해시태그 값이다.
create table c_hash_service(
                party_id          number(10),
                hash_id           number(10),
                primary key (party_id,hash_id),
                constraint fk_hash_party foreign key(party_id) references c_party(id),
                constraint fk_hash_hashTag foreign key(hash_id) references c_hash_tag(id)
) ;

insert into c_hash_service (party_id, hash_id) (select -100, id from c_hash_tag where id = 1);
insert into c_hash_service (party_id, hash_id) (select -100, id from c_hash_tag where id = 2);
insert into c_hash_service (party_id, hash_id) (select -101, id from c_hash_tag where id = 2);

-- 개인에 따른 정보와 해싱 값을 가져오는 셀렉트는 어떻게 할 것인가.
select p.*,ccp.*,chs.*,cht.id as htl_id, cht.tagName as htl_tagName from c_party p
    left outer join c_contact_point ccp on p.id = ccp.id
    left outer join c_hash_service chs on p.id = chs.party_id
    left outer join c_hash_tag cht on chs.hash_id = cht.id;