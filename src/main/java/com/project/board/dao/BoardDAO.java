package com.project.board.dao;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.board.mapper.BoardMapperInter;

@Repository
@MapperScan("com.project.board.mapper")
public class BoardDAO {

	@Autowired
	private BoardMapperInter boardMapperInter;
}
