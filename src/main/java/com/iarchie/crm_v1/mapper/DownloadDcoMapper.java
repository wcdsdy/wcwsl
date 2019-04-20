package com.iarchie.crm_v1.mapper;

import com.iarchie.crm_v1.domain.DownloadDco;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public interface DownloadDcoMapper {
    int deleteByPrimaryKey(Long id);

    int insert(DownloadDco record);

    DownloadDco selectByPrimaryKey(Long id);

    List<DownloadDco> selectAll();

    int updateByPrimaryKey(DownloadDco record);
}