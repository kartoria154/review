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
		int result = boardMapperInter.boardWrite_ok(to);
		int flag = 1;
		if(result == 1) {
			flag = 0;
		}
		return flag;
	}
	
	public BoardListTO boardList(BoardListTO listTO){
		ArrayList<BoardTO> boardList = boardMapperInter.boardList();
		listTO.setTotalRecord(boardList.size());
		listTO.setTotalPage( ( ( listTO.getTotalRecord() -1 ) / listTO.getRecordPerPage() ) + 1 );
		
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
