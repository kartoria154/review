package com.project.board.to;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CommentTO {

	private int cmtSeq;
	private int userSeq;
	private int productSeq;
	private String id;
	private String nickName;
	private int cmtGrp;
	private int cmtGrps;
	private int cmtGrpl;
	private String cmtContent;
	private double cmtGrade;
	private Date cmtRegDate;
	
}
