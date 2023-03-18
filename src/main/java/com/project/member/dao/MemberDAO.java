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
	
	public MemberTO login_ok(MemberTO to) {
		to = memberMapperInter.login_ok(to);
		return to;
	}
	
	public int joinMember_ok(MemberTO to) {
		if(to.getNickName() == "") {
			to.setNickName(to.getUserName());
		}
		int result = memberMapperInter.joinMember_ok(to);
		int flag = 1;
		if(result == 1 ) {
			flag = 0;
		}
		return flag;
		
	}
}
