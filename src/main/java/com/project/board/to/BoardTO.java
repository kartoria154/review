package com.project.board.to;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BoardTO {

	private int productSeq;
	private int userSeq;
	private String id;
	private String nickName;
	private String productName;
	private String productCategory;
	private String productFileName;
	private String productContent;
	private Date productWriteDate;
	private int productHit;
	private double productGrade;
	private int wgap;
}
