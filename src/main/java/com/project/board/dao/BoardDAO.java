package com.project.board.dao;

import java.util.ArrayList;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.board.mapper.BoardMapperInter;
import com.project.board.to.BoardListTO;
import com.project.board.to.BoardTO;

@Repository
@MapperScan("com.project.board.mapper")
public class BoardDAO {

	@Autowired
	private BoardMapperInter boardMapperInter;
	
	
	public int boardWrite_ok(BoardTO to) {
		// 성공시 result는 1
		int result = boardMapperInter.boardWrite_ok(to);
		// flag가 1일시 db에 저장 실패, 0이면 정상 작동
		int flag = 1;
		if(result == 1) {
			flag = 0;
		}
		return flag;
	}
	
	public BoardListTO boardList(BoardListTO listTO){
		// db에 조회 후 데이터 저장
		ArrayList<BoardTO> boardList = boardMapperInter.boardList();
		// 데이터의 총 갯수
		listTO.setTotalRecord(boardList.size());
		// 전체 페이지 = 데이터의 총 갯수 / 한 페이지에 보일 게시물 갯수 + 1 (소수점은 내림)
		listTO.setTotalPage( ( ( listTO.getTotalRecord() -1 ) / listTO.getRecordPerPage() ) + 1 );
		// 현재 페이지에 보여줄 게시물 선별을 위한 변수
		int skip = (listTO.getCpage() - 1) * listTO.getRecordPerPage();
		
		ArrayList<BoardTO> lists = new ArrayList<BoardTO>();
		for(int i = skip; i < skip + listTO.getRecordPerPage() && i < listTO.getTotalRecord(); i++) {
			BoardTO to = new BoardTO();
			to.setProductSeq(boardList.get(i).getProductSeq());
			to.setUserSeq(boardList.get(i).getUserSeq());
			to.setId(boardList.get(i).getId());
			to.setNickName(boardList.get(i).getNickName());
			to.setProductName(boardList.get(i).getProductName());
			to.setProductCategory(boardList.get(i).getProductCategory());
			to.setProductFileName(boardList.get(i).getProductFileName());
			to.setProductContent(boardList.get(i).getProductContent());
			to.setProductWriteDate(boardList.get(i).getProductWriteDate());
			to.setProductHit(boardList.get(i).getProductHit());
			to.setProductGrade(boardList.get(i).getProductGrade());
			
			lists.add(to);
		}
		listTO.setBoardLists( lists );
		
		listTO.setStartBlock( listTO.getCpage() - (listTO.getCpage()-1) % listTO.getBlockPerPage() );
		listTO.setEndBlock( listTO.getCpage() - (listTO.getCpage()-1) % listTO.getBlockPerPage() + listTO.getBlockPerPage() - 1 );
		if( listTO.getEndBlock() >= listTO.getTotalPage() ) {
			listTO.setEndBlock( listTO.getTotalPage() );
		}
		
		return listTO;
	}
	
}
