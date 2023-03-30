package com.project.board.dao;

import java.util.ArrayList;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.board.mapper.CommentMapperInter;
import com.project.board.to.CommentTO;


@Repository
@MapperScan("com.project.board.mapper")
public class CommentDAO {
	
	@Autowired
	private CommentMapperInter commentMapperInter;
	
	public ArrayList<CommentTO> commentList(CommentTO to){
		ArrayList<CommentTO> commentList = commentMapperInter.commentList(to);
		return commentList;
	}
	
	public int cmtMaxGrpl(int productSeq){
		int cmtMaxGrpl = commentMapperInter.cmtGrpl(productSeq);
		return cmtMaxGrpl;
	}
}
