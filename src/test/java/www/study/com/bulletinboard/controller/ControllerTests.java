package www.study.com.bulletinboard.controller;


import lombok.extern.log4j.Log4j;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MockMvcBuilder;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:C:\\Users\\doli0\\Desktop\\Springclass\\mybatisStudy\\web\\WEB-INF\\applicationContext.xml",
                        "file:C:\\Users\\doli0\\Desktop\\Springclass\\mybatisStudy\\web\\WEB-INF\\dispatcher-servlet.xml"})
@WebAppConfiguration
@Log4j
public class ControllerTests {

    @Autowired
    private WebApplicationContext actx;

    private MockMvc mockMvc;

    @Before
    public void setUp(){
        mockMvc = MockMvcBuilders.webAppContextSetup(actx).build();
    }

    @Test
    public void testRegisterProcessForm(){
        //hierarchically_id, writer_id, content, post_type, board_id, board_title
        try {
            log.info(mockMvc.perform(MockMvcRequestBuilders.post("/board/register")
                    .param("content", "테스트 메서드 내용123")
                    .param("boardType.boardTypeId","-1")
                    .param("boardTitle", "테스트 매서드 제목123")
                    .param("writer.id", "-100")).andReturn().getModelAndView().getModelMap());
        }catch (Exception e){
            log.error(e.getMessage());
        }
    }
}
