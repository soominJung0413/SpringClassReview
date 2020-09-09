package www.study.com.party;


import lombok.extern.log4j.Log4j;
import org.hamcrest.core.IsNull;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import www.study.com.orm.party.mapper.PartyMapper;
import www.study.com.orm.party.model.PartyVO;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:C:\\Users\\doli0\\Desktop\\Springclass\\mybatisStudy\\web\\WEB-INF\\applicationContext.xml")
@Log4j
public class mapperTests {

    @Autowired
    private PartyMapper partyMapper;

//    @Test
    public void testExists(){
        Assert.assertThat(partyMapper, IsNull.notNullValue());
        log.info(partyMapper);
    }

//    @Test
    public void testGetAll(){

        for (PartyVO vo : partyMapper.getAll()) {
            log.info(vo);
            log.info(vo.getId()+" / "+vo.getName()+" / "+vo.getBirthDate()+" / "+vo.getPartyType());
        }

    }

//    @Test
    public void testGetAllWithContactPoint(){
        List<PartyVO> list = partyMapper.getAllWithContactPoint();

        for(PartyVO vo : list){
            log.info("==========================================");
            log.info(vo);
            System.out.println(vo.getContextPointList());
        }
    }

//    @Test
    public void testGetAllWithContactPointWithHashTag(){
        List<PartyVO> list = partyMapper.getAllWithContactPointWithHashTag();

        for (PartyVO vo : list) {
            try {
                log.info("==========================================");
                log.info(vo);
                System.out.println(vo.getContextPointList());
            }catch(Exception e){
                log.error(e.getMessage());
            }
        }
    }
}
