package com.project.board.to;

import java.util.ArrayList;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BoardListTO {
	// 현재 페이지
	private int cpage;
	// 한 페이지에 보여줄 게시물 갯수
	private int recordPerPage;
	// 페이징 칸에 표시될 숫자 갯수
	private int blockPerPage;
	// 게시물 갯수에 따른 전체 페이지 수
	private int totalPage;
	// 전체 게시물 수
	private int totalRecord;
	// 페이징 칸에 표시될 숫자의 시작 수
	private int startBlock;
	// 페이징 칸에 표시될 숫자의 마지막 수
	private int endBlock;
	// 게시물이 저장되는 공간
	private ArrayList<BoardTO> boardLists;
	
	// 기본 값을 세팅
	public BoardListTO() {
		this.recordPerPage = 10;
		this.blockPerPage = 5;
		this.totalPage = 1;
		this.totalRecord = 0;
	}
}
