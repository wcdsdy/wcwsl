package com.iarchie.crm_v1.mapper;

import com.iarchie.crm_v1.domain.Employee;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public interface EmployeeMapper {
    int deleteByPrimaryKey(Long id);

    int insert(Employee record);

    Employee selectByPrimaryKey(Long id);

    List<Employee> selectAll();

    int updateByPrimaryKey(Employee record);
    int updateByPrimaryKey1(Employee record);
}