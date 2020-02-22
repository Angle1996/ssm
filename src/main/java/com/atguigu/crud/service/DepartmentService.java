package com.atguigu.crud.service;

import com.atguigu.crud.bean.Department;
import com.atguigu.crud.dao.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Description
 * @Author Satan
 * @Date 2020/2/2214:30
 * @Version 1.0
 */
@Service
public class DepartmentService {

	@Autowired
	DepartmentMapper departmentMapper;
	public List<Department> getDepts() {
		List<Department> list = departmentMapper.selectByExample(null);
		return list;
	}
}
