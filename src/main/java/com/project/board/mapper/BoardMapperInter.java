package com.project.board.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.project.board.to.BoardTO;

@Mapper
public interface BoardMapperInter {

	// 게시물 작성
	@Insert("insert into product_table values (0, #{userSeq}, #{id}, #{nickName}, #{productName}, #{productCategory}, #{productFileName}, #{productContent}, now(), 0, 0.0)")
	public int boardWrite_ok(BoardTO to);
	
	// 저장된 게시물 불러오기(productSeq 번호가 큰수부터 출력)
	@Select("select productSeq, userSeq, id, nickName, productName, productCategory, productFilename, productContent, productWriteDate, productHit, productGrade, datediff(now(), productWriteDate) wgap from product_table order by productSeq desc")
	public ArrayList<BoardTO> boardDefaultList();
	
	@Select("select productSeq, userSeq, id, nickName, productName, productCategory, productFilename, productContent, productWriteDate, productHit, productGrade, datediff(now(), productWriteDate) wgap from product_table order by productHit desc")
	public ArrayList<BoardTO> boardHitList();
	
	@Select("select productSeq, userSeq, id, nickName, productName, productCategory, productFilename, productContent, productWriteDate, productHit, productGrade, datediff(now(), productWriteDate) wgap from product_table order by productGrade desc")
	public ArrayList<BoardTO> boardGradeList();
	
	@Select("select productSeq, userSeq, id, nickName, productName, productCategory, productFilename, productContent, productWriteDate, productHit, productGrade, datediff(now(), productWriteDate) wgap from product_table where productName like #{productName} order by productSeq desc")
	public ArrayList<BoardTO> boardAllSearchList(BoardTO to);
	
	@Select("select productSeq, userSeq, id, nickName, productName, productCategory, productFilename, productContent, productWriteDate, productHit, productGrade, datediff(now(), productWriteDate) wgap from product_table where productCategory=#{productCategory} order by productSeq desc")
	public ArrayList<BoardTO> boardNoAllNoSearchList(BoardTO to);
	
	@Select("select productSeq, userSeq, id, nickName, productName, productCategory, productFilename, productContent, productWriteDate, productHit, productGrade, datediff(now(), productWriteDate) wgap from product_table where productCategory=#{productCategory} and productName like #{productName} order by productSeq desc")
	public ArrayList<BoardTO> boardNoAllSearchList(BoardTO to);
	
	// 카테고리 불러오기
	@Select("select distinct productCategory from product_table")
	public ArrayList<String> productCategory();
	
	@Select("select productName from product_table where productCategory like #{productCategory}")
	public ArrayList<String> productSearchListData(String productCategory);
	
	// 조회수 올리기
	@Update("update product_table set productHit=productHit+1 where productSeq=#{productSeq}")
	public void hitUp(BoardTO to);
	
	// 저장된 게시물 불러오기(productSeq를 key값으로 불러오기
	@Select("select productSeq, userSeq, id, nickName, productName, productCategory, productFilename, productContent, productWriteDate, productHit, productGrade, datediff(now(), productWriteDate) wgap from product_table where productSeq=#{productSeq}")
	public BoardTO boardView(BoardTO to);
	
	@Select("select productSeq, userSeq, id, nickName, productName, productCategory, productFilename, productContent, productWriteDate, productHit, productGrade from product_table where productSeq=#{productSeq}")
	public BoardTO boardModify(BoardTO to);
	
	@Select("select productFileName from product_table where productSeq=#{productSeq}")
	public String oldFilename(int productSeq);
	
	@Update("update product_table set productCategory=#{productCategory}, productName=#{productName}, productContent=#{productContent} where productSeq=#{productSeq}")
	public int boardModify_ok_noImage(BoardTO to);
	
	@Update("update product_table set productCategory=#{productCategory}, productName=#{productName}, productContent=#{productContent}, productFileName=#{productFileName} where productSeq=#{productSeq}")
	public int boardModify_ok_image(BoardTO to);
	
	@Select("select productSeq, userSeq, id, nickName, productName, productCategory from product_table where productSeq=#{productSeq}")
	public BoardTO boardDelete(BoardTO to);
	
	@Delete("delete from product_table where productSeq=#{productSeq}")
	public int boardDelete_ok(BoardTO to);
	
	@Update("update product_table set productGrade=#{avg} where productSeq=#{seq}")
	void gradeAVGUdate(double avg, int seq);
	
}
