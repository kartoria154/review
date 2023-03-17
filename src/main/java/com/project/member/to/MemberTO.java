package com.project.member.to;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MemberTO {
	
	private int userSeq;
	private String id;
	private String password;
	private String userName;
	private String nickName;
	private Date regDate;
}
