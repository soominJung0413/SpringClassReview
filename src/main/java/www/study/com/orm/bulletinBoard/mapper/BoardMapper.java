package www.study.com.orm.bulletinBoard.mapper;

import org.apache.ibatis.annotations.Param;
import www.study.com.framework.Criteria;
import www.study.com.orm.bulletinBoard.model.BulletinBoardVO;
import www.study.com.orm.bulletinBoard.model.PostVO;

import java.util.List;

public interface BoardMapper {

    public List<BulletinBoardVO> getAll();

    public List<BulletinBoardVO> getAllWithPaging(@Param("criteria") Criteria criteria);

    public int getPostTotalCount(@Param("criteria") Criteria criteria);

    public List<BulletinBoardVO> getAllReply(@Param("hierarchicallyId") String hierarchicallyId);

    public BulletinBoardVO getOnePost(@Param("hierarchicallyId") String hierarchicallyId);

    //insert
    public int insertPost(PostVO postVO);
    public int insertReply(BulletinBoardVO bulletinBoardVO);

    //update
    public int updatePost(PostVO postVO);

    //delete
    public int deletePost(@Param("hierarchicallyId") String hierarchicallyId);
}
