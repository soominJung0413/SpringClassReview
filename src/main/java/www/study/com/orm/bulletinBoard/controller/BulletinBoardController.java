package www.study.com.orm.bulletinBoard.controller;

import oracle.jdbc.proxy.annotation.Post;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import www.study.com.framework.Criteria;
import www.study.com.framework.SearchCriteria;
import www.study.com.framework.util.PagingCriteriaGeneric;
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
    public void provideBoardList(SearchCriteria criteria, Model model){
        PagingCriteriaGeneric<List<BulletinBoardVO>,Integer> pagingCriteriaGeneric = bulletinBoardService.readAllWithPaging(criteria);

        model.addAttribute("list",pagingCriteriaGeneric.getAllWithPaging());
        model.addAttribute("pageMaker", new SearchCriteria(criteria,pagingCriteriaGeneric.getTotalCount()));
    }

    @GetMapping("/readOnePost")
    public String provideReadForm(@ModelAttribute("cri")SearchCriteria criteria, String hierarchicallyId, Model model){
        BulletinBoardVO bulletinBoardVO = bulletinBoardService.readOnePost(hierarchicallyId);
        model.addAttribute("post",bulletinBoardVO);
        return "board/PostDetail";
    }

    @GetMapping("/register")
    public void provideRegisterForm(@ModelAttribute("cri")SearchCriteria criteria){}

    @PostMapping("/register")
    public String processRegisterForm(@ModelAttribute("cri")SearchCriteria criteria, PostVO postVO, RedirectAttributes redirectAttributes){
        int result = bulletinBoardService.registerPost(postVO);
        if(result != 1){
        }
        String resultStr = postVO.getHierarchicallyId()+"번 게시물이 등록되었습니다.";
        redirectAttributes.addFlashAttribute("result",resultStr);
        redirectAttributes.addAttribute("amount",criteria.getAmount());
        redirectAttributes.addAttribute("pageNum",criteria.getPageNum());
        return "redirect:/board/list";
    }

    @GetMapping("/modify")
    public String provideModifyForm(@ModelAttribute("cri")SearchCriteria criteria, String hierarchicallyId, Model model){
        BulletinBoardVO bulletinBoardVO =bulletinBoardService.readOnePost(hierarchicallyId);
        model.addAttribute("post",bulletinBoardVO);
        return "board/modifyPost";
    }

    @PostMapping("/modify")
    public String processModifyForm(@ModelAttribute("cri")SearchCriteria criteria, PostVO postVO, RedirectAttributes redirectAttributes){
        int result = bulletinBoardService.modifyPost(postVO);
        if(result != 1){
        }
        String resultStr = postVO.getHierarchicallyId()+"번 게시물이 수정되었습니다.";
        redirectAttributes.addFlashAttribute("result",resultStr);
        return "redirect:/board/list"+criteria.getQueryString();
    }

    @PostMapping("/remove")
    public String processRemove(@ModelAttribute("cri")SearchCriteria criteria, @RequestParam("hierarchicallyId") String hierarchicallyId, RedirectAttributes redirectAttributes){
        int result = bulletinBoardService.removePost(hierarchicallyId);
        if(result != 1){}

        String resultStr = hierarchicallyId+"번 게시물이 삭제되었습니다.";
        redirectAttributes.addFlashAttribute("result",resultStr);
        return "redirect:/board/list"+criteria.getQueryString();
    }


}
