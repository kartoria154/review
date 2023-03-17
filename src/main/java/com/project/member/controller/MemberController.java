package com.project.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RestController;

import com.project.member.dao.MemberDAO;

@RestController
public class MemberController {
	
	@Autowired
	private MemberDAO dao;
}
