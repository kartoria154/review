package com.project.board.dao;

import java.util.ArrayList;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.board.mapper.BoardMapperInter;
import com.project.board.mapper.CommentMapperInter;
import com.project.board.to.CommentTO;


@Repository
@MapperScan("com.project.board.mapper")
public class CommentDAO {
	
	@Autowired
	private CommentMapperInter commentMapperInter;
	
	@Autowired
	private BoardMapperInter boardMapperInter;
	
	public ArrayList<CommentTO> commentList(CommentTO to){
		ArrayList<CommentTO> commentList = commentMapperInter.commentList(to);
		return commentList;
	}
	
	public int cmtMaxGrpl(int productSeq){
		int cmtMaxGrpl = commentMapperInter.cmtMaxGrpl(productSeq);
		return cmtMaxGrpl;
	}
	
	public int cmtParentWrite_ok(CommentTO to) {
		int flag = 1;
		int productSeq = to.getProductSeq();
		String cmtMaxGrp = commentMapperInter.cmtMaxGrp(productSeq);
		if(cmtMaxGrp == null) {
			to.setCmtGrp(0);
		} else {
			to.setCmtGrp(Integer.parseInt(cmtMaxGrp)+1);
		}
		int result = commentMapperInter.cmtParentWrite_ok(to);
		if(result == 1) {
			flag = 0;
			String gradeAVG = commentMapperInter.gradeAVG(productSeq);
			boardMapperInter.gradeAVGUdate(Double.parseDouble(gradeAVG), productSeq);
		}
		return flag;
	}
	
	public int cmtReplyWrite_ok(CommentTO to, int pseq) {
		CommentTO pTO = commentMapperInter.cmtParentGrp(pseq);
		to.setCmtGrp(pTO.getCmtGrp());
		to.setCmtGrps(pTO.getCmtGrps());
		to.setCmtGrpl(pTO.getCmtGrpl());
		commentMapperInter.cmtParentsUP(pTO);
		int result = commentMapperInter.cmtReplyWrite_ok(to);
		int flag = 1;
		if(result == 1) {
			flag = 0;
		}
		return flag;
	}
	
	public int cmtReplyModify_ok(CommentTO to) {
		int flag = 2;
		int result = commentMapperInter.cmtReplyModify_ok(to);
		if(result == 1) {
			flag = 0;
		} else if(result == 0) {
			flag = 1;
		}
		return flag;
	}
	
	public int cmtParentModify_ok(CommentTO to, int productSeq) {
		int flag = 2;
		int result = commentMapperInter.cmtParentModify_ok(to);
		if(result == 1) {
			flag = 0;
			String gradeAVG = commentMapperInter.gradeAVG(productSeq);
			boardMapperInter.gradeAVGUdate(Double.parseDouble(gradeAVG), productSeq);
		} else if(result == 0) {
			flag = 1;
		}
		return flag;
	}
	
	public int cmtReplyDelete_ok(CommentTO to, int productSeq) {
		int result = commentMapperInter.cmtReplyDelete_ok(to);
		int flag = 1;
		if(result == 1) {
			flag = 0;
			String gradeAVG = commentMapperInter.gradeAVG(productSeq);
			if(gradeAVG == null) {
				boardMapperInter.gradeAVGUdate(0, productSeq);
			} else {
				boardMapperInter.gradeAVGUdate(Double.parseDouble(gradeAVG), productSeq);
			}
		}
		return flag;
	}
}
