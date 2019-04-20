package com.iarchie.crm_v1.mapper;

import com.iarchie.crm_v1.domain.Position;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public interface PositionMapper {
    int deleteByPrimaryKey(Long id);

    int insert(Position record);

    Position selectByPrimaryKey(Long id);

    List<Position> selectAll(@Param("keyword") String keyword);

    int updateByPrimaryKey(Position record);
}