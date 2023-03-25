package com.project.board.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.project.board.to.BoardTO;

@Mapper
public interface BoardMapperInter {

	@Insert("insert into product_table values (0, #{userSeq}, #{id}, #{nickName}, #{productName}, #{productCategory}, #{productFileName}, #{productContent}, now(), 0, 0.0)")
	public int boardWrite_ok(BoardTO to);
	
	@Select("select productSeq, userSeq, id, nickName, productName, productCategory, productFilename, productContent, productWriteDate, productHit, productGrade, datediff(now(), productWriteDate) wgap from product_table order by productSeq desc")
	public ArrayList<BoardTO> boardList();
}
