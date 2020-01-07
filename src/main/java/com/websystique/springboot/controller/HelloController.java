package com.websystique.springboot.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HelloController {

	@RequestMapping("/")
	String home(ModelMap modal) {
		modal.addAttribute("title", "Dear Xpanxioneurs");
		modal.addAttribute("message", "Welcome to Xpanxion Family");
		modal.addAttribute("message1", "Welcome to K8s World..!");
		return "hello";
	}
}
