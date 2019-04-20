package com.iarchie.crm_v1.mapper;

import com.iarchie.crm_v1.domain.Department;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public interface DepartmentMapper {
    int deleteByPrimaryKey(Long id);

    int insert(Department record);

    Department selectByPrimaryKey(Long id);

    List<Department> selectAll(@Param("keyword") String keyword);

    int updateByPrimaryKey(Department record);
}