package com.iarchie.crm_v1.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class DocTest {
    private Long id;

    private String docname;

    private String docmsg;

    private String useraction;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date createtime;

    public Date getCreatetime() {
        return createtime;
    }

    public void setCreatetime(Date createtime) {
        this.createtime = createtime;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getDocname() {
        return docname;
    }

    public void setDocname(String docname) {
        this.docname = docname == null ? null : docname.trim();
    }

    public String getDocmsg() {
        return docmsg;
    }

    public void setDocmsg(String docmsg) {
        this.docmsg = docmsg == null ? null : docmsg.trim();
    }

    public String getUseraction() {
        return useraction;
    }

    public void setUseraction(String useraction) {
        this.useraction = useraction == null ? null : useraction.trim();
    }
}