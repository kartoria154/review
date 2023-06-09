package com.project.board.dao;

import java.io.File;
import java.util.ArrayList;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.board.mapper.BoardMapperInter;
import com.project.board.mapper.CommentMapperInter;
import com.project.board.to.BoardListTO;
import com.project.board.to.BoardTO;


@Repository
@MapperScan("com.project.board.mapper")
public class BoardDAO {
	
	private String uploadPath = "C:/Users/a0104/OneDrive/바탕 화면/solo/workspace/Review/src/main/webapp/upload";
	
	@Autowired
	private BoardMapperInter boardMapperInter;
	
	@Autowired
	private CommentMapperInter commentMapperInter;
	
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
	
	public BoardListTO boardList(BoardListTO listTO, BoardTO bTo, int searchData){
		ArrayList<BoardTO> boardList = new ArrayList<BoardTO>();
	
		// db에 조회 후 데이터 저장
		if(searchData == 0) {
			boardList = boardMapperInter.boardDefaultList();
		} else if(searchData == 1) {
			boardList = boardMapperInter.boardHitList();
		} else if(searchData == 2) {
			boardList = boardMapperInter.boardGradeList();
		} else if(searchData == 3) {
			bTo.setProductName("%"+bTo.getProductName()+"%");
			System.out.println(bTo.getProductCategory());
			System.out.println(bTo.getProductName());
			boardList = boardMapperInter.searchList(bTo);
		}
		
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
	
	public ArrayList<String> productCategory(){
		ArrayList<String> categoryList = boardMapperInter.productCategory();
		return categoryList;
	}
	
	public ArrayList<String> productSearchListData(String productCategory){
		ArrayList<String> listData = boardMapperInter.productSearchListData(productCategory);
		return listData;
	}
	
	public BoardTO boardView(BoardTO to) {
		boardMapperInter.hitUp(to);
		to = boardMapperInter.boardView(to);
		return to;
	}
	
	public BoardTO boardModify(BoardTO to) {
		to = boardMapperInter.boardModify(to);
		return to;
	}
	
	public int boardModify_ok(BoardTO to) {
		int flag = 2;
		int result = 2;
		// 새로운 사진 파일을 업로드가 없을시
		if(to.getProductFileName() == null) {
			result = boardMapperInter.boardModify_ok_noImage(to);
		} 
		// 새로운 사진 파일을 업로드 했을시
		else {
			// 글번호 저장
			int productSeq = to.getProductSeq();
			// 기존 사진파일 이름 저장
			String oldFilename = boardMapperInter.oldFilename(productSeq);
			result = boardMapperInter.boardModify_ok_image(to);
			if(result == 0) {
				// DB에 업데이트 실패시 Controller에서 업로드한 이미지 파일 제거
				File file = new File(uploadPath, to.getProductFileName());
				file.delete();
			} else if (result == 1) {
				// DB에 업데이트 성공시 기존 이미지 파일 제거
				File file = new File(uploadPath, oldFilename);
				file.delete();
			}
		}
		
		if(result == 0) {
			flag = 1;
		} else if (result == 1) {
			flag = 0;
		}
		return flag;
	}
	
	public BoardTO boardDelete(BoardTO to) {
		to = boardMapperInter.boardDelete(to);
		return to;
	}
	
	public int boardDelete_ok(BoardTO to) {
		int productSeq = to.getProductSeq();
		String filename = boardMapperInter.oldFilename(productSeq);
		int flag = 2;
		commentMapperInter.boardDeleteComment(productSeq);
		int result = boardMapperInter.boardDelete_ok(to);
		if(result == 0) {
			flag = 1; 
		} else if(result == 1) {
			flag = 0;
			File file = new File(uploadPath, filename);
			file.delete();
		}
		return flag;
	}
}
