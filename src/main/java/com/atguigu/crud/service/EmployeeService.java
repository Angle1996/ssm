package com.atguigu.crud.service;

import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.bean.EmployeeExample;
import com.atguigu.crud.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Description
 * @Author Satan
 * @Date 2020/2/2023:56
 * @Version 1.0
 */
@Service
public class EmployeeService {
	@Autowired
	EmployeeMapper employeeMapper;

	public List<Employee> getAll() {

		EmployeeExample employeeExample=new EmployeeExample();
		employeeExample.setOrderByClause("emp_id");
		return employeeMapper.selectByExampleWithDept(employeeExample);
	}

	public void saveEmp(Employee employee) {
		employeeMapper.insertSelective(employee);
	}

	public boolean checkUser(String empName) {
		EmployeeExample example=new EmployeeExample();
		EmployeeExample.Criteria criteria = example.createCriteria();
		criteria.andEmpNameEqualTo(empName);
		long count = employeeMapper.countByExample(example);
		return count==0;
	}
}
