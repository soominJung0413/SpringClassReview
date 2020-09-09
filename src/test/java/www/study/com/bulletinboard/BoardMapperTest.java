package www.study.com.bulletinboard;


import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import www.study.com.orm.bulletinBoard.mapper.BoardMapper;
import www.study.com.orm.bulletinBoard.model.BulletinBoardTypeVO;
import www.study.com.orm.bulletinBoard.model.BulletinBoardVO;
import www.study.com.orm.bulletinBoard.model.PostVO;
import www.study.com.orm.party.model.PartyVO;

import java.util.Arrays;
import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:C:\\Users\\doli0\\Desktop\\Springclass\\mybatisStudy\\web\\WEB-INF\\applicationContext.xml")
@Log4j
public class BoardMapperTest {

    @Autowired
    private BoardMapper boardMapper;

//    @Test
    public void testExist(){
        log.info(boardMapper);
    }

//    @Test
    public void testGetAll(){
        try {
             List<BulletinBoardVO> list = boardMapper.getAll();
           for (BulletinBoardVO vo : list) {
                log.info(vo);
            }
        }catch(Exception e){
            e.printStackTrace();
        }

    };

//    @Test
    public void testGetAllReply(){
        try{
            List<BulletinBoardVO> list = boardMapper.getAllReply("1");

            for (BulletinBoardVO vo : list) {
                log.info(vo);
            }
        }catch(Exception e){
            log.error(e.getMessage());
        }
    }

//    @Test
    public void testGetOnePost(){
        BulletinBoardVO vo = boardMapper.getOnePost("1");
        log.info(vo);
    }

//    @Test
    public void testInsertPost(){
        try {
        PostVO postVO = new PostVO();
        PartyVO partyVO = new PartyVO() ;
        partyVO.setId(-100);
        postVO.setWriter(partyVO);
        postVO.setContent("인서트 메서드 테스트 내용12");
            BulletinBoardTypeVO bulletinBoardTypeVO = new BulletinBoardTypeVO();
            bulletinBoardTypeVO.setBoardTypeId(-1);
            bulletinBoardTypeVO.setBoardType("자유게시판");
        postVO.setBoardType(bulletinBoardTypeVO);
        postVO.setBoardTitle("인서트 메서드 테스트 제목12");
        int result = boardMapper.insertPost(postVO);
        log.info(postVO.getHierarchicallyId());
        }catch (Exception e){
            log.error(e.getMessage());
        }
        }

//    @Test
    public void testInsertReply(){
        try{
            BulletinBoardVO bulletinBoardVO = new BulletinBoardVO();
            PartyVO partyVO = new PartyVO();
            partyVO.setId(-100);
            bulletinBoardVO.setHierarchicallyId("V");
            bulletinBoardVO.setWriter(partyVO);
            bulletinBoardVO.setContent("인서트 메서드 댓글 내용");

            int result = boardMapper.insertReply(bulletinBoardVO);

            log.info(bulletinBoardVO.getHierarchicallyId());
        }catch(Exception e){
            log.error(e.getMessage());
        }
    }

//    @Test
    public void testUpdatePost(){
        PostVO postVO = new PostVO();
        postVO.setHierarchicallyId("V");
        postVO.setBoardTitle("메서드 글 수정 제목");
        postVO.setContent("메서드 글 수정 내용");

        int result = boardMapper.updatePost(postVO);
    }
}
