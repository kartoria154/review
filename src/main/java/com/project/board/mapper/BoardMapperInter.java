package com.project.board.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;

import com.project.board.to.BoardTO;

@Mapper
public interface BoardMapperInter {

	@Insert("insert into product_table values (0, #{userSeq}, #{id}, #{nickName}, #{productName}, #{productCategory}, #{productFileName}, #{productContent}, now(), 0, 0.0)")
	public int boardWrite_ok(BoardTO to);
}
