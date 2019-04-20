package com.iarchie.crm_v1.web.controller;


import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.iarchie.crm_v1.context.UserContext;
import com.iarchie.crm_v1.domain.User;
import com.iarchie.crm_v1.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/admin")
public class UserController {

    @Autowired
    private IUserService userService;

    //加载列表界面
    @RequestMapping("/userView")
    public String showUser() {
        return "user/user";
    }


    //跳转add页面
    @RequestMapping("/addView")
    public String userAddView() {

        return "user/userAdd";
    }
    //普通用户信息加载
    //加载列表界面
    @RequestMapping("/userView1")
    public String showUser1() {
        return "user/user1";
    }

    @RequestMapping(value = "/userAdd", method = RequestMethod.POST)
    @ResponseBody
    public String userAdd(@RequestBody User user) {
        int insert = userService.insert(user);
        if (insert < 0) {
            return "error";
        }
        return "success";
    }

    //page=1&limit=10
    @RequestMapping(value = "/userList", method = RequestMethod.GET)
    public @ResponseBody
    Map<String, Object> showUserList(@RequestParam("page") int page, @RequestParam("limit") int limit,
                                     String keyword1, String keyword2) {
        System.out.println("keyword1 = " + keyword1);
        System.out.println("keyword2 = " + keyword2);
        //查询结果集对象
        List<User> countData = userService.selectAll(keyword1, keyword2);
        //封装json数据
        Map<String, Object> resultMap = new HashMap<String, Object>();
        //分页
        if (page < 0) {
            page = 1;
            PageHelper.startPage(page, limit);
        }
        List<User> users = userService.selectAll(keyword1, keyword2);
        resultMap.put("code", 0);
        resultMap.put("msg", "");
        //结果总数
        resultMap.put("count", countData.size());
        //结果对象数据
        resultMap.put("data", users);
        return resultMap;
    }


    //获取普通登录用户信息
    @RequestMapping("/showuser")
    @ResponseBody
    public Map<String, Object> showuser(){
        User user = UserContext.getCurrentUser();
        List<User> userList = new ArrayList<>();
        userList.add(user);
        //封装json数据
        Map<String, Object> resultMap = new HashMap<String, Object>();
        resultMap.put("code", 0);
        resultMap.put("msg", "");
        //结果对象数据
        resultMap.put("data", userList);
        return resultMap;
    }


    @RequestMapping("/delete")
    @ResponseBody
    public String delete(@RequestParam("id") Long id) {
        System.out.println("id = " + id);
        int index = userService.deleteByPrimaryKey(id);
        if (index > 0) {
            return "success";
        }
        //删除失败返回error
        return "error";
    }

    @RequestMapping("/update")
    @ResponseBody
    public String update(@RequestBody User user) {
        if (user != null) {
            int index = userService.updateByPrimaryKey(user);
            if (index > 0) {
                return "success";
            }
        }
        return "error";
    }
    @RequestMapping("/update1")
    @ResponseBody
    public String update1(@RequestBody User user) {
        if (user != null) {
            int index = userService.updateByPrimaryKey1(user);
            if (index > 0) {
                return "success";
            }
        }
        return "error";
    }

}
