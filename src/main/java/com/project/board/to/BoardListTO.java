package com.project.board.to;

import java.sql.Date;
import java.util.ArrayList;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BoardListTO {

	private int cpage;
	private int recordPerPage;
	private int blockPerPage;
	private int totalPage;
	private int totalRecord;
	private int startBlock;
	private int endBlock;
	
	private ArrayList<BoardTO> boardLists;
	
	public BoardListTO() {
		this.recordPerPage = 10;
		this.blockPerPage = 5;
		this.totalPage = 1;
		this.totalRecord = 0;
	}
}
