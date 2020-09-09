package www.study.com.orm.bulletinBoard.model;

import lombok.Data;

@Data
public class PostVO extends BulletinBoardVO{

    private BulletinBoardTypeVO boardType;
    private String boardTitle;

    @Override
    public String toString() {
        return "PostVO{" +
                "boardVo=" + getBoardType() +
                ", boardTitle='" + boardTitle + '\'' +
                " hierarchicallyId="+getHierarchicallyId()+" writerId="+getWriter()+" content="+getContent()+
                '}';
    }
}
