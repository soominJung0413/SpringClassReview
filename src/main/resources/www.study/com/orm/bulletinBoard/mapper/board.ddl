
-- 게시판과 글
drop table c_bulletin_board_post;
drop table c_bulletin_board_type;

drop sequence seq_post;
create sequence seq_post;


-- 게시판의 타입에 따른 내용 즉 자유게시판 공지사항..등
create table c_bulletin_board_type(
                                      id          number(10),
                                      name        varchar2(50),
                                      primary key (id)
);

insert into c_bulletin_board_type (id, name) VALUES (-1,'자유게시판');
insert into c_bulletin_board_type (id, name) VALUES (-2,'공지사항');

--게시글, 작성자와는 1:N 게시글과는 N:M 관계를 성립
--시퀀스에 - 를 매겨 글-댓글-대댓글 기준은 잡을 것임
create table c_bulletin_board_post(
      hierarchically_id       varchar2(2000),
      writer_id               number(10),
      content                 varchar2(2000),--여기까지가 공통사항
      post_type               varchar2(50),--분기점 댓글일경우 해당 테이블을 자식으로 가짐
      board_id                number(10),--글일 경우 번호
      board_title             varchar2(100),--글일 경우 제목
      primary key (hierarchically_id),
      constraint fk_post_board_id foreign key (board_id) references c_bulletin_board_type(id),--게시글유형의 연결점
      constraint fk_post_writer_id foreign key (writer_id) references  C_PARTY(ID)--작성자와의 연결점
);
--테스트 게시글 데이터
insert into c_bulletin_board_post (hierarchically_id, writer_id, content, post_type, board_id, board_title) VALUES
(seq_post.nextval,-100, '테스트 글 내용','POST',-1,'테스트 글 제목');
insert into c_bulletin_board_post (hierarchically_id, writer_id, content, post_type, board_id, board_title) VALUES
(seq_post.nextval,-100, '테스트 글 내용','POST',-1,'테스트 글 제목');
insert into c_bulletin_board_post (hierarchically_id, writer_id, content, post_type, board_id, board_title) VALUES
(seq_post.nextval,-101, '테스트 글 내용','POST',-2,'테스트 글 제목');
--테스트 댓글 데이터
insert into c_bulletin_board_post (hierarchically_id, writer_id, content, post_type, board_id) VALUES
('1'||'-'||seq_post.nextval,-101, '테스트 댓글 내용','REPLY',-1);
insert into c_bulletin_board_post (hierarchically_id, writer_id, content, post_type, board_id) VALUES
('1'||'-'||seq_post.nextval,-100, '테스트 댓글 내용','REPLY',-1);
insert into c_bulletin_board_post (hierarchically_id, writer_id, content, post_type, board_id) VALUES
('2'||'-'||seq_post.nextval,-100, '테스트 댓글 내용','REPLY',-2);

--글하나에 대한 내용을 가져오려면 어떻게 해야하나
select CP.*, cbbp.*,CBBT.ID as bt_id,CBBT.NAME as bt_name
        from c_bulletin_board_post cbbp
           left outer join C_PARTY CP on cbbp.writer_id = CP.ID
           left outer join C_BULLETIN_BOARD_TYPE CBBT on cbbp.BOARD_ID = CBBT.ID
                where POST_TYPE = 'POST';

--원글에 있는 글을 기준으로 댓글들을 가져올 수는 없을까
select c.*, cbbp.*, CBBT.id as bt_id, CBBT.name bt_name from c_bulletin_board_post cbbp
                  left join C_PARTY  c on cbbp.WRITER_ID = c.ID
                  left outer join C_BULLETIN_BOARD_TYPE CBBT on cbbp.BOARD_ID = CBBT.ID
where hierarchically_id like '1%';

--하나의 글만 가져올 수는 없을까.
select c.*, cbbp.*, cbbt.id as bt_id, cbbt.name as bt_name from c_bulletin_board_post cbbp
            left join C_PARTY c on cbbp.writer_id = c.ID
            left outer join c_bulletin_board_type cbbt on cbbp.board_id = cbbt.id
                where hierarchically_id like 'V';

--하나의 글을 수정하는 쿼리는 무엇일까
update c_bulletin_board_post set content = '쿼리수정내용' ,board_title = '쿼리수정제목'
    WHERE hierarchically_id = 'V';

--강사님이 주신 64진수 변환 프로시저
/* Composite Pattern에 따른 상하 구성 관계는 기본적으로 Path Query에 의하여
 * 개발이 가능하다. Oracle의 경우 start with connected by이다.
 * 하지만 구성 관계의 Level이 깊어질 수록 성능을 보장하기 힘들다.
 * 이에 객체 상하관계 전체를 primary key로 구성하여 Like 절을 위주로 활용한다.
 * 객체 ID를 숫자 기반으로 만들어내되 그 길이를 좀더 줄여서 표현하기 위하여
 * Alpha-Numeric만을 사용한 최대 축약형은 제공되지 않으므로 62진법(10 + 26[대문자] + 26[소문자])에
 * 따른 문자열 표현을 만들기 위하여 개발함
 */
CREATE OR REPLACE FUNCTION to62(intNum number)
    RETURN VARCHAR
    IS
    res VARCHAR2(100) := '';
    quot number;
    rema number;
BEGIN
    quot := intNum;
    WHILE quot > 0 LOOP
            rema := mod(quot, 62);
            quot := FLOOR(quot / 62);

            IF rema < 10 THEN
                res := chr(ASCII('0') + rema) || res;
            ELSIF rema < 36 THEN
                res := chr(ASCII('A') + (rema - 10)) || res;
            ELSE
                res := chr(ASCII('a') + (rema - 36)) || res;
            END IF;
        END LOOP;
    RETURN res;
END;

select TO62(seq_post.nextval) from dual;


-- 리스트를 가져오는 쿼리에서 페이지네이션 항목을 잡아줘야한다.
select cbbp.* from
    (select rownum rn, cbbp.*
     from c_bulletin_board_post cbbp
     where ROWNUM <=20  and POST_TYPE = 'POST' ) cbbp
    left outer join C_PARTY c on cbbp.writer_id = c.ID
 where rn > 10;

--리스트를 가져오는 쿼리에서 단순 검색 기능을 처리하려면 어떻게 해야할까.
select cbbp.* from
    (select rownum rn, cbbp.*
     from c_bulletin_board_post cbbp
     where ROWNUM <=20 and (cbbp.board_title like '%테스트%') and POST_TYPE = 'POST' ) cbbp
        left outer join C_PARTY c on cbbp.writer_id = c.ID
where rn > 10;



