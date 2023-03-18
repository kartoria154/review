package com.project.member.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.project.member.to.MemberTO;

@Mapper
public interface MemberMapperInter {
	
	@Select("select userSeq, id, password, userName, nickName, regDate from user_table "
			+ "where id = #{id} and password = HEX(AES_ENCRYPT(#{password}, SHA2('apfh2009@naver.com', 256)))")
	public MemberTO login_ok(MemberTO to);
	
	@Insert("insert into user_table values (0, #{id}, HEX(AES_ENCRYPT(#{password}, SHA2('apfh2009@naver.com', 256))), #{userName}, #{nickName}, now())")
	public int joinMember_ok(MemberTO to);
}
