package com.hh.herb.book.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.hh.herb.board.model.BookVO;

@Controller
@RequestMapping("/book")
public class BookController {
	private static final Logger logger = LoggerFactory.getLogger(BookController.class);

	@RequestMapping(value = "/write.do", method = RequestMethod.GET)
	public String write_get() {
		logger.info("글쓰기 화면");

		return "book/write";
	}
	
	@RequestMapping(value = "/write.do", method = RequestMethod.POST)
	public  write_post(@ModelAttribute BookVO vo) {
		logger.info("글쓰기 처리, 파라미터 vo = {}", vo);
		
		
	}

}
