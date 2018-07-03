package com.hh.herb.board.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BookDAOMybatis implements BookDAO {
	private String namespace = "config.mybatis.mapper.oracle.board.";
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public insertBook() {
		
	}
}
