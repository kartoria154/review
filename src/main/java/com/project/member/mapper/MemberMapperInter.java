package com.project.member.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.project.member.to.MemberTO;

@Mapper
public interface MemberMapperInter {
	
	// 회원데이터 조회
	@Select("select userSeq, id, password, userName, nickName, regDate from user_table "
			+ "where id = #{id} and password = HEX(AES_ENCRYPT(#{password}, SHA2('apfh2009@naver.com', 256)))")
	public MemberTO login_ok(MemberTO to);
	
	// 아이디 중복 검사
	@Select("select count(id) id from user_table where id=#{id}")
	public int id_check(MemberTO to);
	
	// 회원데이터 db에 저장
	@Insert("insert into user_table values (0, #{id}, HEX(AES_ENCRYPT(#{password}, SHA2('apfh2009@naver.com', 256))), #{userName}, #{nickName}, now())")
	public int joinMember_ok(MemberTO to);
	
	@Select("select count(id) from user_table where id=#{id} and password = HEX(AES_ENCRYPT(#{password}, SHA2('apfh2009@naver.com', 256)))")
	public int member_check(MemberTO to);
	
}
