package com.iarchie.crm_v1.web.controller;


import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.iarchie.crm_v1.context.UserContext;
import com.iarchie.crm_v1.domain.DocTest;
import com.iarchie.crm_v1.domain.User;
import com.iarchie.crm_v1.service.IDocTestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("/notice")
public class NoticeController {

    @Autowired
    private IDocTestService docTestService;

    @RequestMapping("/noticeView")
    public String noticeView(Model model, Integer pageIndex) {
        int pageSize = 5;//每页显示的记录数
        if (pageIndex == null)
            pageIndex = 1;//第一次访问页面默认页面为第一页
        PageHelper.startPage(pageIndex, pageSize);
        List<DocTest> docTests = docTestService.selectAll();
        //得到分页的结果对象
        PageInfo<DocTest> personPageInfo = new PageInfo<>(docTests);
        //得到分页中的person条目对象
        List<DocTest> pageList = personPageInfo.getList();
        model.addAttribute("docList", pageList);
        model.addAttribute("page", personPageInfo);
        User user = UserContext.getCurrentUser();
        if(user.getUsername() .equals("普通用户") ){
            return "notice/notice1";
        }
        return "notice/notice";

    }


    @RequestMapping("/addView")
    public String updateOrAddView() {
        return "notice/noticeAddOrUpdate";
    }

    //公告添加
    @RequestMapping(value = "/noticeAdd", method = RequestMethod.POST)
    @ResponseBody
    public String noticeAdd(@RequestBody DocTest docTest) {
        User user = UserContext.getCurrentUser();
        docTest.setUseraction(user.getLoginname());
        int insert = docTestService.insert(docTest);
        System.out.println(insert);
        if (insert < 0) {
            return "error";
        }
        return "success";
    }


    //公告删除
    @RequestMapping(value = "/noticeDelete", method = RequestMethod.GET)
    @ResponseBody
    public ModelAndView delete(@RequestParam("id") Long id,ModelAndView mv) {
        if (id != null){
            int index;
            index = docTestService.deleteByPrimaryKey(id);
        }
        mv.setViewName("redirect:noticeView");
        return mv;
    }

}
