package www.study.com.orm.party.mapper;

import www.study.com.orm.party.model.PartyVO;

import java.util.List;

public interface PartyMapper {

    public List<PartyVO> getAll();

    public List<PartyVO> getAllWithContactPoint();

    public List<PartyVO> getAllWithContactPointWithHashTag();
}
