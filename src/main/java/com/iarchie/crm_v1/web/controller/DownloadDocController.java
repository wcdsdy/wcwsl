package com.iarchie.crm_v1.web.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.iarchie.crm_v1.context.UserContext;
import com.iarchie.crm_v1.domain.DownloadDco;
import com.iarchie.crm_v1.domain.User;
import com.iarchie.crm_v1.service.IDownloadService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import java.io.*;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 类描述信息 下载中心处理类
 *
 * @author Tomlin
 * @ClassName DownloadDocController
 * @Description: TODO
 * @date 2018/12/30 14:23
 * @Viersion V1.0.1
 */

@Controller
@RequestMapping("/download")
public class DownloadDocController {


    @Autowired
    private IDownloadService downloadService;

    @RequestMapping("/downloadView")
    public String downView(Model model, Integer pageIndex) {
        int pageSize = 5;//每页显示的记录数
        if (pageIndex == null)
            pageIndex = 1;//第一次访问页面默认页面为第一页
        PageHelper.startPage(pageIndex, pageSize);
        List<DownloadDco> downloadDcoList = downloadService.selectAll();
        //得到分页的结果对象
        PageInfo<DownloadDco> personPageInfo = new PageInfo<>(downloadDcoList);
        //得到分页中的person条目对象
        List<DownloadDco> pageList = personPageInfo.getList();
        model.addAttribute("downloadDcoList", pageList);
        model.addAttribute("page", personPageInfo);
        return "documentFile/fileDoc";
    }


    @RequestMapping("/uploadView")
    public String uploadView() {
        return "documentFile/uploadFile";
    }


    //保存数据
    @RequestMapping(value = "/fileSave")
    @ResponseBody
    public String FileUpload(HttpServletRequest request, HttpServletResponse response,MultipartFile mf, HttpSession session) {
        String filemsg = request.getParameter("filemsg");
        String filename = mf.getOriginalFilename();
        DownloadDco downloadDco = new DownloadDco();
        User user = UserContext.getCurrentUser();
        String fileadmin = user.getLoginname();
        downloadDco.setFileadmin(fileadmin);
        downloadDco.setFilename(filename);
        downloadDco.setFilemsg(filemsg);
        //文件所放路径位置
        String path = session.getServletContext().getRealPath("upload/");
        System.out.println(filename +","+path);
        downloadDco.setFilepath(path);
            File f = new File(path + mf.getOriginalFilename());
            try {
                //写入文件
                mf.transferTo(f);
            } catch (IOException e) {
                e.printStackTrace();
            }
            System.out.println(11111111);
            Map<String,Object> map = new HashMap<>();
            map.put("code",0);
            map.put("msg","");
            Map<String,Object> data = new HashMap<>();
            data.put("src",path + mf.getOriginalFilename());
            map.put("data",data);
        try {
            PrintWriter out =response.getWriter();
            out.write(JSON.toJSONString(map));
            out.flush();
            out.close();
        } catch (IOException e) {
            e.printStackTrace();
        }

        int insert = downloadService.insert(downloadDco);
            if (insert != 0) {
                return "success";
            }
        return "error";
    }
    //文件下载
    @RequestMapping("fileDown")
    public String fileDownload(@RequestParam("id") Long id , HttpServletRequest req, HttpServletResponse response){
        DownloadDco downloadDco = downloadService.selectByPrimaryKey(id);
        String name = downloadDco.getFilename();
        //获取文件保存的路径
        String fileName = req.getServletContext().getRealPath("upload/");
        //fileName是要下载文件的磁盘绝对路径
        fileName += name;
        InputStream f = null;
        System.out.println("要下载的文件是：" +  fileName);
        try {
            f = new FileInputStream(fileName);
            System.out.println("下载：" + fileName);
            response.reset();
            response.setHeader("Content-Disposition",
                    "attachment; filename=\"" + name + "\"");
            //设置下载文件的大小信息
            response.addHeader("Content-Length", "" + f.available());
            //设置文件response返回的内容类型，浏览器接收到这个类型就会以下载文件形式处理
            response.setContentType("application/octet-stream;charset=UTF-8");
            OutputStream outputStream = new BufferedOutputStream(
                    response.getOutputStream());

            //把文件数据写入到outputstream中
            byte b[] = new byte[1024];
            int len = f.read(b);
            while (len != -1) {
                outputStream.write(b);
                len = f.read(b);
            }

            outputStream.flush();
            outputStream.close();
        } catch (IOException e1) {
            // TODO Auto-generated catch block
            e1.printStackTrace();
        }


        return null;
    }
}
