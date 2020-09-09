package www.study.com.orm.bulletinBoard.service;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import www.study.com.orm.bulletinBoard.mapper.BoardMapper;
import www.study.com.orm.bulletinBoard.model.BulletinBoardVO;
import www.study.com.orm.bulletinBoard.model.PostVO;

import java.util.List;

@Service
public class BulletinBoardService {

    @Autowired
    private BoardMapper boardMapper;

    public List<BulletinBoardVO> readAll(){
        return boardMapper.getAll();
    };

    public List<BulletinBoardVO> readAllReply(@Param("hierarchicallyId") String hierarchicallyId){
        return boardMapper.getAllReply(hierarchicallyId);
    };

    public BulletinBoardVO readOnePost(@Param("hierarchicallyId") String hierarchicallyId){
        return boardMapper.getOnePost(hierarchicallyId);
    };

    //insert
    public int registerPost( PostVO postVO){
        return boardMapper.insertPost(postVO);
    };
    public int registerReply(BulletinBoardVO bulletinBoardVO){
        return boardMapper.insertReply(bulletinBoardVO);
    };

    //update
    public int modifyPost(PostVO postVO){
        return boardMapper.updatePost(postVO);
    };
}
