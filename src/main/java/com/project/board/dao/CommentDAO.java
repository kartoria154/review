package com.project.board.dao;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.board.mapper.CommentMapperInter;


@Repository
@MapperScan("com.project.board.mapper")
public class CommentDAO {
	
	@Autowired
	private CommentMapperInter commentMapperInter;
}
