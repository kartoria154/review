package com.project.board.dao;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.board.mapper.BoardMapperInter;
import com.project.board.to.BoardTO;

@Repository
@MapperScan("com.project.board.mapper")
public class BoardDAO {

	@Autowired
	private BoardMapperInter boardMapperInter;
	
	public int boardWrite_ok(BoardTO to) {
		int result = boardMapperInter.boardWrite_ok(to);
		int flag = 1;
		if(result == 1) {
			flag = 0;
		}
		return flag;
	}
}
