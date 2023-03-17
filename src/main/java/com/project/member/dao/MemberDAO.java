package com.project.member.dao;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.board.mapper.BoardMapperInter;
import com.project.board.mapper.CommentMapperInter;
import com.project.member.mapper.MemberMapperInter;

@Repository
@MapperScan(value = {"com.project.member.mapper", "com.project.board.mapper"})
public class MemberDAO {

	@Autowired
	private MemberMapperInter memberMapperInter;
	
	@Autowired
	private BoardMapperInter boardMapperInter;
	
	@Autowired
	private CommentMapperInter commentMapperInter;
}
