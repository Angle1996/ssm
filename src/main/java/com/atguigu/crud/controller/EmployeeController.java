package com.atguigu.crud.controller;

import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.bean.Msg;
import com.atguigu.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.validation.Valid;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

	//检查用户名是否可用
	@ResponseBody
	@RequestMapping("/checkUser")
	public Msg checkUser(String empName){
		//先判断用户名是否是合法的表达式;
		String regex = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})";
		if(!empName.matches(regex)){
			return Msg.fail().add("va_msg", "用户名必须是6-16位数字和字母的组合或者2-5位中文");
		}
		//数据库用户名重复校验
		boolean flag=employeeService.checkUser(empName);
		if(flag){
			return Msg.success();
		}else{
			return Msg.fail().add("va_msg", "用户名不可用");
		}
	}
	@ResponseBody
	@RequestMapping(value = "/emp",method = RequestMethod.POST)
	public Msg saveEmp(@Valid Employee employee, BindingResult result){
		if (result.hasErrors()){
			//校验失败，应该返回失败，在模态框中显示校验失败的错误信息
			Map<String, Object> map = new HashMap<>();
			List<FieldError> errors = result.getFieldErrors();
			for (FieldError fieldError : errors) {
				System.out.println("错误的字段名："+fieldError.getField());
				System.out.println("错误信息："+fieldError.getDefaultMessage());
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorFields", map);
		}else{
			employeeService.saveEmp(employee);
			return Msg.success();
		}
	}

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
