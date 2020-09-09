package www.study.com.orm.bulletinBoard.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import www.study.com.orm.bulletinBoard.model.BulletinBoardVO;
import www.study.com.orm.bulletinBoard.model.PostVO;
import www.study.com.orm.bulletinBoard.service.BulletinBoardService;

import java.util.List;

@Controller
@RequestMapping("/board")
public class BulletinBoardController {

    @Autowired
    private BulletinBoardService bulletinBoardService;

    @GetMapping("list")
    public void provideBoardList(Model model){
        List<BulletinBoardVO> list = bulletinBoardService.readAll();
        model.addAttribute("list",list);
    }

    @GetMapping("/readOnePost")
    public String provideReadForm(String hierarchicallyId, Model model){
        BulletinBoardVO bulletinBoardVO = bulletinBoardService.readOnePost(hierarchicallyId);
        model.addAttribute("post",bulletinBoardVO);
        return "board/PostDetail";
    }

    @GetMapping("/register")
    public void provideRegisterForm(){}

    @PostMapping("register")
    public String processRegisterForm(PostVO postVO, RedirectAttributes redirectAttributes){
        int result = bulletinBoardService.registerPost(postVO);
        if(result != 1){
        }
        String resultStr = postVO.getHierarchicallyId()+"번 게시물이 등록되었습니다.";
        redirectAttributes.addFlashAttribute("result",resultStr);
        return "redirect:/board/list";
    }

    @GetMapping("/modify")
    public String provideModifyForm(String hierarchicallyId, Model model){
        BulletinBoardVO bulletinBoardVO =bulletinBoardService.readOnePost(hierarchicallyId);
        model.addAttribute("post",bulletinBoardVO);
        return "board/modifyPost";
    }

    @PostMapping("/modify")
    public String processModifyForm(PostVO postVO, RedirectAttributes redirectAttributes){
        int result = bulletinBoardService.modifyPost(postVO);
        if(result != 1){
        }
        String resultStr = postVO.getHierarchicallyId()+"번 게시물이 수정되었습니다.";
        redirectAttributes.addFlashAttribute("result",resultStr);
        return "redirect:/board/list";
    }


}
