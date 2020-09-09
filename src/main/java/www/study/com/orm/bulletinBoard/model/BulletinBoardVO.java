package www.study.com.orm.bulletinBoard.model;

import lombok.Data;
import lombok.Getter;
import www.study.com.orm.party.model.PartyVO;

@Data
public class BulletinBoardVO {//글 자체를 나타냄 테이블 구조상 댓글은 추가되는 사항이 없음 즉 해당 클래스가 댓글이됨
    @Getter
    private static final String HID = "-";

    private String hierarchicallyId;
    private PartyVO writer;
    private String content;

}
