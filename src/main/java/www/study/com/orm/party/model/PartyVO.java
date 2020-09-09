package www.study.com.orm.party.model;

import lombok.Data;
import lombok.ToString;

import java.util.Date;
import java.util.List;

@Data
@ToString
public class PartyVO {

    private int id;
    private String name;
    private Date birthDate;
    private String partyType;

    private List<ContactPointVO> contextPointList;

    private List<HashTagVO> hashTagList;

}
