package com.atguigu.crud.controller;

import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.bean.Msg;
import com.atguigu.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @Description
 * @Author Satan
 * @Date 2020/2/2023:39
 * @Version 1.0
 */
@Controller
public class EmployeeController {
	@Autowired
	EmployeeService employeeService;

	@ResponseBody
	@RequestMapping("/emps")
	public Msg getEmpsWithJson(@RequestParam(value = "pageNum",defaultValue = "1")Integer pageNum, Model model){
		PageHelper.startPage(pageNum, 8);
		List<Employee> emps=employeeService.getAll();
		//传入结果和需要连续显示的页数
		PageInfo pageInfo=new PageInfo(emps,5);
		return Msg.success().add("pageInfo", pageInfo);
	}



//	@RequestMapping("/emps")
	public String getEmps(@RequestParam(value = "pageNum",defaultValue = "1")Integer pageNum, Model model){
		PageHelper.startPage(pageNum, 8);
		List<Employee> emps=employeeService.getAll();
		//传入结果和需要连续显示的页数
		PageInfo pageInfo=new PageInfo(emps,5);
		model.addAttribute("pageInfo", pageInfo);
		return "list";
	}
}
