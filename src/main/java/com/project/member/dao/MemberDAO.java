package com.project.member.dao;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.board.mapper.BoardMapperInter;
import com.project.board.mapper.CommentMapperInter;
import com.project.member.mapper.MemberMapperInter;
import com.project.member.to.MemberTO;

@Repository
@MapperScan(value = {"com.project.member.mapper", "com.project.board.mapper"})
public class MemberDAO {

	@Autowired
	private MemberMapperInter memberMapperInter;
	
	@Autowired
	private BoardMapperInter boardMapperInter;
	
	@Autowired
	private CommentMapperInter commentMapperInter;
	
	// controller에서 받은 데이터 mapper로 db에 조회
	public MemberTO login_ok(MemberTO to) {
		to = memberMapperInter.login_ok(to);
		return to;
	}
	
	// id 중복검사
	public int id_check(MemberTO to) {
		// result값이 1이면 입력받은 id가 있다는 뜻
		int result = memberMapperInter.id_check(to);
		// flag는 입력 받은 데이터를 mapper 실행 후 처리 내용을 숫자로 반영. 
		// 1이면 실패(또는 없는 데이터), 0이면 정상작동
		int flag = 1;
		if(result == 1) {
			flag = 0;
		}
		return flag;
	}
	
	// controller에서 받은 데이터 mapper로 db에 등록
	public int joinMember_ok(MemberTO to) {
		// 사용자가 nickName를 입력하지 않으면 userName로 대체
		if(to.getNickName() == "") {
			to.setNickName(to.getUserName());
		}
		// 정상 작동시 1, 아니면 0
		int result = memberMapperInter.joinMember_ok(to);
		// flag는 입력 받은 데이터를 db에 조회한 후 처리 내용을 숫자로 반영. 
		// 1이면 실패(또는 없는 데이터), 0이면 정상작동
		int flag = 1;
		if(result == 1 ) {
			flag = 0;
		}
		return flag;	
	}
	
	public int membar_check(MemberTO to) {
		int result = memberMapperInter.member_check(to);
		return result;
	}
	

}
