package com.project.board.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.project.board.to.CommentTO;

@Mapper
public interface CommentMapperInter {

	@Select("select cmtSeq, userSeq, productSeq, id, nickName, cmtGrp, cmtGrps, cmtGrpl, cmtContent, cmtRegDate, cmtGrade "
			+ "from comment_table where productSeq=#{productSeq} order by cmtGrp desc, cmtGrps asc")
	ArrayList<CommentTO> commentList(CommentTO to);
	
	@Select("select max(cmtGrpl) from comment_table where productSeq=#{productSeq}")
	int cmtMaxGrpl(int productSeq);
	
	@Select("select max(cmtGrp) cmtMaxGrp from comment_table where productSeq=#{productSeq}")
	String cmtMaxGrp(int productSeq);
	
	@Insert("insert into comment_table values (0, #{userSeq}, #{productSeq}, #{id}, #{nickName}, #{cmtGrp}, 0, 0, #{cmtContent}, now(), #{cmtGrade})")
	int cmtParentWrite_ok(CommentTO to);
	
	@Select("select round(AVG(cmtGrade), 2) gradeAVG from comment_table where productSeq=#{productSeq} and cmtGrpl=0 and userSeq!=7")
	String gradeAVG(int productSeq);
	
	@Select("select cmtGrp, cmtGrps, cmtgrpl from comment_table where cmtSeq=#{parentSeq}")
	CommentTO cmtParentGrp(int parentSeq);
	
	@Update("update comment_table set cmtGrps=cmtGrps+1 where cmtGrp=#{cmtGrp} and cmtGrps>#{cmtGrps}")
	void cmtParentsUP(CommentTO pTO);
	
	@Insert("insert into comment_table values (0, #{userSeq}, #{productSeq}, #{id}, #{nickName}, #{cmtGrp}, #{cmtGrps}+1, #{cmtGrpl}+1, #{cmtContent}, now(), 0)")
	int cmtReplyWrite_ok(CommentTO to);
	
	@Update("update comment_table set cmtContent=#{cmtContent}, cmtGrade=#{cmtGrade} where cmtSeq=#{cmtSeq}")
	int cmtParentModify_ok(CommentTO to);
	
	@Update("update comment_table set cmtContent=#{cmtContent} where cmtSeq=#{cmtSeq}")
	int cmtReplyModify_ok(CommentTO to);
	
	@Update("update comment_table set userSeq=7, id='삭제된 글입니다', nickName='삭제된 글입니다', cmtContent='삭제된 글입니다', cmtGrade=0 where cmtSeq=#{cmtSeq}")
	int cmtReplyDelete_ok(CommentTO to);
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
