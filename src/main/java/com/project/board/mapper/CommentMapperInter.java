package com.project.board.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.project.board.to.CommentTO;

@Mapper
public interface CommentMapperInter {

	@Select("select cmtSeq, userSeq, productSeq, id, nickName, cmtGrp, cmtGrps, cmtGrpl, cmtContent, cmtRegDate "
			+ "from comment_table where productSeq=#{productSeq} order by cmtGrp desc, cmtGrps asc")
	ArrayList<CommentTO> commentList(CommentTO to);
	
	@Select("select max(cmtGrpl) from comment_table where productSeq=#{productSeq}")
	int cmtGrpl(int productSeq);
}

/*
	-> cmtSeq int NOT NULL PRIMARY KEY auto_increment,
    -> userSeq int NOT NULL,
    -> productSeq int NOT NULL,
    -> id varchar(30) NOT NULL,
    -> nickName varchar(20) NULL,
    -> cmtGrp int NOT NULL,
    -> cmtGrps int NOT NULL,
    -> cmtGrpl int NOT NULL,
    -> cmtContent varchar(2000) NULL,
    -> cmtRegDate date NOT NULL,
 */
